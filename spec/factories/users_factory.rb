
FactoryGirl.define do

  factory :user do |f|
    f.email 'user@gmail.com'
    f.password "s1mple123"
  end
  
  factory :user_2, :class => 'User' do |f|
    f.email 'user_2@gmail.com'
    f.password "s1mple123"
  end

end

