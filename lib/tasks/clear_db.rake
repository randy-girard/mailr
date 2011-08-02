namespace :db do
	desc "Clears all data in db"
    task :clear_data => :environment do
		users = User.all
      puts "Number of users in db: #{users.size}"
      puts "Deleting data....."
      User.destroy_all
      puts "Done"
	end
end
