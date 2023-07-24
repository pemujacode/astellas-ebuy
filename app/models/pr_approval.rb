class PrApproval < ApplicationRecord
	validates :requester, presence: true
	#validates :requester,:apv1 , :apv2, :apv3,:apv4,  format: { with: URI::MailTo::EMAIL_REGEXP } 
	


end
