class Task < ApplicationRecord
  belongs_to :created_by, class_name: "User"
  belongs_to :assigned_to, class_name: "User", optional: true
  belongs_to :visible_up_to, class_name: "Group"

  enum :urgency,  [:urgent, :high, :mid, :low], default: :mid
  enum :status,  [:unassigned, :assigned, :started, :completed, :cancelled], default: :unassigned

  validates :name, presence: true
  validates :urgency, presence: true
  validates :status, presence: true
end