class Author < RelaxDB::Document
  property :created_at
  property :updated_at
  
  property :name
  property :email
  property :url
  
  def name
    @name.blank? ? nil : @name
  end
end
