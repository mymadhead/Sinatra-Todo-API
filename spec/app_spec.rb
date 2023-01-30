# frozen_string_literal: true

require 'spec_helper'

describe 'App' do

  context 'when user requesting a non existed path' do
    it 'responds with 404 when accessing a random path' do
      get '/abc'
      expect(last_response.status).to eq(404)
    end

    it 'responds with wrong path message when accessing a random path' do
      get '/qwerty'
      expect(last_response.body).to include('GET /qwerty')
    end
  end
end
