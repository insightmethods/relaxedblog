class Publish < Application
  layout "admin"
  before :setup, :exclude => [:all, :new, :create]
  
  def all
    @pages = Page.all
    render
  end
  
  def new
    @page = Page.new
    render
  end
  
  def edit
    render
  end
  
  def create(page)
    @page = Page.new(page)
    if @page.save
      redirect url(:publish, :action => :all)
    else
      render :new
    end
  end
  
  def update(page)
    @page.set_attributes(page.merge( {:author => RelaxDB.load(page[:author])} ))
    if @page.save
      redirect url(:publish, :action => :all)
    else
      render :edit
    end
  end
  
  def publish_toggle
    @page.published = !@page.published
    @page.save
    redirect url(:publish, :action => :all)
  end
  
  private
    def setup
      @page = RelaxDB.load(params[:id])
      raise NotFound unless @page
    end
end
