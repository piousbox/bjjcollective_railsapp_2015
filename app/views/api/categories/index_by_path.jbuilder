
if @category
  json.id          @category.id.to_s
  json.title       @category.title
  json.slug        @category.slug
  json.short_slug  @category.short_slug
  json.path        @category.path
end

def render_categories json, categories, path
  json.categories do
    json.array!        categories do |c|
      json.id          c.id.to_s
      json.title       c.title
      json.slug        c.slug
      json.short_slug  c.short_slug
      json.path        c.path
      json.is_expanded ( c.kind == 'simple' ) ? true : false
      
      if c.photo
          json.photo_url   c.photo.photo.url :thumb2
      end
      
      if c.categories.length > 0
        # kind is either simple or thumbs
        if path[0] == c.short_slug || 'simple' == c.kind || 'thumbs' == c.kind
          next_categories = c.categories.where( :short_slug => path[1] )
          
          puts! next_categories.map { |c| c.title }, "In category #{c.title} (#{c.short_slug}), next categories are"
          puts! path, 'and path is.'

          kind = c.kind
          if path[0] == c.short_slug
            kind = 'simple'
          end
          
          if 1 == next_categories.length
            json.kind 'simple'
            render_categories json, next_categories, path.drop( 1 )
          else
            json.kind kind
            render_categories json, c.categories, path.drop( 1 )
          end
        else
          json.kind c.kind
        end
      elsif path[0] == c.short_slug
        json.kind 'simple'
      else
        json.kind c.kind
        # kind is either line or thumb
      end
    end
  end
end

render_categories json, @categories, @path



