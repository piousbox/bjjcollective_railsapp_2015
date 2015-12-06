
FactoryGirl.define do

  factory :badge, :class => 'MeritBadge' do |f|
    f.title "Some badge"
  end

  factory :user do |f|
    f.email 'user@gmail.com'
    f.password "s1mple123"
  end

  factory :questset do |f|
    f.title 'New Questset'
    f.order_value "jjj" # default
  end

  factory :questset_2, :class => 'Questset' do |f|
    f.title 'questset 2'
    f.order_value "2"
  end

  factory :questset_3, :class => 'Questset' do |f|
    f.title 'questset 3'
    f.order_value "3"
  end  
  
end

