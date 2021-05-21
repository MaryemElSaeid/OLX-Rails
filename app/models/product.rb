class Product < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
  belongs_to :user, optional: true
  has_one_attached :image
  has_many :line_items
  belongs_to :brand
  

  

  # mount_uploader :image, ImageUploader
 
  
  # validates :image, presence: true, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }
  validates :title,:price, :instock_quantity, presence: true
  validates :description, length: { maximum: 1024, too_long: "%{count} characters is the maximum aloud. "}
  validates :title, length: { maximum: 150, too_long: "%{count} characters is the maximum aloud. "}
  validates :price, length: { maximum: 10 }
  validates :instock_quantity, length: { maximum: 5}

#   def to_param
#     return Brand.name 
#  end



private

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line items present")
      throw :abort
    end
  end

   
end
