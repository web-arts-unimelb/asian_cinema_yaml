require 'rubygems'
require 'action_controller' # gem, then require stuff

# Class 
# http://zetcode.com/db/mysqlrubytutorial/
class My_table
	attr_accessor :host, :user, :pass, :db
	
	def initialize(host, user, pass, db)
		@host = host
		@user = user
		@pass = pass
		@db = db
	end

	def create
  	begin
    	con = Mysql.new @host, @user, @pass, @db 
		
			# ENGINE=InnoDB DEFAULT CHARSET=utf8?
			# AacflmDirection
			con.query("
      	CREATE TABLE IF NOT EXISTS \
      	AacflmDirection(
        	local_id INT PRIMARY KEY AUTO_INCREMENT, 
        	position VARCHAR(255),
        	film_id INT(11),
        	created_on DATETIME,
        	
        	page_id INT(11),
        	director_id INT(11),
        	id INT(11),
        	site_id INT(11)
      	) ENGINE=InnoDB DEFAULT CHARSET=utf8
    	")
		
			# AacflmDirector
			con.query("
        CREATE TABLE IF NOT EXISTS \
        AacflmDirector(
          local_id INT PRIMARY KEY AUTO_INCREMENT, 
         	slug VARCHAR(255),
					name VARCHAR(255),
					bio_markup TEXT, 
					
					created_on DATETIME,
					page_id INT(11),
					id INT(11),
					bio TEXT,
					
					site_id INT(11) 
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8
      ")

			# AacflmFilm
    	con.query("
        CREATE TABLE IF NOT EXISTS \
        AacflmFilm(
          local_id INT PRIMARY KEY AUTO_INCREMENT, 
         	slug VARCHAR(255),
					synopsis_markup TEXT,
					category VARCHAR(255),
					
					created_on DATETIME,
					title VARCHAR(255),
					notes TEXT,
					page_id VARCHAR(255),
					
					country_of_origin VARCHAR(255),
					id INT(11),
					year VARCHAR(255),
					notes_markup TEXT,
					
					synopsis TEXT,
					site_id INT(11)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8
      ")
    	
    	# AacflmProduction (i.e. relation of film and production company)
			con.query("
        CREATE TABLE IF NOT EXISTS \
        AacflmProduction(
          local_id INT PRIMARY KEY AUTO_INCREMENT, 
         	position INT(11),
         	film_id INT(11),
         	created_on DATETIME,
         	
         	page_id INT(11),
         	production_company_id INT(11),
         	id INT(11),
         	site_id INT(11)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8
      ")
		
			#AacflmProductionCompany	
			con.query("
        CREATE TABLE IF NOT EXISTS \
        AacflmProductionCompany(
        	local_id INT PRIMARY KEY AUTO_INCREMENT,
          description_markup TEXT,
					slug VARCHAR(255),
					name VARCHAR(255),
					
					created_on DATETIME,
					page_id INT(11),
					id INT(11),
					description TEXT,
					site_id INT(11)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8
      ")
		
			#Tag
			con.query("
        CREATE TABLE IF NOT EXISTS \
        Tag(
        	local_id INT PRIMARY KEY AUTO_INCREMENT,
          slug VARCHAR(255),
  				position INT(11),
  				phrase VARCHAR(255),
  				
  				id INT(11),
  				tag_phrase_id INT(11),
					taggable_id INT(11),
					taggable_type VARCHAR(255),
					site_id INT(11)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8
      ")
		
			#Category
			#It is not in the yml file, so I create my own
			con.query("
        CREATE TABLE IF NOT EXISTS \
        Category(
        	local_id INT PRIMARY KEY AUTO_INCREMENT,
          id INT(11),
          slug VARCHAR(255),
					name VARCHAR(255)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8
      ")
		
			# Truncate table
			con.query("TRUNCATE TABLE AacflmDirection")	
			con.query("TRUNCATE TABLE AacflmDirector")
			con.query("TRUNCATE TABLE AacflmFilm")
			con.query("TRUNCATE TABLE AacflmProduction")
			
			con.query("TRUNCATE TABLE AacflmProductionCompany")
			con.query("TRUNCATE TABLE Tag")
			con.query("TRUNCATE TABLE Category")

  	rescue Mysql::Error => e
    	puts e.errno
    	puts e.error

  	ensure
    	con.close if con
  	end
	end

	def remove_all_tables
		begin
      con = Mysql.new @host, @user, @pass, @db

		  stmt = con.prepare("DROP TABLE AacflmDirection")
		  stmt.execute()
		  
		  stmt = con.prepare("DROP TABLE AacflmDirector")
		  stmt.execute()
		  
		  stmt = con.prepare("DROP TABLE AacflmFilm")
		  stmt.execute()
		  
		  stmt = con.prepare("DROP TABLE AacflmProduction")
		  stmt.execute()

		rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      con.close if con
    end
	end


	def insert_AacflmDirection(position, film_id, created_on, page_id, director_id, id, site_id)		
		begin
      con = Mysql.new @host, @user, @pass, @db

		  stmt = con.prepare("
				INSERT INTO \
				AacflmDirection
				(
					position,
					film_id,
					created_on,
					page_id,

					director_id,
					id,
					site_id	
				)	
				VALUES
				(
					?,				
					?,
					?,
					?,

					?,
					?,
					?
				)
			")

		  stmt.execute(
				position,
		    film_id,
		    created_on,
		    page_id,

		    director_id,
		    id,
		    site_id	
			)

		rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      con.close if con
    end
	end # End insert_AacflmDirection

	
	def insert_AacflmDirector(slug, name, bio_markup, created_on, page_id, id, bio, site_id)	
		begin
      con = Mysql.new @host, @user, @pass, @db

		  stmt = con.prepare("
				INSERT INTO \
				AacflmDirector
				(
					slug,
					name,
					bio_markup,
					created_on,
					
					page_id,
					id,
					bio,
					site_id
				)	
				VALUES
				(
					?,				
					?,
					?,
					?,

					?,
					?,
					?,
					?
				)
			")

		  stmt.execute(
				slug,
				name,
				bio_markup,
				created_on,
				
				page_id,
				id,
				bio,
				site_id
			)

		rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      con.close if con
    end

	end # End insert_AacflmDirector
	
	
	def insert_AacflmFilm(slug, synopsis_markup, category, created_on, title, notes, page_id, country_of_origin, id, year, notes_markup, synopsis, site_id)
	
		# Title in all capital, so make it readable
		title = title.downcase
		title = title.split(' ').select {|w| w.capitalize! || w }.join(' ');
	
		begin
      con = Mysql.new @host, @user, @pass, @db

		  stmt = con.prepare("
				INSERT INTO \
				AacflmFilm
				(
					slug,
					synopsis_markup,
					category,
					created_on,
					
					title,
					notes,
					page_id,
					country_of_origin,
					
					id,
					year,
					notes_markup,
					synopsis,
					site_id
				)	
				VALUES
				(
					?,				
					?,
					?,
					?,

					?,
					?,
					?,
					?,
					
					?,
					?,
					?,
					?,
					?
				)
			")

			# Here we remove <p> </p> around the synopsis_markup
			# We assume the text is like <p>plain text ....</p>
			# Work around
			#synopsis_markup = synopsis_markup.gsub(%r{</?[^>]+?>}, '')

			## Synopsis markup
			#synopsis_markup = ActionController::Base.helpers.strip_tags(synopsis_markup)
			#if !synopsis_markup.empty? 
			#	synopsis_markup = '&lt;p&gt;' + synopsis_markup + '&lt;/p&gt;'
			#end

			## Note markup, similar as synopsis markup
			#notes_markup = ActionController::Base.helpers.strip_tags(notes_markup)
			#if !notes_markup.empty?
			#	notes_markup = '&lt;p&gt;' + notes_markup + '&lt;/p&gt;'
			#end

		  stmt.execute(
				slug,
				synopsis_markup,
				category,
				created_on,
				
				title,
				notes,
				page_id,
				country_of_origin,
				
				id,
				year,
				notes_markup,
				synopsis,
				site_id
			)

		rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      con.close if con
    end
	end # End insert_AacflmFilm
	
	
	def insert_AacflmProduction(position, film_id, created_on, page_id, production_company_id, id, site_id)
		begin
      con = Mysql.new @host, @user, @pass, @db

		  stmt = con.prepare("
				INSERT INTO \
				AacflmProduction
				(
					position,
					film_id,
					created_on,
					page_id,
		
					production_company_id,
					id,
					site_id
				)	
				VALUES
				(
					?,				
					?,
					?,
					?,

					?,
					?,
					?
				)
			")

		  stmt.execute(
				position,
				film_id,
				created_on,
				page_id,
	
				production_company_id,
				id,
				site_id	
			)

		rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      con.close if con
    end
	
	end # End insert_AacflmProduction
	
	
	# insert_AacflmProductionCompany
	def insert_AacflmProductionCompany(description_markup, slug, name, created_on, page_id, id, description, site_id)
		begin
      con = Mysql.new @host, @user, @pass, @db

		  stmt = con.prepare("
				INSERT INTO \
				AacflmProductionCompany
				(
					description_markup,
					slug,
					name,
					created_on,
					
					page_id,
					id,
					description,
					site_id
				)	
				VALUES
				(
					?,				
					?,
					?,
					?,

					?,
					?,
					?,
					?
				)
			")

		  stmt.execute(
				description_markup,
				slug,
				name,
				created_on,
				
				page_id,
				id,
				description,
				site_id	
			)

		rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      con.close if con
    end
	end # End insert_AacflmProductionCompany
	
	
	# insert_Tag
	def insert_Tag(slug, position, phrase, id, tag_phrase_id, taggable_id, taggable_type, site_id)
		begin
      con = Mysql.new @host, @user, @pass, @db

		  stmt = con.prepare("
				INSERT INTO \
				Tag
				(
					slug,
					position,
					phrase,
					id,
					
					tag_phrase_id,
					taggable_id,
					taggable_type,
					site_id
				)	
				VALUES
				(
					?,				
					?,
					?,
					?,

					?,
					?,
					?,
					?
				)
			")

		  stmt.execute(
				slug,
				position,
				phrase,
				id,
				
				tag_phrase_id,
				taggable_id,
				taggable_type,
				site_id	
			)

		rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      con.close if con
    end
	end # End insert_Tag
	
	
	def insert_category(id, slug, name)
		begin
      con = Mysql.new @host, @user, @pass, @db

		  stmt = con.prepare("
				INSERT INTO \
				Category
				(
          id,
          slug,
					name
				)	
				VALUES
				(
					?,				
					?,
					?
				)
			")

		  stmt.execute(
				id,
				slug,
				name
			)

		rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      con.close if con
    end
	end # End category
	
	
end # End class


