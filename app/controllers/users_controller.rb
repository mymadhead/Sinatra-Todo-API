# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  include JwtHelper

  post '/sign_up' do
    user = User.new(params)
    if user.save
      { token: encode_token(user) }.to_json
    else
      error 400, user.errors.to_json
    end
  end

  post '/sign_in' do
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      { token: encode_token(user) }.to_json
    else
      error 400, { message: 'Invalid username or password' }.to_json
    end
  end

  get '/users' do
    logged_in?
    User.all.to_json
  end

  get '/users/:id' do
    logged_in?
    User.where(id: params[:id]).first.to_json
  end

  get '/users/profile' do
    logged_in?
    current_user.to_json
  end
end
