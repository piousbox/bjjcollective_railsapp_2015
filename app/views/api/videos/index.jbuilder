
if @category
  json.category do
    json.id           @category.id.to_s
    json.title        @category.title
    json.slug         @category.slug
    json.short_slug   @category.short_slug
    json.path         @category.path
    json.kind         @category.kind
  end
end

json.n_videos @videos.length

json.videos do
  json.array! @videos do |v|
    json.id         v.id.to_s
    json.title      v.title
    json.youtube_id v.youtube_id
  end
end

