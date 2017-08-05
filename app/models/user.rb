class User < ActiveRecord::Base
	has_secure_password
	has_many :secrets, dependent: :destroy
	has_many :secrets
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	#to get the likes of instances of User
	has_many :secrets_liked, through: :likes, source: :secret

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :username, :email, presence: true
	validates :username, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 4 }, presence: true, on: :create
	validates :password_confirmation, presence: true, on: :create
	validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	before_save do 
	  	self.email.downcase!
	end 
	before_update do
	    check_password
	end 

	private
	    def check_password
	        is_ok = self.password.nil? || self.password.empty? || self.password.length >=4 
	        self.errors[:password] << "password is too short (minimum is 4 characters)" unless is_ok
	    end
end
