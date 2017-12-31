
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

json.video do
  json.id          @video.id.to_s
  json.youtube_id  @video.youtube_id
  json.title       @video.title
  json.descr       @video.descr
end

