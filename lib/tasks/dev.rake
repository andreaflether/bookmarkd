# frozen_string_literal: true

namespace :dev do
  desc 'TODO'
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Dropping DB...') { `rails db:drop:_unsafe` }
      show_spinner('Creating DB...') { `rails db:create` }
      show_spinner('Migrating DB...') { `rails db:migrate` }
      show_spinner('Seeding DB...') { `rails db:seed` }
    else
      puts "You're not running on development environment!"
    end
  end

  private

  def show_spinner(msg_start, msg_end = 'Finished!')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success(msg_end)
  end
end
