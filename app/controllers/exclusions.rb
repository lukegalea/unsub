class Exclusions < Application
  before :load_site_from_params
  before :ensure_authenticated, :only => :index
  before :load_user, :only => :index
  before :ensure_permissions, :only => :index
  
  def index
    only_provides :text
    @exclusions = Exclusion.all(:site_id => @site.id)
    Log.create!(:site_id => @site.id, :user_id => @current_user.id, :type => 'request_exclusion_list')
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
    previous_exclusion = Exclusion.first(:site_id => @site.id, :email => params[:exclusion][:email].downcase)    
    @exclusion =  previous_exclusion || Exclusion.new(params[:exclusion].merge(:site_id => @site.id))

    captcha_correct = recaptcha_valid?
    unless captcha_correct
      @exclusion.valid?
      @exclusion.errors.add(:general, "Captcha code is incorrect")
      return render(:new)
    end

    referring_user_id = params[:ref]
    success = false

    if previous_exclusion
      success = true
    else
      success = @exclusion.save
    end

    if success
      Log.create!( :exclusion_id => @exclusion.id, :site_id => @site.id, :user_id => referring_user_id, :type => "unsubscribe" )
      redirect resource(@site, @exclusion)
    else
      render :new
    end
  end
  
  private

  def load_site_from_params
    @site = Site.get(params[:site_id]) if params[:site_id]
    throw :halt, "Unknown site. Site is required." unless @site
  end

  def load_user
    @current_user = User.get(session[:user])
    throw :halt, "Invalid user" unless @current_user
  end

  def ensure_permissions
    throw :halt, "Access denied for this site" unless @current_user.sites.include? @site
  end

end # Exclusions
