class User < RelaxDB::Document
  attr_accessor :password, :email, :name
  property :username
  property :salt
  property :crypted_password
  
  belongs_to :author
  
  before_save :create_author
  
  def self.authenticate(username, password)
    u = self.find_active_with_conditions(:email => email)
    u && u.authenticated?(password) ? u : nil
  end
  
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end
  
  def self.find_by_id(id)
    user = (RelaxDB.load(session[:current_user]) rescue nil)
    user if user && user.is_a?(User)
  end
  
  def encrypt(password)
    self.class.encrypt(password, salt)
  end
  
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{username}--") if new_record?
    self.crypted_password = encrypt(password)
  end
  
  def create_author
    if new_record? && author.nil?
      self.author = Author.new({:name => name, :email => email})
    end
  end
end
