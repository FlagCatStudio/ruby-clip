# frozen_string_literal: true

require_relative "lib/clip/version"

Gem::Specification.new do |spec|
  spec.name = "ruby-clip"
  spec.version = Clip::VERSION
  spec.authors = ["Julien 'Lta' BALLET"]
  spec.email = ["lta@flagcat.studio"]

  spec.summary = "A minimal parser for Clip Studio Paint files"
  spec.homepage = "https://github.com/FlagCatStudio/ruby-clip"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  spec.metadata["Copyrights"] = "Flagcat SAS"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sqlite3", "~> 2"
end
