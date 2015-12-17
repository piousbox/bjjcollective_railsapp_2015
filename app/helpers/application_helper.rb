
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

  def logo_image_tag
    image_tag "icons/40x40/bjjc_logo.jpg"
  end
  
end
