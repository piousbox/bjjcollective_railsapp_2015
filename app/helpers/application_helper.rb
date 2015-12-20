
module ApplicationHelper

  def show_category_path string
    "/categories/#{string}"
  end

  def puts! args, label=""
    puts "+++ +++ #{label}"
    puts args.inspect
  end

  def ads_enabled?
    true
  end

  def categories_tree_type
    if Rails.env.production?
      return "partial"
    else
      return "helper"
    end
  end
  
  def logo_image_tag
    image_tag "icons/80x80/bjjc_logo.jpg"
  end

  def category_human_path category
    "/categories/view/#{category.slug}"
  end

  def category_path category
    "/categories/view/#{category.slug}"
  end

  #
  # see partial categories/_tree for the original
  #
  def categories_tree categories, category=nil
    if category
      out =<<-EOL
<ul id="#{category.id}">
EOL
    else
      out = "<ul>"
    end
    categories.each do |c|
      outt = "<li>"
      if c.categories.length > 0
        outt += '<span class="category-name">'
        if c.photo
          outt +=<<-EOL
<img src="#{c.photo.photo.url :mini}" alt="" />
EOL
        end
        if c.title
          outt += c.title
        end
        outt += '<a class="addToggle">[+]</a>'
        outt += categories_tree( c.categories, c )
      else
        outt += '<span class="categori-leaf-name">'
        if c.photo
          outt +=<<-EOL
<img src="#{c.photo.photo.url :mini}" alt="" />
EOL
        end
        outt += link_to c.title, category_human_path( c )
        # outt += "(#{c.videos.length})" # very slow
      end
      outt += "</li>"
      out += outt
    end
    out += "</ul>"
    return out
  end

end
