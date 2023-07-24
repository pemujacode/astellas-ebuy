class Currency < ApplicationRecord
	  validates :code, uniqueness: true
	  validates :code,:name, presence: true
      validates :code,:name, length: { minimum: 2 }
      validates :code,:name, length: { maximum: 100 }

end
