
json.quest do
  json.id            @badge.id.to_s
  json.location_name @badge.location_name
  json.title         @badge.title
  json.subtitle      @badge.subtitle
  json.description   @badge.descr
end
json.tasks  @badge.tasks.to_a
json.videos @badge.videos.to_a


