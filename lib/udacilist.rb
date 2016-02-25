class UdaciList
  include HtmlMaker
  attr_reader :title, :items, :types


  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @types = {todo: TodoItem, event: EventItem, link: LinkItem, img: ImageItem}
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
    filtered = @items.select { |item| item.type == type }
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
    @types[type.to_sym].new(description, options) if @types.key? type.to_sym
  end

end
