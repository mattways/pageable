class PagesController < ApplicationController

  def index
    @collection = Record.page((params[:page] || 1), length: 1)
  end

end
