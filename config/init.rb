# Go to http://wiki.merbivore.com/pages/init-rb
 
require 'config/dependencies.rb'
 
use_orm :datamapper
use_test :rspec
use_template_engine :haml

REXMLUtilityNode.typecasts.delete('yaml')
REXMLUtilityNode.typecasts.delete('symbol')
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = '0e08a8fd2ab89b8c5f64aa205e77421aba432f3d'  # required for cookie session store
  c[:session_id_key] = '_unsub_session_id' # cookie session id key, defaults to "_session_id"
end
 
Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
end
 
Merb::BootLoader.after_app_loads do
  # This will get executed after your app's classes have been loaded.
  Merb::Plugins.config[:merb_recaptcha][:public_key] = "6Lcx-AcAAAAAAAWZMMCko0qAdOpIAO07x0h9Tq33"
  Merb::Plugins.config[:merb_recaptcha][:private_key] = "6Lcx-AcAAAAAAJzvtnIxoxsyPX9AslQXF1kUXW0H"
end
