module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(25)
  end

  def format_priority(priority)
    value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end

  def format_date(op={})
    start_date = op[:start_date]
    end_date = op[:end_date]
    str = op[:str]
    dates = (start_date).strftime("%D") if start_date
    dates << " -- " + (end_date).strftime("%D") if end_date
    dates = str if !dates
    return dates
  end

    def item_type
      self.type
    end
end
