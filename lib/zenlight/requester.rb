require 'rest-client'
require 'zenlight/response'


module Zenlight
  module Requester
    def get _path, _params = nil
      setup = {
        method: __callee__.to_s,
        url: "https://#{self.config.subdomain}.zendesk.com" << _path,
        user: "#{self.config.email}/token",
        password: self.config.token,
        headers: {
          accept: :json,
          content_type: :json
        }
      }
      setup.merge!(payload: _params.to_json if _params)
      prepared = RestClient::Request.new(setup)
      begin
        response = Zenlight::Response.new(prepared.execute)
      rescue RestClient::ExceptionWithResponse => e
        response = Zenlight::Response.new(e.response)
      end
      response
    end
  end
end
