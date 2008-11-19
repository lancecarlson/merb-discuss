require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe MerbDiscuss::Topic do
  before do
    @topic = MerbDiscuss::Topic.new
  end
  
  it "should create an initial post and attach it to the topic after created" do
    @topic.title = "title"
    @topic.body = "body"
    @topic.save
    @topic.post.title.should == "title"
    @topic.post.body.should == "body"
  end

end