class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :authenticate_user!,:prepare_exception_notifier

	rescue_from CanCan::AccessDenied do |exception|
	  	redirect_to root_url, alert: exception.message

	end


	def default_url_options
	     if Rails.env.production?
	      {:host => "http://54.169.230.195:3000"}
	    else  
	      {}
	    end
	end
	
	private
	def prepare_exception_notifier
    		request.env["exception_notifier.exception_data"] = {
      			current_user: current_user
    		}
    	end

end
