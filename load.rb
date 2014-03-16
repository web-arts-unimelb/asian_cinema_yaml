$LOAD_PATH.unshift( File.join( File.dirname(__FILE__), 'lib' ) )

require 'mysql'
require 'yaml'

require 'AacflmDirection'
require 'AacflmDirector'
require 'AacflmFilm'
require 'AacflmPage'

require 'AacflmProduction'
require 'AacflmProductionCompany'
require 'Asset'
require 'CttPage'

require 'CttRecipient'
require 'Draft'
require 'LnkLink'
require 'LnkPage'

require 'Page'
require 'Pathprint'
require 'Role'
require 'SchPage'

require 'Setting'
require 'Site'
require 'Tag'
require 'TagPhrase'
require 'User'

require 'My_table'
require 'trollop'


#
host = 'localhost'
user = 'root'
pass = '11111111'
db = 'asian_cinema'

my_table = My_table.new host, user, pass, db 
my_table.create


# Receive options
# Use as --remove-all-tables
# sample output if true: {:remove_all_tables=>true, :help=>false, :remove_all_tables_given=>true}
# sample output if false: {:remove_all_tables=>false, :help=>false}
opts = Trollop::options do
  opt :remove_all_tables, "Remove all tables", :type => :boolean, :default => false
end

if opts[:remove_all_tables]
	my_table.remove_all_tables
end


# Fill tables with data
SITE_PATH = '/var/www/test/testme/asian_cinema/site.yml'
site_path = File.open(SITE_PATH)
YAML::load_stream(site_path) { |doc|
	if doc.class.to_s == 'AacflmDirection'
		
		position =  doc.attributes['position']
		film_id = doc.attributes['film_id']
		created_on = doc.attributes['created_on']
		page_id = doc.attributes['page_id']
		
		director_id = doc.attributes['director_id']
		id = doc.attributes['id']
		site_id = doc.attributes['site_id']
		
		my_table.insert_AacflmDirection position, film_id, created_on, page_id, director_id, id, site_id
		
	elsif doc.class.to_s == 'AacflmDirector'
		
		slug = doc.attributes['slug']
  	name = doc.attributes['name']
  	bio_markup = doc.attributes['bio_markup']
  	created_on = doc.attributes['created_on']
  	
		page_id = doc.attributes['page_id']
  	id = doc.attributes['id']
  	bio = doc.attributes['bio']
  	site_id = doc.attributes['site_id']

		my_table.insert_AacflmDirector slug, name, bio_markup, created_on, page_id, id, bio, site_id
	
	elsif doc.class.to_s == 'AacflmFilm'
		
		slug = doc.attributes['slug']
		synopsis_markup = doc.attributes['synopsis_markup']
		category = doc.attributes['category']
		created_on = doc.attributes['created_on']
		
		title = doc.attributes['title']
		notes = doc.attributes['notes']
		page_id = doc.attributes['page_id']
		country_of_origin = doc.attributes['country_of_origin']		
		
		id = doc.attributes['id']
		year = doc.attributes['year']
		notes_markup = doc.attributes['notes_markup']
		synopsis = doc.attributes['synopsis']
		site_id = doc.attributes['site_id']
		
		my_table.insert_AacflmFilm slug, synopsis_markup, category, created_on, title, notes, page_id, country_of_origin, id, year, notes_markup, synopsis, site_id
			
	elsif doc.class.to_s == 'AacflmProduction'		
			
		position = doc.attributes['position']
		film_id = doc.attributes['film_id']
		created_on = doc.attributes['created_on']
		page_id = doc.attributes['page_id']
		
		production_company_id = doc.attributes['production_company_id']
		id = doc.attributes['id']
		site_id = doc.attributes['site_id']	
			
		my_table.insert_AacflmProduction position, film_id, created_on, page_id, production_company_id, id, site_id
		
	elsif doc.class.to_s == 'AacflmProductionCompany' 		
		
		description_markup = doc.attributes['description_markup']
		slug = doc.attributes['slug']
		name = doc.attributes['name']
		created_on = doc.attributes['created_on']
		
		page_id = doc.attributes['page_id']
		id = doc.attributes['id']
		description = doc.attributes['description']
		site_id = doc.attributes['site_id']
			
		my_table.insert_AacflmProductionCompany description_markup, slug, name, created_on, page_id, id, description, site_id 
	else
		puts 'last'
	end
		 
}

