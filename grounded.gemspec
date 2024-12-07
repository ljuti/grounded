# frozen_string_literal: true

require_relative "lib/grounded/version"

Gem::Specification.new do |spec|
  spec.name = "grounded"
  spec.version = Grounded.gem_version
  spec.authors = ["Lauri Jutila"]
  spec.email = ["git@laurijutila.com"]

  spec.summary = "Rails Event Store infrastructure."
  spec.description = "Rails Event Store infrastructure."
  spec.homepage = "https://github.com/ljuti/grounded"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ljuti/grounded"
  spec.metadata["changelog_uri"] = "https://github.com/ljuti/grounded/blob/main/CHANGELOG.md"

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

  spec.add_dependency "activesupport"
  spec.add_dependency "activejob"
  spec.add_dependency "aggregate_root"
  spec.add_dependency "arkency-command_bus"
  spec.add_dependency "dry-struct"
  spec.add_dependency "dry-types"
  spec.add_dependency "ruby_event_store"
  spec.add_dependency "ulid-ruby"
end
