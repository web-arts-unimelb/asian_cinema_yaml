# Class 
# http://zetcode.com/db/mysqlrubytutorial/
class My_table
	def initialize

	end

	def create
  	begin
    	con = Mysql.new 'localhost', 'root', '11111111', 'asian_cinema'

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
end
