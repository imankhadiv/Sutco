class PagesController < ApplicationController
  #before_filter :authenticate_user!

  def welcome
    authenticate_user!
    @current_nav_identifier = :dashboard
  end

  def awaiting

  end
end