class ImageItem
  include Listable
  attr_reader :description, :src, :type

  def initialize(description, options={})
    @type = "img"
    @description = description
    @src = options[:src]
  end
  
  def details
    format_description(@description) + "source: " + @src
  end
  
  def data
    {description: @description, source: @src}
  end
end