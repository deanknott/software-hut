# -*- encoding: utf-8 -*-
# stub: delayed-plugins-airbrake 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "delayed-plugins-airbrake".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Benjamin Oakes".freeze, "Romain Champourlier".freeze, "Grant Hollingworth".freeze, "Nathan Broadbent".freeze]
  s.date = "2013-12-11"
  s.description = "delayed_job exception notification with airbrake".freeze
  s.email = ["hello@benjaminoakes.com".freeze]
  s.homepage = "".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Notify Airbrake on Delayed Job errors, including those on PerformableMethod.  Packaged for use from https://gist.github.com/granth/2223758 and http://stackoverflow.com/questions/12683364/how-to-make-delayed-job-notify-airbrake-when-an-actionmailer-runs-into-an-error.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<airbrake>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<delayed_job>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<airbrake>.freeze, [">= 0"])
      s.add_dependency(%q<delayed_job>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<airbrake>.freeze, [">= 0"])
    s.add_dependency(%q<delayed_job>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
