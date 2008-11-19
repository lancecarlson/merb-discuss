require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a topic exists" do
  Topic.all.destroy!
  request(resource(:topics), :method => "POST", 
    :params => { :topic => { :id => nil }})
end

describe "resource(:topics)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:topics))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of topics" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a topic exists" do
    before(:each) do
      @response = request(resource(:topics))
    end
    
    it "has a list of topics" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Topic.all.destroy!
      @response = request(resource(:topics), :method => "POST", 
        :params => { :topic => { :id => nil }})
    end
    
    it "redirects to resource(:topics)" do
      @response.should redirect_to(resource(Topic.first), :message => {:notice => "topic was successfully created"})
    end
    
  end
end

describe "resource(@topic)" do 
  describe "a successful DELETE", :given => "a topic exists" do
     before(:each) do
       @response = request(resource(Topic.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:topics))
     end

   end
end

describe "resource(:topics, :new)" do
  before(:each) do
    @response = request(resource(:topics, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@topic, :edit)", :given => "a topic exists" do
  before(:each) do
    @response = request(resource(Topic.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@topic)", :given => "a topic exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Topic.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @topic = Topic.first
      @response = request(resource(@topic), :method => "PUT", 
        :params => { :topic => {:id => @topic.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@topic))
    end
  end
  
end

