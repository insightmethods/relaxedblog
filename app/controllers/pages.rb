class Pages < Application
  before :setup, :only => [:show, :preview, :create_comment]
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
    @comment = Comment.new
    @author = Author.new
    render
  end
  
  def preview
    render :show
  end
  
  def create_comment(id, comment, author)
    @author = Author.new(author)
    @comment = Comment.new(comment.merge(:page => @page, :author => @author))
    if @comment.save
      @author.save
      redirect url(:page, :id => @page.id)
    else
      render :show
    end
  end
  
  private
    def setup
      @page = RelaxDB.load(params[:id])
      @page_title = "#{@page.title} :: "
    end
end
