# frozen_string_literal: true

require 'open-uri'

p 'Creating default user...'
user = User.create(
  name: 'User',
  email: 'user@user.com',
  password: 'user@123',
  username: 'user'
)

p 'Creating folders from txt file...'
open('db/folders.txt') do |folders|
  folders.read.each_line do |data|
    name, description = data.chomp.split('|')
    Folder.create(name: name, description: description, user: user)
  end
end
