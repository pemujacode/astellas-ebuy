class HomeController < ApplicationController
	
	def index
  		if user_signed_in?
  			@costcenters = Costcenter.all
  			
  		end

  	end

end
