class Teacher < ActiveRecord::Base
  require "firebase_token_generator"
  has_secure_password
  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  before_create -> {
    payload = {:uid => String(self.id), :admin => String(self.admin) }
    firebase = Rails.application.secrets.firebase_key
    generator = Firebase::FirebaseTokenGenerator.new(firebase)
    self.auth_token = generator.create_token(payload)
  }

  belongs_to :school
end
