class ErrorsController < ApplicationController
  def not_found
    @disable_nav = true
  end
end
