module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(25)
  end

  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:magenta) if priority == "medium"
    value = " ⇩".colorize(:blue) if priority == "low"
    value = "" if !priority
    return value
  end

  def format_date(op={})
    start_date = op[:start_date]
    end_date = op[:end_date]

    dates = (start_date).strftime("%D") if start_date
    dates << " -- " + (end_date).strftime("%D") if end_date
    dates = op[:str] if !dates
    return dates
  end

    def item_type
      self.type
    end
end
