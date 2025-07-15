Rails.application.config.after_initialize do
    if defined?(SolidCable::Record)
      SolidCable::Record.connects_to database: { writing: :primary }
    end
  end