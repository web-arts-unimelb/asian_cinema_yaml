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
		
			con.query("
        CREATE TABLE IF NOT EXISTS \
        AacflmDirector(
          local_id INT PRIMARY KEY AUTO_INCREMENT, 
         	slug VARCHAR(255),
					name VARCHAR(255),
					bio_markup TEXT, 
					created_on DATE,
					page_id INT(11),
					id INT(11),
					bio INT(11),
					site_id INT(11) 
        )
      ")

    	con.query("
      	CREATE TABLE IF NOT EXISTS \
      	AacflmDirection(
        	local_id INT PRIMARY KEY AUTO_INCREMENT, 
        	position VARCHAR(255),
        	film_id INT(11),
        	created_on DATE,
        	page_id INT(11),
        	director_id INT(11),
        	id INT(11),
        	site_id INT(11)
      	)
    	")

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

	end


end


