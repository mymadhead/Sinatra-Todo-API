# frozen_string_literal: true

# Class Application Controller
class ApplicationController < Sinatra::Base
  set :default_content_type, :json
  set :show_exceptions, :after_handler

  not_found do
    error_message
  end

  error ActiveRecord::RecordNotFound do
    error 404, error_message
  end

  error ActiveModel::UnknownAttributeError do
    error 404, error_message
  end

  error JWT::VerificationError do
    error 401, error_message
  end

  error JWT::DecodeError do
    error 403, error_message
  end

  def error_message
    { message: "Error: #{env['sinatra.error'].message}" }.to_json
  end

  def load_json
    request.body.rewind
    json_data = JSON.parse request.body.read
    json_data.is_a?(Hash) ? json_data : (halt 500, json(message: 'hash not accepted'))
  rescue StandardError
    halt 500, json(message: 'incorrect data')
  end
end
