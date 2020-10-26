# -*- encoding: utf-8 -*-
# stub: devise_ldap_authenticatable 0.8.6 ruby lib

Gem::Specification.new do |s|
  s.name = "devise_ldap_authenticatable".freeze
  s.version = "0.8.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Curtis Schiewek".freeze, "Daniel McNevin".freeze, "Steven Xu".freeze]
  s.date = "2018-02-13"
  s.description = "Devise extension to allow authentication via LDAP".freeze
  s.email = "curtis.schiewek@gmail.com".freeze
  s.homepage = "https://github.com/cschiewek/devise_ldap_authenticatable".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Devise extension to allow authentication via LDAP".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<devise>.freeze, [">= 3.4.1"])
      s.add_runtime_dependency(%q<net-ldap>.freeze, [">= 0.16.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0.9"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 3"])
      s.add_development_dependency(%q<rails>.freeze, [">= 4.0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<factory_girl_rails>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<factory_girl>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>.freeze, [">= 0"])
      s.add_development_dependency(%q<capybara>.freeze, [">= 0"])
      s.add_development_dependency(%q<launchy>.freeze, [">= 0"])
    else
      s.add_dependency(%q<devise>.freeze, [">= 3.4.1"])
      s.add_dependency(%q<net-ldap>.freeze, [">= 0.16.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0.9"])
      s.add_dependency(%q<rdoc>.freeze, [">= 3"])
      s.add_dependency(%q<rails>.freeze, [">= 4.0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<factory_girl_rails>.freeze, ["~> 1.0"])
      s.add_dependency(%q<factory_girl>.freeze, ["~> 2.0"])
      s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
      s.add_dependency(%q<database_cleaner>.freeze, [">= 0"])
      s.add_dependency(%q<capybara>.freeze, [">= 0"])
      s.add_dependency(%q<launchy>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<devise>.freeze, [">= 3.4.1"])
    s.add_dependency(%q<net-ldap>.freeze, [">= 0.16.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0.9"])
    s.add_dependency(%q<rdoc>.freeze, [">= 3"])
    s.add_dependency(%q<rails>.freeze, [">= 4.0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<factory_girl_rails>.freeze, ["~> 1.0"])
    s.add_dependency(%q<factory_girl>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<database_cleaner>.freeze, [">= 0"])
    s.add_dependency(%q<capybara>.freeze, [">= 0"])
    s.add_dependency(%q<launchy>.freeze, [">= 0"])
  end
end
