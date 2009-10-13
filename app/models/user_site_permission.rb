class UserSitePermission
  include DataMapper::Resource
  
  property :id, Serial
  property :user_id, Integer
  property :site_id, Integer

  belongs_to :user
  belongs_to :site
end
