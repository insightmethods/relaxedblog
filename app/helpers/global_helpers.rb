module Merb
  module GlobalHelpers
    def time_lost_in_sensible_words(t)
      if t > (1.day.ago)
        "#{time_lost_in_words(t)} ago"
      else
        t.strftime("%b %d, %I:%M %p")
      end
    end
    
    def show_flash(type = :info)
      @flash = session[:flash][type] if session[:flash]
      unless @flash.blank?
        session[:flash][type] = nil 
        "<ul class=#{type}><li>#{@flash}</li></ul>" 
      end
    end
    
    def flash(type, notice)
      session[:flash] ||= {}
      session[:flash][type] = notice
    end
    
  end
end
