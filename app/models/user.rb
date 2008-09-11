class User < RelaxDB::Document
  attr_accessor :password, :email, :name
  property :username
  property :salt
  property :crypted_password
  
  belongs_to :author
  
  before_save :encrypt_password
  before_save :create_author
  
  def self.authenticate(username, password)
    User.all.sorted_by(:username).find do |u|
      u.username == username && u.authenticated?(password)
    end
  end
  
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end
  
  def self.find_by_id(id)
    user = (RelaxDB.load(id) rescue nil)
    user if user && user.is_a?(User)
  end
  
  def encrypt(password)
    self.class.encrypt(password, salt)
  end
  
  def authenticated?(password)
    crypted_password == encrypt(password)
  end
  
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{username}--") if new_record?
    self.crypted_password = encrypt(password)
  end
  
  def create_author
    if new_record? && author.nil?
      a = Author.new({:name => name, :email => email})
      a.save
      self.author = a
    end
  end
end
