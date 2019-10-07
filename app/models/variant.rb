class Variant < ActiveRecord::Base

  belongs_to :product

  serialize :options, Array
end
