document.addEventListener "turbolinks:load", ->
  $(".lists.show").ready ->
    new List()

    # $('.cancel-form').click ->
    #   # TODO: Think about this. Have to somehow reset the UI also
    #   $('form').resetForm()

