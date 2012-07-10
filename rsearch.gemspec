# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rsearch/version"

Gem::Specification.new do |s|
  s.name        = "rsearch"
  s.version     = Rsearch::VERSION
  s.authors     = ["Vincent Paca"]
  s.email       = ["vincent.paca@gmail.com"]
  s.homepage    = "http://github.com/vincentpaca/rsearch"
  s.summary     = %q{Web search using Ruby}
  s.description = %q{Search the web with the most popular search engines}

  s.rubyforge_project = "rsearch"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"

  s.add_runtime_dependency "json"
end
