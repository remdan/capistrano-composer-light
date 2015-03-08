require "capistrano/composer/composer"

namespace :load do
  task :defaults do
    load "capistrano/composer/defaults.rb"
  end
end