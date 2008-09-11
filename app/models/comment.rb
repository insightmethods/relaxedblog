class Comment < RelaxDB::Document
  property :created_at
  property :updated_at
  
  property :content, 
           :validator => lambda {|content| !title.blank? },
           :validation_msg => "Comment can't be blank"
           
  property :published, :default => false
  property :publish_date, :default => nil
           
  belongs_to :author
  belongs_to :page
end
