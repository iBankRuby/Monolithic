class ExceedingRequestsController < ApplicationController
  before_action :set_exceeding_request, only: :destroy

  attr_reader :exceeding_request

  def create
    @exceeding_request = ExceedingRequest.new(exceeding_request_params)
    exceeding_request.account_user = AccountUser.find_by(account_id: params[:account_id], user_id: current_user.id)
    if exceeding_request.save
      redirect_to accounts_url, notice: 'Request have sent successfully.'
    else
      redirect_to accounts_url, notice: 'Oops... Request have not sent.'
    end
  end

  def destroy
    exceeding_request.delete
  end

  private

  def set_exceeding_request
    @exceeding_request = ExceedingRequest.find(params[:id])
  end

  def exceeding_request_params
    params.fetch(:exceeding_request).permit(:amount)
  end
end
