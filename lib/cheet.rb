class Cheet 

  attr_reader :db_connect
  
  def initialize
    if ENV['RACK_ENV'] == 'test'
      @db_connect = PG.connect(dbname: 'chitter_test')
    else 
      @db_connect = PG.connect(dbname: 'chitter')
    end 
  end 


  def all 
    # returns array of posts f
    # currently returning hashs, we want strings 
    arr = []
    result = @db_connect.exec ( "SELECT * FROM cheets")
    result.each do |post| 
      p post
      arr << [post["posts"], post["date"], post["time"]]
    end
  # returns array of arrays
  p arr
  end 

  def create(post)
    # creates time stamp and saves post inside DataBase
    time_stamp = Time.now
    date = time_stamp.strftime("%d/%m/%Y")
    time = time_stamp.strftime("%k:%M")
    @db_connect.exec( "INSERT INTO cheets(posts, date, time) VALUES('#{post}', '#{date}', '#{time}');" ) 
  end 

end 