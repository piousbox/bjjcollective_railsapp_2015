
FactoryBot.define do
  
  factory :category do |f|
    f.title 'some-title'
    f.slug 'slug'
    f.path '/one'
  end

  factory :next_category, :class => Category do |f|
    f.title 'some-title'
    f.slug 'slug/slug-2'
    f.short_slug 'slug-2'
    f.path '/one/two'
    after :build do |c|
      c.category = Category.find_by :title => 'Technique'
    end
  end

end

