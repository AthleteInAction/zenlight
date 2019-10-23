require 'yaml'


describe "Requester" do


  let(:_credentials){ YAML.load(File.read("spec/support/zendesk.yml")) }
  let(:_instance){
    Zenlight::Instance.new do |config|
      config.subdomain = _credentials[:subdomain]
      config.email = _credentials[:email]
    end
  }


  context "Credentials by API Token" do
    it "should respond with status successful (200)" do
      _instance.config.token = _credentials[:token]
      request = _instance.get("/api/v2/tickets")
      expect(request.code).to eq(200)
    end
  end


  context "Credentials by Password" do
    it "should respond with status successful (200)" do
      _instance.config.password = _credentials[:password]
      request = _instance.get("/api/v2/tickets")
      expect(request.code).to eq(200)
    end
  end


end
