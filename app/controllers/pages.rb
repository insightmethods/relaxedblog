class Pages < Application
  before :setup, :only => [:show, :preview]
  before :login_required, :only => [:preview]
  
  def index(page = nil)
    provides :html, :atom
    @pages = Page.all.sorted_by(:created_at).reverse.select do |page| 
      !!page.published 
    end
    render 
  end
  
  def show
    raise NotFound unless @page.published
    render
  end
  
  def preview
    render :show
  end
  
  private
    def setup
      @page = RelaxDB.load(params[:id])
      @page_title = "#{@page.title} :: "
    end
end
