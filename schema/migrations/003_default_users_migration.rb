migration 3, :default_users  do
  up do
    u = User.create!(:login => 'ashley', :password => 'temp123')
    UserSitePermission.create!(:site_id => Site.first(:url => 'ashleymadison.com').id, :user_id => u.id )
  end

  down do
  end
end
