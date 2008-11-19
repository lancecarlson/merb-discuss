module MerbDiscuss
  class Topic
    include DataMapper::Resource
    
    after :create, :build_initial_post
  
    property :id,           Serial
    property :forum_id,     Integer, :key => true
    property :title,        String
  
    belongs_to :forum, :class_name => "MerbDiscuss::Forum"
    has n, :posts, :class_name => "MerbDiscuss::Post"
    
    attr_accessor :body
    
    def build_initial_post
      self.posts.build(:title => title, :body => body)
    end
  end
end