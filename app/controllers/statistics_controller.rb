class StatisticsController < ApplicationController
  include StatisticsBuilder

  def index
    build_responce
  end

  def create
    get_statistics
  end
end
