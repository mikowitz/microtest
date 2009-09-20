require File.dirname(__FILE__) + '/../lib/microtest'

test_files = Dir.glob('test/test_*.rb') - [__FILE__.gsub(/\.\//, '')]

test_files.each do |file|
  require file
end

Microtest::Runner.run_tests
