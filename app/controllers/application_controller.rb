class ApplicationController < ActionController::Base
  add_flash_types :success, :error
  @@host = ENV['HOST_URL']
end
