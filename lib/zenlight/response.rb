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
      @limit = _response.headers[:x_rate_limit] || _response.headers[:x_ratelimit_limit_minute] || _response.headers[:x_ratelimit_total]
      @limit = @limit.to_i if @limit
      @remaining = _response.headers[:x_rate_limit_remaining] || _response.headers[:x_ratelimit_remaining_minute] || _response.headers[:x_ratelimit_remaining]
      @remaining = @remaining.to_i if @remaining
      @code = _response.code.to_i
      if content_type = _response.headers[:content_type]
        if content_type.include?("application/json")
          begin
            @json = JSON.parse(_response.body)
          rescue
            @json = nil
          end
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
