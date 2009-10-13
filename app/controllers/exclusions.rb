class Exclusions < Application
  before :load_site_from_params
  before :ensure_authenticated, :only => :index
  
  def index
    only_provides :text
    @exclusions = Exclusion.all(:site_id => @site.id)
    display @exclusions
  end

  def show
    @exclusion = Exclusion.first(:id => params[:id], :site_id => @site.id)
    raise NotFound unless @exclusion
    display @exclusion
  end

  def new
    only_provides :html
    @exclusion = Exclusion.new(:site_id => @site.id)
    display @exclusion
  end

  def create
    @exclusion = Exclusion.new(params[:exclusion].merge(:site_id => @site.id))
    if @exclusion.save
      render "You have been unsubscribed from #{@site.url}"
    else
      render :new
    end
  end
  
  private

  def load_site_from_params
    @site = Site.get(params[:site_id]) if params[:site_id]
    throw :halt, "Unknown site. Site is required." unless @site
  end

end # Exclusions
