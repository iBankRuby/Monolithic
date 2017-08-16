class StatisticsController < ApplicationController
  include StatisticsBuilder

  def index
  	get_statistics if params[:utf8]
  end

  def create  	
    redirect_to account_statistics_path(@transactions)
  end
end
