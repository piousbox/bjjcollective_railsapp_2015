
require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl'

Mongo::Logger.logger = ::Logger.new('log/mongo.log')

RSpec.configure do |config|
  
  config.infer_spec_type_from_file_location!

  config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
  config.include RSpecHtmlMatchers
  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

def puts! args, label=""
  puts "+++ +++ #{label}"
  puts args.inspect
end

def setup_categories
  Category.all.each { |c| c.remove }
  @category = @category_0 = FactoryGirl.create :category

  @mounts       = Category.create :title => 'Mounts', :slug => 'mounts'
  @side_control = Category.create :title => 'Side Control', :slug => 'mounts-side-control', :path => 'mounts/side-control', 
                                  :short_slug => 'side-control', :category => @mounts 
end

def setup_questpages
  Questpage.all.each { |q| q.remove }
  @questpage = FactoryGirl.create :questpage
end

def setup_questsets
  Questset.all.each { |q| q.remove }
  
  @questset = FactoryGirl.create :questset
  photo = Photo.new ; photo.unavailable_badge = @questset ; photo.save
  
  @questset_2 = FactoryGirl.create :questset_2
  photo = Photo.new ; photo.unavailable_badge = @questset_2 ; photo.save
  photo = Photo.new
  photo.shaded_badge = @questset_2
  photo.save

  @questset_3 = FactoryGirl.create :questset_3  
  photo = Photo.new ; photo.unavailable_badge = @questset_3 ; photo.save
  photo = Photo.new
  photo.shaded_badge = @questset_3
  photo.save
end

def setup_merit_badges
  MeritBadge.all.each { |b| b.remove }
  @merit_badge = FactoryGirl.create :merit_badge
end

def setup_players
  Player.all.each { |p| p.remove }
  @player = Player.create :user_id => @user.id
end

def setup_users
  User.all.each { |u| u.remove }
  @user = FactoryGirl.create :user
end

def setup_videos
  Video.all.each { |v| v.remove }
  @video_for_questset   = FactoryGirl.create :video_for_questset
  @video_for_questset_1 = FactoryGirl.create :video_for_questset_1
  @video_for_questset_2 = FactoryGirl.create :video_for_questset_2
  @video_for_badge      = FactoryGirl.create :video_for_merit_badge
  @video                = FactoryGirl.create :video
end

# Metaprogrammatical magic to temporarily expose
# a Class' privates (methods).
class Class
  def publicize_methods
    saved_private_instance_methods = self.private_instance_methods
    self.class_eval { public *saved_private_instance_methods }
    yield
    self.class_eval { private *saved_private_instance_methods }
  end
end




