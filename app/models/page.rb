class Page < RelaxDB::Document
  include CodeRayScanAndCache
  property :created_at
  property :updated_at
  property :title, 
           :validator => lambda {|title| !title.blank? },
           :validation_msg => "Title can't be blank"
            
  property :content, 
           :validator => lambda {|content| !content.blank? },
           :validation_msg => "Page can't be blank"
           
  property :tags
  property :content_html
  property :published, :default => false
  property :publish_date, :default => nil
  
  has_many :comments, :class => "Comment"
  belongs_to :author
  
  scan_and_cache :content
  before_save    :do_scan_and_cache
  
end
