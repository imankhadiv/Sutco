class PagesController < ApplicationController
  before_filter :authenticate_user!

  def welcome
    @current_nav_identifier = :dashboard
  end

  def awaiting

  end
end