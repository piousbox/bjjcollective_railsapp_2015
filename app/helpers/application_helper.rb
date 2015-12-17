
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
  
end
