class Exclusion
  include DataMapper::Resource
  
  property :id, Serial
  property :site_id, Integer, :nullable => false
  property :email_hash, String, :nullable => false
  property :email, String, :format => :email_address

  property :created_at, DateTime

  validates_is_unique :email, :scope => :site_id
  
  def email=(email)
    down_email = email.downcase
    attribute_set(:email, down_email)    
    self.email_hash = Digest::MD5.hexdigest(down_email)
  end
end
