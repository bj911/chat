class History < ActiveRecord::Base
  attr_accessor :picture
  after_update :jug_send
  belongs_to :user, :foreign_key => "send_id"
  has_many :pictures

  def jug_send()
    u = User.find(send_id)
    jug = {:message => message.bbcode_to_html({}, false), :created_at => created_at.to_s(:ru_datetime), :login => u.login}
    Juggernaut.publish(recive_id.blank? ? "channel1" : ["#{recive_id}", "#{send_id}"], jug)
  end
end