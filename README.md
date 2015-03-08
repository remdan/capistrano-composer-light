# Capistrano::Composer

Provide some Composer task for to use them in your Capistrano project.
For more flexibility it comes just whit tasks and it's nothing doing automatically on the Capistrano [flow][1].
If you need something from the Composer, so hook into the Capistrano [flow][1] by your self. 

## Installation

```
# Gemfile
gem 'capistrano',  '~> 3.1'
gem 'capistrano-composer-light', '~> 0.0.1'
```

## Usage

Require capistrano-composer-light in your cap file

```
# Capfile
require 'capistrano/composer'
```

### Settings

The following settings (displayed with defaults) are provided:

```ruby
# If you have a other name for your php, maybe like "php54 or php55" change it.
set :composer_php,                      "php"

# If you use a diffrent php.ini change it and set the path.
set :composer_php_ini,                  ""

# If you want to install the composer.phar.
set :composer_download_url,              "https://getcomposer.org/installer"
set :composer_path,             ->      { shared_path }

# The path to "../composer.phar" or maybe just "composer" for to call all the tasks.
set :composer_execute,          ->      { fetch(:composer_path).join('composer.phar') }

# Set the path in that is run all the tasks.
set :composer_working_path,     ->      { fetch(:release_path) }

# Set the roles for all tasks.
set :composer_roles,                    :all
```

### Integrated common tasks

The folowing common tasks are already integrated:
* ```composer:installer```
* ```composer:self_update```
* ```composer:install```
* ```composer:update```
* ```composer:run```

So you can use them with hooks like this:
```ruby
  after 'deploy:updated',   'composer:install'
  after 'deploy:updated',   'composer:update'
```

Or if you need to pass some options:
```ruby
after :deploy, :updated do
  invoke "composer:installer", "-- --version=1.0.0-alpha9"
  invoke "composer:install", "--optimize-autoloader"
end
```

If you need a not already provided task you can use "composer:run"  
```ruby
after :deploy, :updated do
  invoke "composer:run", "remove", "--dev"
end
```

[1]: http://capistranorb.com/documentation/getting-started/flow/

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request