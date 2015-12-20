
FactoryGirl.define do
  
  factory :video do |f|
    f.title "Some video"
    f.youtube_id "1234567890a"
    f.legacy_id 123
  end

  factory :video_for_questset, :class => 'Video' do |f|
    f.title "video for questset"
    f.youtube_id "1234567890b"
    f.order_value "jjj_1"
    f.questset_id ( Questset.where( :title => 'New Questset' ).first || Questset.all.first || Questset.new ).id # @TODO: wtf is this?
  end
  factory :video_for_questset_1, :class => 'Video' do |f|
    f.title "video for questset"
    f.youtube_id "1234567890c"
    f.order_value "jjj_3"
    f.questset_id ( Questset.where( :title => 'New Questset' ).first || Questset.all.first || Questset.new ).id # @TODO: wtf is this?
  end
  factory :video_for_questset_2, :class => 'Video' do |f|
    f.title "video for questset"
    f.youtube_id "1234567890d"
    f.order_value "jjj_2"
    f.questset_id ( Questset.where( :title => 'New Questset' ).first || Questset.all.first || Questset.new ).id # @TODO: wtf is this?
  end

  factory :video_for_merit_badge, :class => 'Video'  do |f|
    f.title "Video for merit badge"
    f.youtube_id "1234567890e"
    f.merit_badge_id ( MeritBadge.all.first ).id
  end

end

