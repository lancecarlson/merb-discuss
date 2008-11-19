require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe MerbDiscuss::Topic do
  before do
    @forum = MerbDiscuss::Forum.create!
  end
  
  it "should create an initial post and attach it to the topic after created" do
    @topic = @forum.topics.build :title => "title", :body => "body"
    @topic.save!
    @topic.posts.length.should == 1
    @topic.posts.first.title.should == "title"
    @topic.posts.first.body.should == "body"
  end

end