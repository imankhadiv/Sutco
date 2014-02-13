class PagesController < ApplicationController
  #before_filter :authenticate_user!

  def welcome
    authenticate_user!
    @current_nav_identifier = :home
  end

  def awaiting

  end
end