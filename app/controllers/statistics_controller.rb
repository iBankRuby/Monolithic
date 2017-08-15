class StatisticsController < ApplicationController
  include StatisticsBuilder

  def index
    # build_responce
  end

  def create
  	binding.pry
    get_statistics
  end
end
