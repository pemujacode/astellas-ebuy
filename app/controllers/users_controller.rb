class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]
  

load_and_authorize_resource

 def show
 	unless params[:id].nil?
    

        if params[:id] == 'edit'
           @user = User.find(current_user.id)
        else
           @user = User.find(params[:id]) 
           if current_user.role == 'Admin' || @user.id == current_user.id
               @user = User.find(params[:id]) 
           else
                respond_to do |format|
                  format.html { redirect_to root_path,:action => 'index', alert: "You're not authorized to perform approval in this document." }
                end
           end
        end
    
    

	end
 end


 def index


  if current_user.role == 'Admin'
     @user = User.all
  else
    respond_to do |format|
          format.html { redirect_to root_path,:action => 'index', alert: "You're not authorized to perform approval in this document." }
  end 

  end

 end


 def edit
  @user = User.find(params[:id]) 
           if current_user.role == 'Admin' || @user.id == current_user.id
               @user = User.find(params[:id]) 
           else
                respond_to do |format|
                  format.html { redirect_to root_path,:action => 'index', alert: "You're not authorized to perform approval in this document." }
                end
           end


 end



 def update

    respond_to do |format|
  
    params[:user].delete(:password) if params[:user][:password].nil?
  
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


 private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if params[:id] == 'edit'
         @user = User.find(current_user.id)
      else
         @user = User.find(params[:id]) 
      end


    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :role, :emp_id, :title, :grade, :department_id, :is_locked, :password, :password_confirmation, :is_active)
    end
 


end

