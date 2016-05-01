$KCODE = 'u'
$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'test/unit'
require 'fileutils'
presumed_rails_dir = File.expand_path(File.dirname(__FILE__)+'/../../../rails')

if File.directory?(presumed_rails_dir) && !ENV['ASEARCH_USE_GEM']
  $:.unshift(presumed_rails_dir)
  puts "Using Edge Rails from #{presumed_rails_dir}"
  puts "Define ASEARCH_USE_GEM to use gem rails"
  require 'activesupport/lib/active_support'
  require 'activerecord/lib/active_record'
  require 'activerecord/lib/active_record/fixtures'
else
  puts "Using Rails from gems"
  require 'rubygems'
  require 'active_support'
  require 'active_record'
  require 'active_record/fixtures'
end

tempdir = File.join(File.dirname(__FILE__), 'tmp')
Dir.mkdir(tempdir) unless File.directory?(tempdir)
RAILS_ROOT = File.dirname(tempdir)

require File.dirname(__FILE__)  + "/../init"

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
FileUtils.rm_rf(File.dirname(__FILE__) + "/debug.log")

db_adapter = ENV['ASEARCH_DB_DRIVER'] ? ENV['ASEARCH_DB_DRIVER'] : 'sqlite3'
puts "Testing with database driver #{db_adapter}"
puts "Define ASEARCH_DB_DRIVER in your environment to test with another database" unless ENV['ASEARCH_DB_DRIVER'] 

driver = config[db_adapter]
ActiveRecord::Base.establish_connection(driver)
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
require File.dirname(__FILE__) + "/schema"
require File.dirname(__FILE__) + "/002_add_join"

SetupTables.migrate(:up)

Test::Unit::TestCase.fixture_path = File.dirname(__FILE__) + "/fixtures"
$: << Test::Unit::TestCase.fixture_path 

ALL_FIXTURES = Dir.entries(Test::Unit::TestCase.fixture_path).grep(/\.yml$/i).map{|e| e.gsub(/\.yml$/i, '')}.map(&:to_s)

class Test::Unit::TestCase #:nodoc:
  
  self.use_transactional_fixtures, self.use_instantiated_fixtures = true, false
  
  def create_fixtures(*table_names)
    raise "Loading #{table_names.inspect}"
    if block_given?
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names) { yield }
    else
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names)
    end
  end
  
  def read_fixture_file(f)
    File.readlines(Dir.glob(Test::Unit::TestCase.fixture_path + "/#{f}.*")[0]).join
  end
end