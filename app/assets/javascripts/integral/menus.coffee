$(document).on "ready page:load", ->
  $(".menus.show").ready ->
    new Menu()

    # $('.cancel-form').click ->
    #   # TODO: Think about this. Have to somehow reset the UI also
    #   $('form').resetForm()

