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
    if exceeding_request_params[:status].eql?('true')
      invalid_redirect unless exceeding_request.may_confirm?
      exceeding_request.confirm! && exceeding_request.update_rule
      redirect_to accounts_url, notice: 'Request has successfully confirmed'
    else
      invalid_redirect unless exceeding_request.may_reject?
      exceeding_request.reject! && redirect_to(accounts_url, notice: 'Request has been rejected')
    end
  end

  def destroy
    exceeding_request.delete
  end

  private

  def invalid_redirect
    redirect_to accounts_url, alert: 'Invalid params'
  end

  def set_exceeding_request
    @exceeding_request = ExceedingRequest.find(params[:id])
  end

  def exceeding_request_params
    params.fetch(:exceeding_request).permit(:amount, :status)
  end
end
