
json.title @questpage.title
json.slug @questpage.slug
json.subtitle @questpage.subtitle
json.description @questpage.description

json.questsets do
  json.array! @questpage.questsets do |set|
    json.partial! 'api/questsets/show', :questset => set
  end
end

