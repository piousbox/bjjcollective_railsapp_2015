
class FightersGuild::FightersGuildController < ApplicationController
  
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_registration_path, :alert => exception.message
  end
  
end

