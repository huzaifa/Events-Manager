# == Schema Information
# Schema version: 20101213054121
#
# Table name: events
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  content    :string(255)
#  start      :datetime
#  end        :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Event < ActiveRecord::Base

	belongs_to :user
	
	attr_accessible :content, :start, :end
	
	validates :user_id, :presence => true
	
	validates :content, :length => { :maximum => 200 }

  validates :start, :presence => true
  
	validates :end, :presence => true
	
	default_scope :order => 'events.start'

end
