class Product < ApplicationRecord

  belongs_to :user, optional: true
  

  mount_uploader :image, ImageUploader

  validates :title,:price, :instock_quantity, presence: true
  validates :description, length: { maximum: 1024, too_long: "%{count} characters is the maximum aloud. "}
  validates :title, length: { maximum: 150, too_long: "%{count} characters is the maximum aloud. "}
  validates :price, length: { maximum: 10 }
  validates :instock_quantity, length: { maximum: 5}

#   BRAND = %w{ Fender Gibson Epiphone ESP Martin Dean Taylor Jackson PRS  Ibanez Charvel Washburn }

   
end
