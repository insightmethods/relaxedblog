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
    
    def current_user
      @current_user ||= User.find_by_id(session[:current_user])
    end

    def current_user=(new_user)
      session[:current_user] = new_user.is_a?(User) ? new_user.id : nil
    end

    def login_required
      authorized? || throw(:halt, :access_denied)
    end

    def logged_in?
      !!current_user
    end

    def authorized?
      logged_in?
    end

    def access_denied
      case content_type
      when :html
        store_location
        redirect url(:login)
      when :xml
        basic_authentication.request
      end
    end

    def store_location
      session[:return_to] = request.uri
    end

    def redirect_back_or_default(default)
      loc = session[:return_to] || default
      session[:return_to] = nil
      redirect loc
    end
  end
end
