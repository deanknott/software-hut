# -*- encoding: utf-8 -*-
# stub: epi_js 1.0.13 ruby lib

Gem::Specification.new do |s|
  s.name = "epi_js".freeze
  s.version = "1.0.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Shuo Chen".freeze, "Ryan Bibby".freeze]
  s.date = "2019-04-09"
  s.description = "jQuery scripts used in various projects".freeze
  s.email = ["s.chen@epigenesys.co.uk".freeze]
  s.homepage = "https://github.com/epigenesys/epi-js".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "jQuery scripts used in various projects".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.0"])
      s.add_runtime_dependency(%q<coffee-rails>.freeze, [">= 3.2"])
      s.add_runtime_dependency(%q<sass-rails>.freeze, [">= 3.2"])
      s.add_runtime_dependency(%q<bootstrap-sass>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.0"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.0"])
      s.add_dependency(%q<coffee-rails>.freeze, [">= 3.2"])
      s.add_dependency(%q<sass-rails>.freeze, [">= 3.2"])
      s.add_dependency(%q<bootstrap-sass>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.0"])
      s.add_dependency(%q<rails>.freeze, [">= 3.0"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.0"])
    s.add_dependency(%q<coffee-rails>.freeze, [">= 3.2"])
    s.add_dependency(%q<sass-rails>.freeze, [">= 3.2"])
    s.add_dependency(%q<bootstrap-sass>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.0"])
  end
end
