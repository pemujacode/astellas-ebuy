class Supplier < ApplicationRecord

  	validates :code,:name, presence: true
    validates :code, uniqueness: true, length: { maximum: 20 }
    validates :name, length: { minimum: 3 }
  	validates :address, length: { maximum: 500 }
  	#validates :email,:allow_blank => true, format: { with: URI::MailTo::EMAIL_REGEXP } 

end
