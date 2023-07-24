class Costcenter < ApplicationRecord
	  validates :code, uniqueness: true
	  validates :code,:name, presence: true
      
end
