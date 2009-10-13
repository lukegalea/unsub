class Site
  include DataMapper::Resource
  
  property :id, Serial
  property :url, String, :nullable => false

  has n, :logs
  #has n, :users, :through => UserSitePermission # This won't work for some reason
  has n, :exclusions
end
