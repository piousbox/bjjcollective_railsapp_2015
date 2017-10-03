
json.partial! 'show', :questset => @questset

=begin
json.location_name         @questset.location_name

json.background_image_path   @questset.background_image.photo( :original )
json.background_image_width  @questset.background_image_width
json.background_image_height @questset.background_image_height

json.array @questset.badges do |badge|
  json.partial! 'questsets/show', :questset => badge
end
=end
