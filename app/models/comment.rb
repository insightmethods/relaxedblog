class Comment < RelaxDB::Document
  property :created_at
  property :updated_at
  
  property :content, 
           :validator => lambda {|content| !title.blank? },
           :validation_msg => "Comment can't be blank"
           
  belongs_to :author
end
