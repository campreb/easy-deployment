# To load this capistrano configuration, require 'easy/deployment/whenever' from deploy.rb
Capistrano::Configuration.instance(:must_exist).load do
  namespace :easy do
    namespace :whenever do
      desc "Removes this application's entries from the user's crontab file"
      task :clear_crontab do
        puts "Deprecated - use whenever/capistrano instead"
        run "cd #{release_path} && bundle exec whenever -f #{release_path}/config/deploy/#{rails_env}/whenever.rb --clear-crontab #{application}"
      end

      desc "Updates this application's crontab file entries"
      task :update_crontab do
        puts "Deprecated - use whenever/capistrano instead"
        run "cd #{current_path} && bundle exec whenever -f #{current_path}/config/deploy/#{rails_env}/whenever.rb --update-crontab #{application} --set \"current_path=#{current_path}&bundle_cmd=#{fetch(:bundle_cmd, 'bundle')}&rails_env=#{rails_env}&application=#{application}\""
      end
    end
  end

  after "deploy:update_code", "easy:whenever:clear_crontab"
  after "deploy:create_symlink", "easy:whenever:update_crontab"
  after "deploy:rollback", "easy:whenever:update_crontab"
end
