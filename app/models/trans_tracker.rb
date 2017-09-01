class TransTracker < ApplicationRecord
  belongs_to :trans, optional: true, class_name: 'Transaction'
end
