class Site
  include DataMapper::Resource
  
  property :id, Serial
  property :url, String, :nullable => false
end
