# If you have a other name for your php, maybe like "php54 or php55" change it.
set :composer_php,                      "php"

# If you use a diffrent php.ini change it and set the path absolute to your root like "/etc/php55/php.ini".
set :composer_php_ini,                  ""

# Set the roles for all tasks.
set :composer_roles,                    :all

# Set the path in that is run all the tasks.
set :composer_working_path,     ->      { fetch(:release_path) }

# If you want to install the composer.phar.
set :composer_download_url,              "https://getcomposer.org/installer"
set :composer_path,             ->      { fetch(:shared_path) }

# The path to "../composer.phar" or maybe just "composer" for to call all the tasks.
set :composer_execute,                  "#{fetch(:composer_path)}/composer.phar"