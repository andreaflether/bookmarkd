require 'open-uri'

p 'Creating default user...'
user = User.create(
  name: Faker::Name.name, 
  email: Faker::Internet.email, 
  password: Faker::Internet.password(min_length: 6)
)

p 'Creating folders from txt file...'
open('db/folders.txt') do |folders|
  folders.read.each_line do |data|
    name, description = data.chomp.split('|')
    Folder.create(name: name, description: description, user: user)
  end
end
