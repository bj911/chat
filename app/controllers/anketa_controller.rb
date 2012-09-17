class AnketaController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    unless params['avatar'].blank?
      params['avatar'].each do |img|
        Photo.create(:user_id => @user.id, :image => img)
      end
    end
    @user = @user.update_attributes(params[:user])
    redirect_to edit_anketum_path
  end

  def show
    @user = User.includes(:photos).find(params[:id])
  end

  def destroy
    Photo.find(params["photo_id"]).destroy
    redirect_to edit_anketum_path
  end
end