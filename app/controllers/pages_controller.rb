class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
     @nav=true
    @document = Document.first
  end
  


end
