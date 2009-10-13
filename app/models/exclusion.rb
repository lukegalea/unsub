class Exclusion
  include DataMapper::Resource
  
  property :id, Serial
  property :site_id, Integer, :nullable => false
  property :email_hash, String, :nullable => false
  property :email, String, :format => :email_address
  
  def email=(email)
    attribute_set(:email, email)    
    self.email_hash = Digest::MD5.hexdigest(email)
  end
end
