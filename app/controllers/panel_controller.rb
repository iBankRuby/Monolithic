class PanelController < ApplicationController
  before_action :authenticate_user!

  protected

  def show; end
end
