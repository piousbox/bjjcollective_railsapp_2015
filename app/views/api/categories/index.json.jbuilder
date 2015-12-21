
json.array! @categories do |c| # mounts, guards, ...
  json.id c.id.to_s
  json.title c.title

  json.categories do
    json.array! c.categories do |c_1| # DLR guard, x guard, ...
      json.id c_1.id.to_s
      json.title c_1.title
      json.photo_url c_1.photo.photo.url :thumb2

      json.categories do
        json.array! c_1.categories do |c_2|
          json.id c_2.id.to_s
          json.title c_2.title

          json.categories do
            json.array! c_2.categories do |c_3|
              json.id c_3.id.to_s
              json.title c_3.title

              json.categories do
                json.array! c_3.categories do |c_4|
                  json.id c_4.id.to_s
                  json.title c_4.title

                  json.categories do
                    json.array! c_4.categories do |c_5|
                      json.id c_5.id.to_s
                      json.title c_5.title
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

