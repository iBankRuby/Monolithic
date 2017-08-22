class ExceedingRequestsController < ApplicationController
  before_action :set_exceeding_request, only: %i[update destroy]

  attr_reader :exceeding_request

  def create
    @exceeding_request = ExceedingRequest.new(exceeding_request_params)
    exceeding_request.account = Account.friendly.find(params[:account_id])
    exceeding_request.user = current_user
    if exceeding_request.save
      redirect_to accounts_url, notice: 'Request has been sent successfully.'
    else
      redirect_to accounts_url, alert: 'Oops... Request has not been sent.'
    end
  end

  def update
    status = exceeding_request_params[:status].eql?('true')
    if exceeding_request.update(status: status)
      status && exceeding_request.update_rule
      redirect_to accounts_url,
                  notice: (status ? 'Request has been successfully confirmed' : 'Request has been rejected')
    else
      redirect_to accounts_url, alert: 'Invalid params'
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
    params.fetch(:exceeding_request).permit(:amount, :status)
  end
end
