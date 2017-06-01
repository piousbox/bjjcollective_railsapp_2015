
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
  
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end

def puts! args, label=""
  puts "+++ +++ #{label}"
  puts args.inspect
end

def setup_categories
  Category.all.each { |c| c.remove }
  @category = @category_0 = FactoryGirl.create :category

  @mounts = Category.create :title => 'Mounts', :slug => 'mounts'
  @side_control = Category.create( :title => 'Side Control', :slug => 'mounts-side-control', :path => 'mounts/side-control', :short_slug => 'side-control',
                                   :category => @mounts )
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




