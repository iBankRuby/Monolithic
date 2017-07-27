class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account
  validates :remote_account_id, :summ, presence: true
  validates :summ, numericality: { greater_than_or_equal_to: 0.01 }

  def transfer_cookie(iban, summ)
    puts '!!!!!!!!!!!!!!!!!!!!'
    acc_to_transfer = Account.find_by(iban: iban)
    acc_to_transfer += summ
    acc_to_transfer.save
  end
end
