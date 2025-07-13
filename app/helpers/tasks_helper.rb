module TasksHelper
    # Return Tailwind classes based on urgency level
    def urgency_color(urgency)
      case urgency.to_s
      when "urgent"
        "text-red-600 font-semibold"
      when "high"
        "text-orange-500 font-medium"
      when "mid"
        "text-yellow-500"
      when "low"
        "text-green-600"
      else
        "text-gray-500"
      end
    end
  
    # Return Tailwind classes based on status
    def status_color(status)
      case status.to_s
      when "unassigned"
        "text-gray-400 italic"
      when "assigned"
        "text-blue-500 font-medium"
      when "started"
        "text-yellow-600 font-medium"
      when "completed"
        "text-green-600 font-semibold"
      when "cancelled"
        "text-red-500 line-through"
      else
        "text-gray-500"
      end
    end
  end