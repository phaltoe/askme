class HomeController < ApplicationController
  def welcome
    render layout: false
  end
end
