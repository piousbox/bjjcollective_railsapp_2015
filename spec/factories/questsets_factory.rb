
FactoryBot.define do

  factory :questset do |f|
    f.title 'New Questset'
    f.unaccomplished_order_value "jjj" # default    
  end

  factory :questset_2, :class => 'Questset' do |f|
    f.title 'questset 2'
    f.unaccomplished_order_value "2"
    before :build do |q|
      photo = Photo.new
      photo.shaded_badge = q
      photo.save
    end
  end

  factory :questset_3, :class => 'Questset' do |f|
    f.title 'questset 3'
    f.unaccomplished_order_value "3"
    after :build do |q|
      q.shaded_photo Photo.new
    end
  end
  
end

