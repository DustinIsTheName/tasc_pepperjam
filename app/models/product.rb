class Product < ActiveRecord::Base

  belongs_to :collection
  # has_many :variants

  serialize :options, Array
  serialize :variants, Array
end
