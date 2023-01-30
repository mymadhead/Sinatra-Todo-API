# frozen_string_literal: true

module Request
  module JsonHelper
    def load_json
      JSON.parse last_response.body
    end
  end
end
