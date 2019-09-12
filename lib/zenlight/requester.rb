require 'rest-client'
require 'zenlight/response'
require 'open-uri'


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
      case __callee__.to_s.downcase
      when "get","post","put","patch"
        if setup[:url].include?('upload') || setup[:url].include?('/attachments')
          setup[:headers][:content_type] = 'application/*'
          setup[:payload] = _params
        else
          setup[:headers][:content_type] = :json
          setup.merge!(payload: _params.to_json) if _params
        end
        setup[:headers][:content_type] = 'application/merge-patch+json' if __callee__.to_s.downcase == "patch"
      end
      prepared = RestClient::Request.new(setup)
      begin
        response = Zenlight::Response.new(prepared.execute)
      rescue RestClient::ExceptionWithResponse => e
        response = Zenlight::Response.new(e.response)
      end
      response
    end
    def download _url
      open(_url).read.force_encoding("UTF-8")
    end
  end
end
