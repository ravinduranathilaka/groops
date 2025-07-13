class Group < ApplicationRecord
  belongs_to :parent, class_name: 'Group', optional: true
  has_many :children, class_name: 'Group', foreign_key: 'parent_id'
end
