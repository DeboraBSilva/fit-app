desc "Update field confirmed_at for all users in database"

task :confirm_all_users => [:environment] do
  User.update_all confirmed_at: DateTime.now
end
