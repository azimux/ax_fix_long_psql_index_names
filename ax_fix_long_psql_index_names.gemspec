$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ax_fix_long_psql_index_names/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ax_fix_long_psql_index_names"
  s.version     = AxFixLongPsqlIndexNames::VERSION
  s.authors     = ['azimux']
  s.email       = ['azimux@gmail.com']
  s.homepage    = 'http://github.com/azimux/ax_fix_long_psql_index_names'
  s.summary     = 'Engine for fixing ridiculously long index names that break pgsql'
  s.description = 'Engine for fixing ridiculously long index names that break pgsql'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT_LICENSE.txt"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"

  s.add_development_dependency "sqlite3"
end
