Gem::Specification.new do |s|
  s.name        = "gem-wizard"
  s.version     = "0.2.1"
  s.summary     = "Install and setup essential gems for a rails application."
  s.description = "Install and setup essential gems for a rails application."
  s.authors     = ["John Paul"]
  s.email       = "john@rockfort.city"
  s.files       = ["lib/gem_wizard.rb", "lib/gems.json"]
  s.add_development_dependency "pry",
    [">= 0.13.1"]
  # s.homepage    =
  #   "https://rubygems.org/gems/gemify"
  s.license       = "MIT"
  s.executables = ['gem-wizard-start']
end