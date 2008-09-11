class Comment < RelaxDB::Document
  include MerbCoderayTextile
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
  
  before_save :scan_and_cache_content
  
  def scan_and_cache_content
    if @content
      formatted_code_if_any = refs_syntax_highlighter(@content)
      self.content_html = textilize_with_code(formatted_code_if_any || @content) 
    end
    true
  end
  
end
