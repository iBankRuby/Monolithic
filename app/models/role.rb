class Role < ApplicationRecord
  validates :name, uniqueness: true
  belongs_to :rule, optional: true
  belongs_to :limit, optional: true
end
