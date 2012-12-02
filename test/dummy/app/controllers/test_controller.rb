class TestController < ApplicationController

  def index
    @collection = Model.page(3).per(2)
  end

end
