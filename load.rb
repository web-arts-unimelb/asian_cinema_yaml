$LOAD_PATH.unshift( File.join( File.dirname(__FILE__), 'lib' ) )

require 'mysql'
require 'yaml'
require 'AacflmDirection'
require 'AacflmDirector' 
require 'My_table'

#
my_table = My_table.new
my_table.create


SITE_PATH = '/var/www/test/testme/asian_cinema/tmp_orig.yml'
site_path = File.open( SITE_PATH )
YAML::load_stream(site_path) { |doc|
	if doc.class.to_s == 'AacflmDirection'
		puts doc.attributes['position']
	elsif doc.class.to_s == 'AacflmDirector'
		puts doc.attributes['slug']	
	else
		puts 'last'
	end
		 
}

