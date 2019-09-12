require 'zenlight/version'
require 'zenlight/configuration'
require 'zenlight/requester'


module Zenlight
  class Instance
    include Zenlight::Requester
    alias :post :get
    alias :put :get
    alias :patch :get
    alias :delete :get
    def initialize
      @config ||= Zenlight::Configuration.new
      yield(@config) if block_given?
      @config
    end
    def config
      @config || self.configure
    end
  end
end
