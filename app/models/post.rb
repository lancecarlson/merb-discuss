module MerbDiscuss
  class Post
    include DataMapper::Resource
  
    property :id,             Serial
    property :forum_id,       Integer, :key => true
    property :topic_id,       Integer, :key => true
    property :title,          String
    property :body,           Text
    property :created_at,     DateTime
    
    belongs_to :topic
    belongs_to :forum, :class_name => "Forum"
  end
end