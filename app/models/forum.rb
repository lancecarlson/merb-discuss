module MerbDiscuss
  class Forum
    include DataMapper::Resource
  
    property :id,             Serial
    property :title,          String
    property :description,    Text
    property :created_at,     DateTime
  
    has n, :topics
    has n, :posts
    
    validates_present :title
  end
end