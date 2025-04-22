# frozen_string_literal: true

require_relative 'lib/dino_management/version'

Gem::Specification.new do |spec|
  spec.name = 'dino_management'
  spec.version = DinoManagement::VERSION
  spec.authors = ['Jose C Fernandez']
  spec.email = ['josefernandez@joseworks.org']

  spec.summary = 'A Ruby gem for managing dinosaur data and operations'
  spec.description = 'This gem provides functionalities to manage and manipulate dinosaur-related data, including information retrieval and data processing.'

  spec.homepage = 'https://github.com/Joseworks/dino_management'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.3.7'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'  # Allow pushing to RubyGems.org

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'rubocop', '~> 1.73'
  spec.add_development_dependency 'rubocop-rake', '~> 0.7'
  spec.add_development_dependency 'rubocop-rspec', '~> 3.5'
  spec.add_development_dependency 'simplecov'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
