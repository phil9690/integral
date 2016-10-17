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
//= require parsley
//= require wice_grid
//= require cocoon
//= require ckeditor/loader
//= require i18n/translations
//= require integral/extensions
//= require_tree .

Turbolinks.enableProgressBar();

$(document).on('ready page:load', function () {
  Waves.displayEffect();
  Materialize.updateTextFields();
  $('select').material_select();
  $(".button-collapse").sideNav();
  $(".dropdown-button").dropdown();
  $('body').addClass('loaded');
  $('.collapsible').collapsible({
    accordion : false
  });

  SlugGenerator.check_for_slugs();
  RecordSelector.init();

  var filterSuggestions = function(suggestableInput, suggestions) {
    existingItems = suggestableInput.val().split(',')

    return suggestions.filter( function( el ) {
      return existingItems.indexOf( el ) < 0;
    });
  };

  $("input[data-role=materialtags]").each(function( index ) {
    suggestableInput = $(this)
    typeaheadSuggestions = suggestableInput.data('typeahead').split(' ')

    // Initialize suggest engine
    suggestEngine = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: typeaheadSuggestions
    });

    // Initialize materialtags
    suggestableInput.materialtags({
      typeaheadjs: {
        source: function(query, cb) {
          suggestEngine.search(query, function(suggestions) {
            cb(filterSuggestions(suggestableInput, suggestions));
          });
        }
      }
    });
  });

  // Set the local for clientside validations
  I18n.locale = $('body').data('locale') || 'en'
});

$(document).on('page:load', function () {
  $('input, textarea').characterCounter();
  $('.tooltipped').tooltip({delay: 50});
  $('ul.tabs').tabs();
});

