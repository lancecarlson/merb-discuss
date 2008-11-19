module MerbDiscuss
  class Topic
    include DataMapper::Resource
    
    before :create, :build_initial_post
  
    property :id,           Serial
    property :forum_id,     Integer, :key => true
    property :title,        String
  
    belongs_to :forum, :class_name => "MerbDiscuss::Forum"
    has n, :posts, :class_name => "MerbDiscuss::Post"
    
    attr_accessor :body
    
    def build_initial_post
      post_attributes = {
        :title => title
        :body => body
      }
      self.posts.build(post_attributes)
    end
  end
end