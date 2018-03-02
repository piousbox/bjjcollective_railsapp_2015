
FactoryBot.define do
  
  factory :category do |f|
    f.title 'some-title'
  end

  factory :next_category, :class => Category do |f|
    f.title 'some-title'
  end

end

