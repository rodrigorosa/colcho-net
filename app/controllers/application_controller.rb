class ApplicationController < ActionController::Base
  protect_from_forgery

   before_filter do
   	I18n.locale = params[:locale]
   end

   def default_url_options
   		{ locale: I18n.locale }
   end
end
