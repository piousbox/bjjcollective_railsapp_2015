
if @category
  json.id           @category.id.to_s
  json.title        @category.title
  json.slug         @category.slug
  json.short_slug   @category.short_slug
end

json.categories do
  json.array!         @categories do |c| # mounts, guards, ...
    json.id           c.id.to_s
    json.title        c.title
    json.slug         c.slug
    json.short_slug   c.short_slug
  
    json.categories do
      json.array!        c.categories do |c_1| # DLR guard, x guard, ...
        json.id          c_1.id.to_s
        json.title       c_1.title
        if c_1.photo
          json.photo_url   c_1.photo.photo.url :thumb2
        end
        json.slug        c_1.slug
        json.short_slug  c_1.short_slug
      end
    end
  end
end

if @videos
  json.videos do
    json.array! @videos do |v|
      json.youtube_id   v.youtube_id
      json.title        v.title
      json.descr        v.descr
    end
  end
end

