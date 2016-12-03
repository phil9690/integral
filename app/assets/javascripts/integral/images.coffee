document.addEventListener "turbolinks:load", ->
  return unless $(".images.index").length > 0
  ContactCreationModal.init()

