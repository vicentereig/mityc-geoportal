# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mityc-geoportal/version"

Gem::Specification.new do |s|
  s.name        = "mityc-geoportal"
  s.version     = Mityc::Geoportal::VERSION
  s.authors     = ["Vicente Reig Rincón de Arellano"]
  s.email       = ["vicente.reig@gmail.com"]
  s.homepage    = "http://github.com/vicentereig/mityc-geoportal"
  s.summary     = %q{Powers http://ahorraralrepostar.com/ fuel price update process from http://geoportal.mityc.es/}
  s.description = %q{Simple wrapper to the fuel prices published by the Spanish Government through http://geoportal.mityc.es/ which powers http://ahorraralrepostar.com}

  s.rubyforge_project = "mityc-geoportal"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "debugger"
  s.add_development_dependency "magic_encoding"

  s.add_runtime_dependency "activemodel"
  s.add_runtime_dependency "unhappymapper"
  s.add_runtime_dependency "typhoeus"
end
