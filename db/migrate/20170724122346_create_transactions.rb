class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :user, show: true
      t.belongs_to :account, show: true
      t.string :remote_account_id
      t.float :summ
      t.boolean :status_from, default: true
      t.boolean :status_to, default: false
      t.datetime :checkout_from     # time of user answer for approve question
      t.datetime :checkout_to
      t.timestamps
    end
  end
end
