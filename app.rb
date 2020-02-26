#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
    erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/about' do
    @error = "somephing wrong!"    # Пример вывода ошибки
    erb :about
end

get '/visit' do
    erb :visit
end

post '/visit' do

    @user_name = params[:user_name]
    @phone     = params[:phone]
    @date_time = params[:date_time]
    @barber    = params[:barber]
    @color     = params[:colorpicker]

    hh = {  :user_name => 'Введите имя ',
                :phone => 'Введите номер телефона ',
            :date_time => 'Введите дату и время ' }

    # Для каждой пары ключ-значение
    hh.each do |key, value|
        # если параметр пуст
        if params[key] == ''
            # переменной error присвоить союе value из хеша hh
            # т.е переменной error присвоить сообщение об ошибке
            @error = hh[key]
            return erb :visit
        end
    end

#    @error = hh.select {|key,_| params[key] == ""}.values.join(",")
#    return erb :visit if @error != ''
    
    @title = 'Спасибо!'
    @message = "Спасибо вам, #{@user_name}, будем ждать Вас."

    out_f = File.open './public/users.txt', 'a'
    out_f.write "User: #{@user_name}, Phone: #{@phone},"
    out_f.write " Date_Time: #{@date_time} Barber: #{@barber}\n"
    out_f.close

    erb :message
end

get '/contacts' do
    erb :contacts
end

=begin
post '/contacts' do
    @user_name      = params[:user_name]
    @user_mail      = params[:user_mail]
    @message_user   = params[:message_user]

    hh = {  :user_name => 'Вы не указали имя ',
            :user_mail => 'Вы не указали адрес для ответа ',
            :message_user => 'Текст Вашего сообщения не найден ' }

    # Для каждой пары ключ-значение
    hh.each do |key, value|
        # если параметр пуст
        if params[key] == ''
            # переменной error присвоить союе value из хеша hh
            # т.е переменной error присвоить сообщение об ошибке
            @error = hh[key]
            return erb :contacts
        end
    end
    
    @title = 'Ваше обращение доставлено!'
    @message = "Спасибо за обращение. Если оно требует ответа, мы постараемся связаться с Вами в бижайшее время."

    out_f = File.open './public/contacts.txt', 'a'
    out_f.write "\n\nUser: #{@user_name}, Call: #{@user_mail},\n"
    out_f.write "Message: #{@message_user}\n"
    out_f.close

    erb :message
end
=end

post '/contacts' do 
require 'pony'
Pony.mail(
    :name => params[:user_name],
    :mail => params[:user_mail],
    :body => params[:message_user],
    :to => 'opr.a.ruby@gmail.com',
    :subject => params[:name] + " has contacted you",
    :body => params[:message],
    :port => '587',
    :via => :smtp,
    :via_options => { 
        :address              => 'smtp.gmail.com', 
        :port                 => '587', 
        :enable_starttls_auto => true, 
        :user_name            => 'opr.a.ruby', 
        :password             => 'p@55w0rd', 
        :authentication       => :plain, 
        :domain               => 'localhost.localdomain'
    })
    redirect '/success' 
end
