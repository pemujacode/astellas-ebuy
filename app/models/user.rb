class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :validatable
  enum role: { User: 2, Supervisor:1 , Admin:0 }
  belongs_to :department, optional: true
  #after_initialize :default_values


def admin?
  has_role?(:Admin)
end

def client?
  has_role?(:User)
end 


def active_for_authentication?
    #remember to call the super
    #then put our own check to determine "active" state using 
    #our own "is_active" column
    super and self.is_active?
  end


private

  def default_values
    self.role ||= 'User'
    self.is_active ||= 'True'
    
  end

after_create :send_admin_mail
	def send_admin_mail
  		UserMailer.welcome_email(self).deliver_later
	end

end
