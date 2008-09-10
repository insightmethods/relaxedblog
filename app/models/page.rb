class Page < RelaxDB::Document
  property :created_at
  property :updated_at
  property :title, 
           :validator => lambda {|title| !title.blank? },
           :validation_msg => "Title can't be blank"
            
  property :content, 
           :validator => lambda {|content| !content.blank? },
           :validation_msg => "Page can't be blank"
           
  property :content_html
  property :published, :default => false
  property :publish_date, :default => nil
  
  has_many :comments
  belongs_to :author
  
  before_save :scan_content
  
  def scan_content
    self.content_html = self.content.scan(/(<code\:([a-z].+?)>(.+?)<\/code>)/m).each do |match|
      text.gsub!(match[0],CodeRay.scan(match[2], match[1].to_sym).div(:css => :class))
    end
  end
end
