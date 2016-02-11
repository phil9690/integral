// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require materialize-sprockets
//= require turbolinks
//= require rails.validations
//= require rails.validations.simple_form
//= require wice_grid
//= require_tree .

Turbolinks.enableProgressBar();

$(document).on('ready page:load', function () {
  Waves.displayEffect();
  Materialize.updateTextFields();
  $('select').material_select();
  $(".button-collapse").sideNav();
  $(".parallax").parallax();
  $(".dropdown-button").dropdown();
  $('body').addClass('loaded');
  $('.collapsible').collapsible({
    accordion : false
  });
});

$(document).on('page:load', function () {
  $('input, textarea').characterCounter();
  $('ul.tabs').tabs();
});

