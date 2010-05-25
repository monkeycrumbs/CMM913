desc "Add default test data to the database"
task :default_data => :environment do
  ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)

  user = User.new :login => 'Admin', :password => 'changeme', :password_confirmation => 'changeme', :email => 'test@example.com'
  user.admin = 1
  user.save
end