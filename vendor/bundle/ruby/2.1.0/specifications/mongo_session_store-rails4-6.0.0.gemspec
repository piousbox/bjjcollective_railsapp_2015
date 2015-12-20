# -*- encoding: utf-8 -*-
# stub: mongo_session_store-rails4 6.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mongo_session_store-rails4"
  s.version = "6.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Brian Hempel", "Nicolas M\u{e9}rouze", "Tony Pitale", "Chris Brickley"]
  s.date = "2015-03-30"
  s.email = ["plasticchicken@gmail.com"]
  s.homepage = "http://github.com/brianhempel/mongo_session_store"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Rails session stores for MongoMapper, Mongoid, or any other ODM. Rails 3.1, 3.2, 4.0, and 4.1 compatible."

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 3.1"])
    else
      s.add_dependency(%q<actionpack>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 3.1"])
  end
end
