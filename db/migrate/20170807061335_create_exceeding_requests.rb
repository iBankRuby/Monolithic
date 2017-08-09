class CreateExceedingRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :exceeding_requests do |t|
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
