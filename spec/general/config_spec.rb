describe "Config" do


  context "Config" do
    it "set config variables manually" do
      _subdomain = "asubdomain"
      _email = "anemail"
      _password = "apassword"
      _token = "atoken"
      _instance = Zenlight::Instance.new do |config|
        config.subdomain = _subdomain
        config.email = _email
        config.password = _password
        config.token = _token
      end
      expect(_instance.config.subdomain).to eq(_subdomain)
      expect(_instance.config.email).to eq(_email)
      expect(_instance.config.password).to eq(_password)
      expect(_instance.config.token).to eq(_token)
    end


    it "set config variables by environment variables" do
      ENV['ZENLIGHT_SUBDOMAIN'] = "asubdomain"
      ENV['ZENLIGHT_EMAIL'] = "anemail"
      ENV['ZENLIGHT_PASSWORD'] = "apassword"
      ENV['ZENLIGHT_TOKEN'] = "atoken"
      _instance = Zenlight::Instance.new
      expect(_instance.config.subdomain).to eq(ENV['ZENLIGHT_SUBDOMAIN'])
      expect(_instance.config.email).to eq(ENV['ZENLIGHT_EMAIL'])
      expect(_instance.config.password).to eq(ENV['ZENLIGHT_PASSWORD'])
      expect(_instance.config.token).to eq(ENV['ZENLIGHT_TOKEN'])
    end
  end


end
