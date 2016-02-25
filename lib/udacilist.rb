class UdaciList
  include HtmlMaker
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end
  
  def add(type, description, options={})
    type = type.downcase
    new_object = validity_check(type, description, options)
    if new_object 
      @items.push(new_object)
    else 
      raise UdaciListErrors::InvalidItemType, "#{type} not a valid type of item"
    end
  end

  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize, "#{index} exceeds list size of #{@items.length}" if index > @items.length
    @items.delete_at(index - 1)
  end

  def filter(type)
    filtered = @items.select { |item| item.item_type == type }
    filtered.empty? ? (puts "no items of type #{type}") : filtered
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def to_html
    items_hash = {todo: filter("todo"), event: filter("event"), link: filter("link"), img: filter("img")}
    create_html(@title, items_hash)
  end

  private

  def validity_check(type, description, options)
    new_object = TodoItem.new(description, options) if type == "todo"
    new_object = EventItem.new(description, options) if type == "event"
    new_object = LinkItem.new(description, options) if type == "link"
    new_object = ImageItem.new(description, options) if type == "img"
    return new_object 
  end

end
