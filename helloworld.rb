require 'bundler'
require 'sinatra'
require "sqlite3"




  
# @db = SQLite3::Database.new(datenbankFile)
# @db.execute("CREATE TABLE importiert ( belegnummer STRING (11), belegtyp CHAR (1));")
# hash = @db.get_first_value("select hash from bilderUploadListe where dateiname = ?", dateiname)
# Open a database
databaseFile = "test.db"
$db = SQLite3::Database.new databaseFile

if not File.exists?(databaseFile)
    $db.execute <<-SQL
        create table students (
            name varchar(50),
            email varchar(50),
            grade varchar(5),
            blog varchar(50)
        );
    SQL
  end 

get '/hello/:name' do
    "<h1>Hello #{params['name']}!</h1>"
end
  
get '/students' do
    results = []
    $db.execute( "select * from students" ) do |row|
       results.push(row)
    end

    results.join("\n")
end

get '/students/new' do
    File.read 'studentsform.html'
end

post '/students/new' do
    name = params[:name]
    email = params[:email]
    grade = params[:grade]
    blog = params[:blog]
    $db.execute( "insert into students (name, email, grade, blog) values (?, ?, ?, ?)" , name, email, grade, blog )
end


