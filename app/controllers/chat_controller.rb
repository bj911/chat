class ChatController < ApplicationController
  before_filter "load"
  helper_method :sanitize_options

  def sanitize_options
    { :tags => %w(img table tr td br ul ul li a strong b u s i hr em p div sub sup span h1 h2 h3 h4 h5 h6), :attributes => %w(class style data type value href height width name src colspan rowspan align rel) }
  end

  def help
    Helper.instance
  end

  class Helper
    include Singleton
    include ActionView::Helpers::SanitizeHelper
  end

  def index
    @user.update_attribute(:online, true)
    @history = History.new
    @users = User.all(:order => "login ASC")
  end

  def create
    @users = User.all(:order => "login ASC")
    @history = History.create(params[:history].merge({:send_id => @user.id, :message => help.sanitize("<a>"+smiles(params['history']['message'])+"</a>", sanitize_options)}))
    gallery = ""
    unless params['history']['picture'].blank?
      params['history']['picture'].each do |pict|
        file = pict.instance_values['original_filename']
        gallery += "<a class='gallery' href='/uploads/picture/big_#{file}' rel='group'><img src='/uploads/picture/norm_#{file}' onclick=Gallery();></a>"
        @history.pictures.create(:picture => pict)
      end
      gallery += "<br>"
    end
    @history.update_attribute(:message, gallery+@history.message)
    @histories = History.all(:limit => 100, :order => "created_at DESC").reverse
    redirect_to chat_index_path
  end

  def i_am_online
    current_user.online!
    @users = User.all(:order => "login ASC")
  end

  private
  def load
    @user = current_user
    @histories = History.all(:limit => 100, :order => "created_at DESC").reverse
  end
end