
FactoryGirl.define do

  factory :questpage do |f|
    f.title 'New Questpage'
    # f.order_value "jjj" # default    
  end

a=<<-EOL
  factory :questset_2, :class => 'Questset' do |f|
    f.title 'questset 2'
    f.order_value "2"
    before :build do |q|
      photo = Photo.new
      photo.shaded_badge = q
      photo.save
    end
  end

  factory :questset_3, :class => 'Questset' do |f|
    f.title 'questset 3'
    f.order_value "3"
    after :build do |q|
      q.shaded_photo Photo.new
    end
  end
EOL

end

