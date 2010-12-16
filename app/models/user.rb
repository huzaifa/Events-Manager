# == Schema Information
# Schema version: 20101216044850
#
# Table name: users
#
#  id         :integer         not null, primary key
#  uni        :string(255)
#  name       :string(255)
#  password   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  salt       :string(255)
#  admin      :boolean
#

require 'digest'

class User < ActiveRecord::Base

	has_many :events, :dependent => :destroy
	
	attr_accessor :ppassword 
	
	attr_accessible :name, :uni, :ppassword, :ppassword_confirmation

	uni_regex = /[a-z]+[0-9]+/

	validates :name,  :presence => true

  validates :uni, :presence => true,
					        :format   => { :with => uni_regex },
					        :uniqueness => true
					 
	validates :ppassword, :presence     => true,
                        :confirmation => true,
                        :length       => { :within => 6..40 }
                        
  before_save :encrypt_password
  
  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    self.password == encrypt(submitted_password)
  end
  
  def self.authenticate(submitted_uni, submitted_password)
    user = find_by_uni(submitted_uni)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
    return nil
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.password = encrypt(ppassword)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{ppassword}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
			
end	
