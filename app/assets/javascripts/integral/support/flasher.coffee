$(document).on "ready page:load", ->
  # Could move this into its own class.. something like FlashPresenter.display
  flashList = $('#flash_list .flash')

  for flash in flashList
    flash = $(flash)
    message = flash.data 'message'
    klass = flash.data 'klass'
    # console.log "FLASH! Type: #{klass}. Message: #{message}"
    Materialize.toast(message, 4000, klass)

