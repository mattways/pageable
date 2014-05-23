class PagesController < ApplicationController

  def index
    @collection = Model.page((params[:p] || 1), length: 1)
  end

end
