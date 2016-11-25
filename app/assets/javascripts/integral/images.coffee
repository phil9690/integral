document.addEventListener "turbolinks:load", ->
  $(".images.index").ready ->
    ContactCreationModal.init()

