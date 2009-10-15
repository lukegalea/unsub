migration 2, :add_default_sites  do
  URLS = { "establishedmen.com" => "Established Men", "hotornot.com" => "Hot or Not", "ashleymadison.com" => "Ashley Madison", "cougarlife.com" => "Cougar Life", "arrangementseekers.com" => "Arrangement Seekers", "eroticy.com" => "Eroticy", "swappernet.com" => "Swappernet" }
  
  up do
    URLS.each do |url, name|
      Site.create!(:url => url, :name => name)
    end
  end

  down do
    URLS.each do |url, name|
      site = Site.first(:url => url)
      site.destroy if site
    end
  end
end
