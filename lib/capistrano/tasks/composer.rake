namespace :composer do

  task :installer, :options do |t, args|
    on release_roles(fetch(:composer_roles)) do
      within fetch(:composer_path) do
        php_ini = fetch(:composer_php_ini) || ''
        if php_ini.length > 0
          php_ini = ' -c ' + php_ini
        end
        unless test "[", "-e", "composer.phar", "]"
          execute :curl, "-s", fetch(:composer_download_url), "|", fetch(:composer_php), php_ini, args[:options]
        end
      end
    end
    Rake::Task[t.name].reenable
  end

  task :run, :command, :options do |t, args|
    on release_roles(fetch(:composer_roles)) do
      within fetch(:composer_working_path) do
        php_ini = fetch(:composer_php_ini) || ''
        if php_ini.length > 0
          php_ini = ' -c ' + php_ini
        end
        execute fetch(:composer_php), php_ini, fetch(:composer_execute), args[:command], args[:options]
      end
    end
    Rake::Task[t.name].reenable
  end

  task :install, :options do |t, args|
    invoke "composer:run", :install, args[:options]
    Rake::Task[t.name].reenable
  end

  task :update, :options do |t, args|
    invoke "composer:run", :update, args[:options]
    Rake::Task[t.name].reenable
  end

  task :self_update, :options do |t, args|
    invoke "composer:run", :selfupdate, args[:options]
    Rake::Task[t.name].reenable
  end
end