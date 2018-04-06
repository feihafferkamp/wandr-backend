class ApplicationController < ActionController::API
  def issue_token(payload)
    JWT.encode(payload, ENV['jwt_secret'])
  end

  def decode_token
    JWT.decode(get_token, ENV['jwt_secret'])[0]
  end

  def user_in_session
    decoded_hash = decode_token
    User.find(decoded_hash["user_id"])
  end

  def get_token
    request.headers["Authorization"]
  end


end
