class PoApproval < ApplicationRecord
	validates :requester, presence: true, uniqueness: true
	#validates :requester,:apv1 , :apv2,  format: { with: URI::MailTo::EMAIL_REGEXP } 
	

end
