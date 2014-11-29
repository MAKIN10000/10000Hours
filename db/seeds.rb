# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.create!({:session_token=> "test_token", :user_id => 'nick', :password => 'filmcrew', :password_confirmation => 'filmcrew', :email => 'nick@gmail.com'})
user = User.create!({:session_token=> "administrator_token", :user_id => 'root', :password => 'iseewhatyoudidthere', :password_confirmation => 'iseewhatyoudidthere', :email => 'root@tenthousandhours.com', :role => 'admin'})
