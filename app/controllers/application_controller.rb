class ApplicationController < ActionController::Base
  require 'bb-ruby'
  before_filter :authenticate_user!, :set_online, :set_user
  helper_method :smiles

  def smiles(text)
    require "smaley"
    Smaley.glyphs_smilies(text)
  end

  def set_online
    if user_signed_in?
      current_user.update_attribute(:login, current_user.email) if current_user.login.blank?
      current_user.online!
    end
  end

  protect_from_forgery
  def set_user
    @user = User.find(params[:user_id]) if params[:user_id]
    @user ||= current_user if defined?(current_user)
    @user ||= User.new
  end
end