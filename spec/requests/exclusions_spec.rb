require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a exclusion exists" do
  Exclusion.all.destroy!
  request(resource(:exclusions), :method => "POST", 
    :params => { :exclusion => { :id => nil, :site_id => Site.first.id, :email => 'test@test.com' }})
end

describe "resource(:site, :exclusions)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(Site.first, :exclusions))
    end
    
    it "respond with a 401" do
      @response.status.should eql(401)
    end    
  end

  describe "GET (authenticated)" do
    
    before(:each) do
      login
      @response = request(resource(Site.first, :exclusions))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of exclusions" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a exclusion exists" do
    before(:each) do
      @response = request(resource(Site.first, :exclusions))
    end
    
    it "has a list of exclusions" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Exclusion.all.destroy!
      @response = request(resource(:exclusions), :method => "POST", 
        :params => { :exclusion => { :id => nil, :site_id => Site.first.id, :email => 'test@test.com' }})
    end
    
    it "redirects to success page" do
      @response.should redirect_to(resource(Exclusion.first), :message => {:notice => "exclusion was successfully created"})
    end
    
  end
end

describe "resource(:site, :exclusions, :new)" do
  before(:each) do
    @response = request(resource(Site.first, :exclusions, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end
