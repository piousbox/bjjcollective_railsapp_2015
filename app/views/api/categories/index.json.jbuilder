
json.array!         @categories do |c| # mounts, guards, ...
  json.id           c.id.to_s
  json.title        c.title
  json.slug         c.slug
  json.short_slug   c.short_slug
  
  json.categories do
    json.array!        c.categories do |c_1| # DLR guard, x guard, ...
      json.id          c_1.id.to_s
      json.title       c_1.title
      json.photo_url   c_1.photo.photo.url :thumb2
      json.slug        c_1.slug
      json.short_slug  c_1.short_slug

      json.categories do
        json.array!        c_1.categories do |c_2|
          json.id          c_2.id.to_s
          json.title       c_2.title
          json.slug        c_2.slug
          json.short_slug  c_2.short_slug
          
          json.categories do
            json.array!        c_2.categories do |c_3|
              json.id          c_3.id.to_s
              json.title       c_3.title
              json.slug        c_3.slug
              json.short_slug  c_3.short_slug
              
              json.categories do
                json.array!        c_3.categories do |c_4|
                  json.id          c_4.id.to_s
                  json.title       c_4.title
                  json.slug        c_4.slug
                  json.short_slug  c_4.short_slug
                  
                  json.categories do
                    json.array!        c_4.categories do |c_5|
                      json.id          c_5.id.to_s
                      json.title       c_5.title
                      json.slug        c_5.slug
                      json.short_slug  c_5.short_slug
                      
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

