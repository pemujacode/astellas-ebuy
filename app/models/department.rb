class Department < ApplicationRecord
  belongs_to :costcenter, optional: true
  belongs_to :expense, optional: true
  #validates :name,:costcenter_id,:expense_id, presence: true
  validates :name, uniqueness: true

end
