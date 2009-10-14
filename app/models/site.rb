class Site
  include DataMapper::Resource
  
  property :id, Serial
  property :url, String, :nullable => false

  property :created_at, DateTime

  has n, :logs
  has n, :user_site_permissions
  has n, :users, :through => :user_site_permissions
  has n, :exclusions
end
