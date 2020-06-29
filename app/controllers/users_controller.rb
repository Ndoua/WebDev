class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def update
    if params[:file]
      @user.image.attach(params[:file])
      image = url_for(@user.image)
    elsif params[:camera]
      blob = ActiveStorage::Blob.create_after_upload!(
        io: StringIO.new(Base64.decode64(params[:camera].split(',')[1])),
        filename: 'user.png',
        content_type: 'image/png'
      )
      @user.image.attach(blob)
      image = url_for(@user.image)
    else
      image = photo_params[:image]
    end
    render json: @user, status: :ok if @user.update(photo: image)
  end

  def destroy
  end


  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :image)
  end
end
