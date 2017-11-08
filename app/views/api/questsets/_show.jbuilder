
json.location_name questset.location_name # unless questset.location_name.blank?
json.title         questset.title         # unless questset.title.blank?
json.subtitle      questset.subtitle      # unless questset.subtitle.blank?
json.description   questset.descr         # unless questset.descr.blank?
json.bg_pos_x      questset.bg_pos_x      # unless questset.bg_pos_x.blank?
json.bg_pos_y      questset.bg_pos_y      # unless questset.bg_pos_y.blank?

if questset.shaded_photo
  json.shaded_photo questset.shaded_photo.photo( :thumb )
end

if questset.accomplished_photo
  json.accomplished_photo questset.accomplished_photo.photo( :thumb )
end

if questset.background_image
  json.background_image_path   questset.background_image.photo( :original )
  json.background_image_width  questset.background_image_width
  json.background_image_height questset.background_image_height
end

json.is_premium questset.is_premium
if questset.is_premium
  # do I already own it?
  if @current_profile && @current_profile.bought_badges.include?( questset )
    json.is_bought true
  end
  json.cost          questset.cost
  json.created_email questset.created_profile ? questset.created_profile.email : nil
end

unless questset.badges.blank?
  json.badges do
    json.array! questset.badges do |badge|
      json.partial! 'api/questsets/show', :questset => badge
    end
  end
end

