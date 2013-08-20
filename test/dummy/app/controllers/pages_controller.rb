class PagesController < ApplicationController

  def index
    @models = Model.page(params[:p] || 1).per(1)
  end

end
