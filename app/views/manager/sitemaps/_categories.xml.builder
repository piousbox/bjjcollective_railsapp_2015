
categories.each do |category|
  xml.url do
    xml.loc "#{@prefix}/#{category.path}"
  end

  if category.categories && category.categories.count > 0 && depth > 0
    xml << render( 'manager/sitemaps/categories', :categories => category.categories, :depth => depth-1 )
  end
end
