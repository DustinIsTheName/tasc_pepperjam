class Product < ActiveRecord::Base

  belongs_to :collection
  has_many :variants
end
