
if @category
end

def render_categories json, categories, path
  json.categories do
    json.array!        categories do |c|
      json.id          c.id.to_s
      json.title       c.title
      json.slug        c.slug
      json.short_slug  c.short_slug
      json.path        c.path
      json.kind        c.kind
      json.is_expanded ( c.kind == 'simple' ) ? true : false
      
      if c.photo
          json.photo_url   c.photo.photo.url :thumb2
      end
      
      if c.categories && c.categories.length > 0
        if path[0] == c.short_slug || 'simple' == c.kind
          render_categories json, c.categories, path.drop( 1 )
        end
      end
    end
  end
end

render_categories json, @categories, @path



