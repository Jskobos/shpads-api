class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_filter :authenticate_user_from_token, except: [:login]

  def login
    authenticate_with_http_basic do |email, password|
      teacher = Teacher.find_by(email: email)
      if teacher && teacher.authenticate(password)
        render json: { token: teacher.auth_token }
      elsif !teacher
        render json: { error: 'Email address does not exist in our records' }, status: 403
      else
        render json: { error: 'Invalid password.' }, status: 403
      end
    end
  end

  def authenticate_user_from_token
    unless authenticate_with_http_token { |token, options| Teacher.find_by(auth_token: token) }
      render json: { error: 'Bad Token'}, status: 401
    end
  end
end
