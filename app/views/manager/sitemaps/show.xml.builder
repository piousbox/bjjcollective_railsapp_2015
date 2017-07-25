xml.instruct! # :xml, :version => '1.0', :encoding => 'utf-8'
xml.urlset :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc "#{@prefix}#{@category.path}"
  end

  @categories.each do |category|
    xml.url do
      xml.loc "#{@prefix}/#{category.path}"
    end

    if category.categories && category.categories.count > 0
      xml << render( :partial => 'manager/sitemaps/categories', 
                     :locals => { :categories => category.categories, :depth => 100 })
    end

  end

end
