class Group < ApplicationRecord
  belongs_to :parent, class_name: 'Group', optional: true
  has_many :children, class_name: "Group", foreign_key: "parent_id"

  # Breadth-First Search to get all descendant IDs
  def bfs_descendant_ids
    ids = []
    queue = [self]
    visited = Set.new
  
    while queue.any?
      current = queue.shift
      next if visited.include?(current.id) # skip if already seen
      visited << current.id
  
      ids << current.id
      queue.concat(current.children)
    end
    ids
  end
end