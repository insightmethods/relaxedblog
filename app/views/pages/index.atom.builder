xml.instruct! :xml, :version=>"1.0" 
xml.feed(:xmlns => "http://www.w3.org/2005/Atom") do |feed|
  feed.title('InsightMethods')
  feed.id("http://blog.insightmethods.com")
  feed.updated(@pages.first.created_at.iso8601)
  feed.link(:href => 'http://blog.insightmethods.com/', :rel => "self")
  @pages.each do |page|
    feed.entry do |entry|
      uuid = 'urn:uuid:' + page.id
      entry.id(uuid)
      url = absolute_url(:page, :id => page.id)
      entry.link(:href => url)
      entry.title( page.title)
      entry.content(page.content_html, :type => 'html')
      entry.updated(page.created_at.iso8601)
      if page.author
        entry.author do |author|
          author.name(page.author.name)
        end
      end
    end
  end
end