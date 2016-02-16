
if @category
end

json.categories do
  json.array!        @categories do |c|
    json.id          c.id.to_s
    json.title       c.title
    json.slug        c.slug
    json.short_slug  c.short_slug
    json.path        c.path
    json.kind        c.kind

    json.categories do
      json.array!   c.categories do |c_1|
        json.id     c_1.id.to_s
        json.title  c_1.title
        json.slug   c_1.slug
        json.kind   c_1.kind
      end
    end
  end
end


