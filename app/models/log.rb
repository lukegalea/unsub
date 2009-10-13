class Log
  include DataMapper::Resource
  
  property :id, Serial
  property :site_id, Integer
  property :exclusion_id, Integer
  property :user_id, Integer
  property :type, String
  property :data, String

  belongs_to :site
  belongs_to :exclusion
  belongs_to :user  
end
