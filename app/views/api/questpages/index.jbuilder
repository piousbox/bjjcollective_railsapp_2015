
#
# api / questpages / index.jbuilder
#

json.array! @questpages do |page|
  json.title       page.title
  json.slug        page.slug
  json.subtitle    page.subtitle
  json.description page.description

  json.questsets do
    page.questsets.each do |questset|
      json.partial! 'api/questsets/show', :questset => questset
    end
  end

end
