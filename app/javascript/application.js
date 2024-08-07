// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// app/javascript/packs/application.js
import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import 'bootstrap';

Rails.start();
Turbolinks.start();
