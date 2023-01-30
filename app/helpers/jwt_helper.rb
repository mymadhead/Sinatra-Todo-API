# frozen_string_literal: true

# JWT auth
module JwtHelper
  def logged_in?
    current_user
  end

  def token
    env.fetch('HTTP_AUTHORIZATION', '').slice(7..-1)
  end

  def encode_token(user)
    JWT.encode payload(user), ENV['SECRET_KEY'], 'HS256'
  end

  def decode_token(token)
    JWT.decode token, ENV['SECRET_KEY'], true, { algorithm: 'HS256' }
  end

  def payload(user)
    {
      exp: Time.now.to_i + (60 * 60 * 24),
      user: {
        username: user[:username],
        id: user[:id]
      }
    }
  end

  def current_user
    User.find(find_user_id)
  end

  def find_user_id
    payload, = decode_token(token)
    payload['user']['id']
  end
end
