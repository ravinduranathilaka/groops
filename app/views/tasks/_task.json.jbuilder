json.extract! task, :id, :name, :description, :created_by_id, :assigned_to_id, :visible_up_to_id, :urgency, :status, :assigned_on, :completed_on, :created_at, :updated_at
json.url task_url(task, format: :json)
