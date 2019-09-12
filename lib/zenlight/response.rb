require 'json'


module Zenlight
  class Response
    attr_reader :code
    attr_reader :json
    attr_reader :limit
    attr_reader :remaining
    attr_reader :body
    attr_reader :either
    attr_reader :time
    attr_reader :headers

    def initialize _response, _time = nil
      @limit = _response.headers[:x_rate_limit].try(:to_i) || _response.headers[:x_ratelimit_limit_minute].try(:to_i) || _response.headers[:x_ratelimit_total].try(:to_i)
      @remaining = _response.headers[:x_rate_limit_remaining].try(:to_i) || _response.headers[:x_ratelimit_remaining_minute].try(:to_i) || _response.headers[:x_ratelimit_remaining].try(:to_i)
      @code = _response.code.to_i
      if _response.headers[:content_type].try { |ct| ct.include?("application/json") } == true
        begin
          @json = JSON.parse(_response.body)
        rescue
          @json = nil
        end
      else
        @json = nil
      end
      @body = _response.body
      @either = @json || @body
      @time = (Time.now - _time).to_f if _time
      @headers = _response.headers
    end
  end
end
