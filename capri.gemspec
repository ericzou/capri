require File.expand_path("lib/capri/version", File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name        = "capri"
  s.version     = Capri::VERSION
  s.authors     = ["Eric Zou"]
  s.email       = ["hello@ericzou.com"]
  s.homepage    = "http://caprirb.com"
  s.summary     = %q{Replace copywriting per domain}
  s.description = %q{Replace copywriting per domain}

  s.files         = `git ls-files --exclude-per-directory=.gitignore -- *`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'rack', ">= 1.3.0"
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
  s.add_development_dependency "haml", ">= 2.2.0"
  s.add_development_dependency "shotgun"
end
