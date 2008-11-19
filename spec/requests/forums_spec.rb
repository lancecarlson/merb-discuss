require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a forum exists" do
  request(resource(:forums), :method => "POST", 
    :params => { :forum => { :id => nil }})
end

describe "resource(:forums)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:forums))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of forums" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a forum exists" do
    before(:each) do
      @response = request(resource(:forums))
    end
    
    it "has a list of forums" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      @response = request(resource(:forums), :method => "POST", 
        :params => { :forum => { :id => nil }})
    end
    
    it "redirects to resource(:forums)" do
    end
    
  end
end

describe "resource(@forum)" do 
  describe "a successful DELETE", :given => "a forum exists" do
     before(:each) do
       @response = request(resource(Forum.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:forums))
     end

   end
end

describe "resource(:forums, :new)" do
  before(:each) do
    @response = request(resource(:forums, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@forum, :edit)", :given => "a forum exists" do
  before(:each) do
    @response = request(resource(Forum.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@forum)", :given => "a forum exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Forum.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @forum = Forum.first
      @response = request(resource(@forum), :method => "PUT", 
        :params => { :forum => {:id => @forum.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@forum))
    end
  end
  
end

