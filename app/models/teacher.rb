class Teacher < ActiveRecord::Base
  require "firebase_token_generator"

  before_create -> {
    payload = {:uid => String(self.id), :admin => String(self.admin) }
    firebase = Rails.application.secrets.firebase_key
    generator = Firebase::FirebaseTokenGenerator.new(firebase)
    self.auth_token = generator.create_token(payload)
  }

  belongs_to :school
end
