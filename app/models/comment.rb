class Comment < RelaxDB::Document
  include CodeRayScanAndCache
  property :created_at
  property :updated_at
  
  property :content, 
           :validator => lambda {|content| !content.blank? },
           :validation_msg => "Comment can't be blank"
  
  property :content_html         
  property :published, :default => false
  property :publish_date, :default => nil
           
  belongs_to :author
  belongs_to :page
  
  scan_and_cache :content
  before_save    :do_scan_and_cache
  
end
