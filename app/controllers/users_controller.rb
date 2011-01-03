class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def update_image
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_to do |format|
      format.html { redirect_to user_path(@user)}
      format.xml  { render :xml => @user }
    end
  end

end
