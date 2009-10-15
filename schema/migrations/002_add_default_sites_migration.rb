migration 2, :add_default_sites  do
  URLS = %w( establishedmen.com hotornot.com ashleymadison.com cougarlife.com arrangementseekers.com eroticy.com swappernet.com )
  
  up do
    URLS.each do |url|
      Site.create!(:url => url)
    end
  end

  down do
    URLS.each do |url|
      site = Site.first(:url => url)
      site.destroy if site
    end
  end
end
