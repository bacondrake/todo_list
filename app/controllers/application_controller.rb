class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    
    def set_api_time_zone
        utc_offset = current_user_session && current_user_session.user ? current_user_session.user.time_zone_offset.to_i.minutes : 0
        user_timezone = ActiveSupport::TimeZone[utc_offset]
        Time.zone = user_timezone if user_timezone
    end
end
