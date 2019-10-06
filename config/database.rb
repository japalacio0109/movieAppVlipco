# DB_ENGINE: Choice a Sequel compatible engine (sqlite, postgres, mysql2)
DB_ENGINE = "sqlite"
DB_NAME = "mydb.db"
DB_NEED_USER_PARAMS = false
DB_HOST = nil
DB_USER = nil
DB_PASS = nil

STR_BASE = "#{DB_ENGINE}://#{DB_HOST}#{DB_NAME}"
DB_STR_CONNECT = DB_NEED_USER_PARAMS ? ("#{STR_BASE}?user=#{DB_USER}&pasword=#{DB_PASS}") : STR_BASE

puts 'Applying migrations...'
migration_command = "sequel -m db/migrations #{DB_STR_CONNECT}" 
system(migration_command)
puts 'Applying migrations...(Success)'

puts 'Database configuration...'
DB = Sequel.connect(DB_STR_CONNECT)
Sequel::Model.db = DB
Sequel::Model.plugin :json_serializer
Sequel::Model.db.extension(:pagination)
puts 'Database configuration... (Success)'
