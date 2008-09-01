class Page < RelaxDB::Document
  property :created_at
  property :updated_at
  property :title, 
           :validator => lambda {|title| !title.blank? },
           :validation_msg => "Title can't be blank"
            
  property :content, 
           :validator => lambda {|content| !content.blank? },
           :validation_msg => "Page can't be blank"
           
  property :published, :default => false
  
  has_many :comments
  belongs_to :author
end
