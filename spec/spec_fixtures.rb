Site.fixture {{
    :url => "ashleymadison.com"
  }}

User.fixture {{
    :login => "ashleymadison",
    :password => "password"    
  }}

UserSitePermission.fixture {{
    :site_id => Site.first( :url => "ashleymadison.com" ),    
    :user_id => User.first( :login => "ashleymadison" )
  }}
