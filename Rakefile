# -*- ruby -*-

require 'rubygems'
require 'hoe'

LIB_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))

$LOAD_PATH << LIB_DIR

require 'nokogiri/version'

HOE = Hoe.new('nokogiri', Nokogiri::VERSION) do |p|
  p.developer('Aaron Patterson', 'aaronp@rubyforge.org')
end

namespace :gem do
  task :spec do
    File.open("#{HOE.name}.gemspec", 'w') do |f|
      HOE.spec.version = "#{HOE.version}.#{Time.now.strftime("%Y%m%d%H%M%S")}"
      f.write(HOE.spec.to_ruby)
    end
  end
end

desc "Run code-coverage analysis"
task :coverage do
  rm_rf "coverage"
  sh "rcov -x Library -I lib:test #{Dir[*HOE.test_globs].join(' ')}"
end
# vim: syntax=Ruby
