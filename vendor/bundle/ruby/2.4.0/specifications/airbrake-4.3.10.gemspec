# -*- encoding: utf-8 -*-
# stub: airbrake 4.3.10 ruby lib

Gem::Specification.new do |s|
  s.name = "airbrake".freeze
  s.version = "4.3.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Airbrake".freeze]
  s.date = "2018-09-28"
  s.email = "support@airbrake.io".freeze
  s.executables = ["airbrake".freeze]
  s.files = ["bin/airbrake".freeze]
  s.homepage = "http://www.airbrake.io".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Send your application errors to our hosted service and reclaim your inbox.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<multi_json>.freeze, [">= 0"])
      s.add_development_dependency(%q<bourne>.freeze, ["~> 1.4.0"])
      s.add_development_dependency(%q<cucumber-rails>.freeze, ["~> 1.1.1"])
      s.add_development_dependency(%q<fakeweb>.freeze, ["~> 1.3.0"])
      s.add_development_dependency(%q<nokogiri>.freeze, ["~> 1.5.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.6.0"])
      s.add_development_dependency(%q<sham_rack>.freeze, ["~> 1.3.0"])
      s.add_development_dependency(%q<json-schema>.freeze, ["~> 1.0.12"])
      s.add_development_dependency(%q<capistrano>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<aruba>.freeze, [">= 0"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<girl_friday>.freeze, [">= 0"])
      s.add_development_dependency(%q<sucker_punch>.freeze, ["= 1.0.2"])
      s.add_development_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
      s.add_development_dependency(%q<shoulda-context>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 4.0"])
      s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    else
      s.add_dependency(%q<builder>.freeze, [">= 0"])
      s.add_dependency(%q<multi_json>.freeze, [">= 0"])
      s.add_dependency(%q<bourne>.freeze, ["~> 1.4.0"])
      s.add_dependency(%q<cucumber-rails>.freeze, ["~> 1.1.1"])
      s.add_dependency(%q<fakeweb>.freeze, ["~> 1.3.0"])
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.5.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.6.0"])
      s.add_dependency(%q<sham_rack>.freeze, ["~> 1.3.0"])
      s.add_dependency(%q<json-schema>.freeze, ["~> 1.0.12"])
      s.add_dependency(%q<capistrano>.freeze, ["~> 2.0"])
      s.add_dependency(%q<aruba>.freeze, [">= 0"])
      s.add_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
      s.add_dependency(%q<girl_friday>.freeze, [">= 0"])
      s.add_dependency(%q<sucker_punch>.freeze, ["= 1.0.2"])
      s.add_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
      s.add_dependency(%q<shoulda-context>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 4.0"])
      s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<builder>.freeze, [">= 0"])
    s.add_dependency(%q<multi_json>.freeze, [">= 0"])
    s.add_dependency(%q<bourne>.freeze, ["~> 1.4.0"])
    s.add_dependency(%q<cucumber-rails>.freeze, ["~> 1.1.1"])
    s.add_dependency(%q<fakeweb>.freeze, ["~> 1.3.0"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.5.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.6.0"])
    s.add_dependency(%q<sham_rack>.freeze, ["~> 1.3.0"])
    s.add_dependency(%q<json-schema>.freeze, ["~> 1.0.12"])
    s.add_dependency(%q<capistrano>.freeze, ["~> 2.0"])
    s.add_dependency(%q<aruba>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<girl_friday>.freeze, [">= 0"])
    s.add_dependency(%q<sucker_punch>.freeze, ["= 1.0.2"])
    s.add_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda-context>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 4.0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
  end
end
