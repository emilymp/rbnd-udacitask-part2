class LinkItem
  include Listable
  attr_reader :description, :site_name, :type

  def initialize(url, options={})
    @type = "link"
    @description = url
    @site_name = options[:site_name] || "None"
  end
  def format_name
    @site_name ? @site_name : ""
  end
  def details
    format_description(@description, @type) + "site name: " + format_name
  end
  def data
    {url: @description, site_name: @site_name}
  end
end