class Product < ApplicationRecord
  before_destroy :not_refereced_by_any_line_item
  belongs_to :user, optional: true
  has_one_attached :image
  has_many :line_items
  belongs_to :brand
  belongs_to :category
  belongs_to :store

 

  def self.search(keywords)
    if keywords
      where("title LIKE ? OR description LIKE ? " , "%#{keywords}%", "%#{keywords}%").order('id DESC')
    else
      order('id DESC') 
    end
  end

  

  # mount_uploader :image, ImageUploader
 
  
  # validates :image, presence: true, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }
  validates :title,:price, :instock_quantity, presence: true
  validates :description, length: { maximum: 1024, too_long: "%{count} characters maximum. "}
  validates :title, length: { maximum: 150, too_long: "%{count} character maximum. "}
  validates :price, length: { maximum: 10 }
  validates :instock_quantity, length: { maximum: 5}

#   def to_param
#     return Brand.name 
#  end



private

  def not_refereced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "present")
      throw :abort
    end
  end

   
end