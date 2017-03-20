document.addEventListener "turbolinks:load", ->
  return if $(".posts.new").length == 0 && $(".posts.edit").length == 0

  # Prompts users of dirty forms before allowing them to navigate away from the page
  $('form').areYouSure()

