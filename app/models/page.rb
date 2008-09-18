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

  property :stamp
  property :tags, :default => ['news', 'general']
  property :content_html
  property :published, :default => false
  property :publish_date, :default => nil
  
  has_many :comments, :class => "Comment"
  belongs_to :author
  
  scan_and_cache :content
  before_save    :do_scan_and_cache
  before_save    :create_stamp
  
  class << self
    def find_by_stamp(stamp)
      all.sorted_by(:stamp) { |query| query.key(stamp).count(1) }.first
    end
    
    def find_all_by_tag(tag)
      RelaxDB.instantiate(
        RelaxDB.view('Page', 'all_tagged_published') { |query| query.key(tag).count(10) }
      )
    end
    
    def find_all
      RelaxDB.instantiate(
        RelaxDB.view('Page', 'all_published') { |query| query.count(10) }
      )
    end
    
    def all_tags
      RelaxDB.view('Tag', 'all') { |q| q.group(true) }['rows']
    end
  end
  
  def tags
    @tags.join(' ')
  end
  
  def tags=(tgs)
    if tgs.is_a? String
      @tags = tgs.split(' ')
    elsif tgs.respond_to? :to_a
      @tags = tgs.to_a
    end
  end
  
  def create_stamp
    @stamp = "#{Time.now.strftime('%H-%j-%y')}--#{@title.downcase.gsub( /[^-a-z0-9~\s\.:;+=_]/, '').gsub(/[\s\.:;=_+]+/, '-').gsub(/[\-]{2,}/, '-')}"
  end
end
