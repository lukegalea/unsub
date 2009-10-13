require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a exclusion exists" do
  Exclusion.all.destroy!
  request(resource(:exclusions), :method => "POST", 
    :params => { :exclusion => { :id => nil }})
end

describe "resource(:exclusions)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:exclusions))
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
      @response = request(resource(:exclusions))
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
        :params => { :exclusion => { :id => nil }})
    end
    
    it "redirects to resource(:exclusions)" do
      @response.should redirect_to(resource(Exclusion.first), :message => {:notice => "exclusion was successfully created"})
    end
    
  end
end

describe "resource(@exclusion)" do 
  describe "a successful DELETE", :given => "a exclusion exists" do
     before(:each) do
       @response = request(resource(Exclusion.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:exclusions))
     end

   end
end

describe "resource(:exclusions, :new)" do
  before(:each) do
    @response = request(resource(:exclusions, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@exclusion, :edit)", :given => "a exclusion exists" do
  before(:each) do
    @response = request(resource(Exclusion.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@exclusion)", :given => "a exclusion exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Exclusion.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @exclusion = Exclusion.first
      @response = request(resource(@exclusion), :method => "PUT", 
        :params => { :exclusion => {:id => @exclusion.id} })
    end
  
    it "redirect to the exclusion show action" do
      @response.should redirect_to(resource(@exclusion))
    end
  end
  
end

