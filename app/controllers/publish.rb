class Publish < Application
  layout "admin"
  
  def pages
    @pages = Page.all
    render
  end
  
  def new
    @page = Page.new
    render
  end
  
  def edit(id)
    @page = Page.one(id)
    raise NotFound unless @page
    render
  end
  
  def create(page)
    @page = Page.new(page)
    if @page.save
      redirect url(:publish, :action => :edit, :id => @page.id)
    else
      render :edit
    end
  end
  
  def update(id, page)
    @page = Page.one(id)
    raise NotFound unless @page
    if @page.save
      redirect url(:publish, :action => :edit, :id => @page.id)
    else
      render :edit
    end
  end
  
  def destroy(id)
    @page = Page.one(id)
    raise NotFound unless @page
    @page.destroy
    redirect url(:action => :new)
  end
  
end
