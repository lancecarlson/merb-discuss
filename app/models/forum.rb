module MerbDiscuss
  class Forum
    include DataMapper::Resource
  
    property :id,             Serial
    property :title,          String
    property :description,    Text
    property :created_at,     DateTime
  
    has n, :topics, :class_name => "MerbDiscuss::Topic"
    has n, :posts, :class_name => "MerbDiscuss::Post"
    
    validates_present :title
  end
end