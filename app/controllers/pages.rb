class Pages < Application
  before :setup, :only => [:show, :preview, :create_comment]
  before :login_required, :only => [:preview]
  
  def index(tag = nil)
    provides :html, :atom
    @pages =  if tag.blank?
                Page.find_all
              else
                Page.find_all_by_tag(tag)
              end
    render 
  end
  
  def show
    raise NotFound unless @page.published
    @comments = @page.comments.to_a.sort_by { |comment| comment.created_at }
    render
  end
  
  def preview
    render :show
  end
  
  def create_comment(id, comment, author)
    @author.set_attributes(author)
    @comment.set_attributes(comment.merge(
      :page => @page, 
      :author => @author
    ))
    if @author.save && @comment.save
      session[:author] = @author
      redirect url(:page, :id => @page.id)
    else
      render :show
    end
  end
  
  private
    def setup
      @page = RelaxDB.load(params[:id]) rescue Page.find_by_stamp(params[:id])
      raise BadRequest unless @page
      @comment = Comment.new
      @comments = []
      @author =  session[:author] || Author.new
      @page_title = "#{@page.title} :: "
    end
end
