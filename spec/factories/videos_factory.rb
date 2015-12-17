
FactoryGirl.define do
  
  factory :video do |f|
    f.title "Some video"
  end

  factory :video_for_questset, :class => 'Video' do |f|
    f.title "video for questset"
    f.questset_id ( Questset.where( :title => 'New Questset' ).first || Questset.all.first || Questset.new ).id # @TODO: wtf is this?
  end

  factory :video_for_merit_badge, :class => 'Video'  do |f|
    f.title "Video for merit badge"
    f.merit_badge_id ( MeritBadge.all.first || MeritBadge.create( :title => 'xxtitlexx' ) ).id
  end

end

