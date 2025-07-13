class Task < ApplicationRecord
  belongs_to :created_by, class_name: "User"
  belongs_to :assigned_to, class_name: "User", optional: true
  belongs_to :visible_up_to, class_name: "Group"

  enum urgency: { urgent: 0, high: 1, mid: 2, low: 3 }
  enum status: { unassigned: 0, assigned: 1, started: 2, completed: 3, cancelled: 4 }

  validates :name, presence: true
  validates :urgency, presence: true
  validates :status, presence: true
end