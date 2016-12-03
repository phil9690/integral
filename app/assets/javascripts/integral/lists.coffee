document.addEventListener "turbolinks:load", ->
  return unless $(".lists.show").length > 0
  new List()

  # $('.cancel-form').click ->
  #   # TODO: Think about this. Have to somehow reset the UI also
  #   $('form').resetForm()

