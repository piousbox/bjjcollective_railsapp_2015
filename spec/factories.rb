
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
  end
  
end

