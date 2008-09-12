class Page < RelaxDB::Document
  include MerbCoderayTextile
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
  
  has_many :comments, :class => "Comment"
  belongs_to :author
  
  before_save :scan_and_cache_content
  
  def scan_and_cache_content
    if @content
      formatted_code_if_any = refs_syntax_highlighter(@content.dup)
      self.content_html = textilize_with_code(formatted_code_if_any || @content.dup) 
    end
    true
  end
  
end
