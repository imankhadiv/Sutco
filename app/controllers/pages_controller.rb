class PagesController < ApplicationController
  #before_filter :authenticate_user!

  #Home page
  def welcome
    authenticate_user!
    @current_nav_identifier = :home
  end

  #page for after sign up but not yet activated
  def awaiting

  end
end