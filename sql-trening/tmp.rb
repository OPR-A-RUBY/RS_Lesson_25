require 'sqlite3'
db = SQLite3::Database.new 'BarberShop.db'

# db.execute "INSERT INTO db_t_contacts (user_name, user_mail, message_user) VALUES ('Betty', 'betty@mail.ru', 'i am Betty!')"

@user_name = 'Tri-ter'
@user_mail = 'tt@mail.tt'
@message_user = 'qwerty asdfgh zxcvbn'

db.execute "INSERT INTO db_t_contacts (user_name, user_mail, message_user) VALUES ('#{@user_name}', '#{@user_mail}', '#{@message_user}')"
 
db.execute "SELECT * FROM db_t_contacts" do |item|
    puts item
    puts "======"
end

db.close
