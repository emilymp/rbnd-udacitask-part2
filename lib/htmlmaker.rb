module HtmlMaker

  def new_markup(filename)
    file = File.new(filename, "w+")
    Builder::XmlMarkup.new(indent: 2, target: file)
  end

  def parse_tables(page, items)
    make_table(page, "To Do", items[:todo], ["Description", "Due Date", "Priority"]) if items[:todo]
    make_table(page, "Links", items[:link], ["Description", "Site Name"]) if items[:link]
    make_table(page, "Events", items[:event], ["Description", "Start Date", "End Date"]) if items[:event]
    make_table(page, "Images", items[:img], ["Description", "Image"]) if items[:img]
  end

  def create_html(title, items)
    page = new_markup(title)
    page.html do
      page.head do
        page.title(title)
      end
      page.body do
        page.h1(title)
        parse_tables(page, items)
      end
    end
  end

def link_check(page, key, value)
  if key == :url
    page.td { page.a(value, href: value) }
  elsif key == :source
    page.td { page.img(src: value, alt: "image") }
  else
    page.td(value)
  end
end



def make_table(page, title, items, row_names)
  page.h4(title)
  page.table(style: "width:50%", border: "1") do
    page.tr do
      row_names.each { |row_name| page.th row_name }
    end
    items.each do |item|
      page.tr do
        item.data.each { |key, value| link_check(page, key, value) }
      end
    end
  end
  page.br
end


end