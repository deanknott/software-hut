# -*- encoding: utf-8 -*-
# stub: epi_deploy 2.0.11 ruby lib

Gem::Specification.new do |s|
  s.name = "epi_deploy".freeze
  s.version = "2.0.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Anthony Nettleship".freeze, "Shuo Chen".freeze, "Chris Hunt".freeze, "James Gregory".freeze]
  s.date = "2018-10-03"
  s.description = "A gem to facilitate deployment across multiple git branches and evironments".freeze
  s.email = ["anthony.nettleship@epigenesys.org.uk".freeze, "shuo.chen@epigenesys.org.uk".freeze, "chris.hunt@epigenesys.org.uk".freeze, "james.gregory@epigenesys.org.uk".freeze]
  s.executables = ["ed".freeze, "epi_deploy".freeze]
  s.files = ["bin/ed".freeze, "bin/epi_deploy".freeze]
  s.homepage = "https://www.epigenesys.org.uk".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "eD".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<slop>.freeze, ["~> 3.6"])
      s.add_runtime_dependency(%q<git>.freeze, ["~> 1.5"])
    else
      s.add_dependency(%q<slop>.freeze, ["~> 3.6"])
      s.add_dependency(%q<git>.freeze, ["~> 1.5"])
    end
  else
    s.add_dependency(%q<slop>.freeze, ["~> 3.6"])
    s.add_dependency(%q<git>.freeze, ["~> 1.5"])
  end
end
