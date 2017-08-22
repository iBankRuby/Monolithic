class ExpireTransactionsWorker
  include Sidekiq::Worker

  def perform(id)
    # Do something
    transaction = Transaction.find(id)
    transaction.expire! if transaction.may_expire?
  end
end
