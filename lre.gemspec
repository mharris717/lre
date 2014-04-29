# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: lre 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "lre"
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["mharris717"]
  s.date = "2014-04-29"
  s.description = "lre"
  s.email = "mharris717@gmail.com"
  s.executables = ["lre"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/lre",
    "lib/lre.rb",
    "lib/lre/file_reload.rb",
    "lib/lre/rake_ext.rb",
    "lib/lre/watchr_ext.rb",
    "lre.gemspec",
    "spec/lre_spec.rb",
    "spec/spec_helper.rb",
    "spec/test_dir/.lre",
    "spec/test_dir/bar.rb",
    "spec/test_dir/file.rb",
    "spec/test_dir/foo.rb"
  ]
  s.homepage = "http://github.com/mharris717/lre"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "lre"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fattr>, [">= 0"])
      s.add_runtime_dependency(%q<watchr>, [">= 0"])
      s.add_runtime_dependency(%q<mharris_ext>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, [">= 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.7"])
      s.add_development_dependency(%q<github-markup>, [">= 0"])
      s.add_development_dependency(%q<rdiscount>, [">= 0"])
    else
      s.add_dependency(%q<fattr>, [">= 0"])
      s.add_dependency(%q<watchr>, [">= 0"])
      s.add_dependency(%q<mharris_ext>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, [">= 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
      s.add_dependency(%q<github-markup>, [">= 0"])
      s.add_dependency(%q<rdiscount>, [">= 0"])
    end
  else
    s.add_dependency(%q<fattr>, [">= 0"])
    s.add_dependency(%q<watchr>, [">= 0"])
    s.add_dependency(%q<mharris_ext>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, [">= 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
    s.add_dependency(%q<github-markup>, [">= 0"])
    s.add_dependency(%q<rdiscount>, [">= 0"])
  end
end

