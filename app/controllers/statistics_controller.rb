class StatisticsController < ApplicationController
  include StatisticsBuilder

  def index
    # build_responce    
  	get_statistics
  end

  def create  	
    redirect_to account_statistics_path(@transactions)
  end
end
