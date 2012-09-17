class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable, :timeout_in => 3.hours

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :country, :city, :login, :icq, :skype, :mobile, :birthday, :gender, :online, :avatar, :remove_avatar

  has_many :histories
  has_many :photos
  mount_uploader :avatar, AvatarUploader

  validates :login, :name, :country, :city, :icq, :skype, :mobile, :length => {:maximum => 18}
  validates :email, :presence => true, :uniqueness => true

  def online!
    Rails.cache.write("user_#{id}_online", true, :expires_in => 55.seconds)
    online_user_ids = Rails.cache.exist?(:online_user_ids) ? Rails.cache.read(:online_user_ids) : []
    online_user_ids = online_user_ids.find_all{|user_id| Rails.cache.exist?("user_#{user_id}_online")}
    (online_user_ids << id) unless online_user_ids.include?(id)
    Rails.cache.write(:online_user_ids, online_user_ids)
  end

  def online?
    Rails.cache.exist?("user_#{id}_online")
  end

  def self.online_user_ids
    Rails.cache.exist?(:online_user_ids) ? Rails.cache.read(:online_user_ids)  : []
  end
end