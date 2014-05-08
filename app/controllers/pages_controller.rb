class PagesController < ApplicationController
  #before_filter :authenticate_user!

  #Home page
  def welcome
    authenticate_user!
    @current_nav_identifier = :home
  end

  #page for after user has signed up but is not yet activated
  def awaiting

  end
end