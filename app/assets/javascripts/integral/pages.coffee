document.addEventListener "turbolinks:load", ->
  return if $(".pages.new").length == 0 && $(".pages.edit").length == 0

  # Prompts users of dirty forms before allowing them to navigate away from the page
  $('form').areYouSure()

