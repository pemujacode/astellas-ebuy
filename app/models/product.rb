class Product < ApplicationRecord
		  validates :code, :name, uniqueness: true

end
