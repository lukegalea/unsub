class UserSitePermission
  include DataMapper::Resource
  
  property :id, Serial
  property :user_id, Integer
  property :site_id, Integer

  property :created_at, DateTime

  belongs_to :user
  belongs_to :site
end
