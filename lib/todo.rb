class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type

  def initialize(description, options={})
    @description = description
    @type = "todo"
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    raise UdaciListErrors::InvalidPriorityValue, "#{options[:priority]} is not a valid priority value" unless priority_valid
    
  end

  def details
    format_description(@description) + "due: " +
    format_date(start_date: @due, str: "No due date") +
    format_priority(@priority)
  end

  private

  def priority_valid
    (%w(high medium low).include? @priority) || !@priority
  end

end
