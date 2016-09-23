$(document).on "ready page:load", ->
  $(".menus.show").ready ->
    # Create Menu Item objects
    $('.menu-item-container').each (i, itemContainer) =>
      new MenuItem(itemContainer)

    # Handle new MenuItem Insertion
    $('#menu-items')
      .on 'cocoon:after-insert', (e, added_item) ->
        # Connect modal and link to modal
        modal = added_item.find('.modal')
        modalTrigger = added_item.find('.modal-trigger')
        modal.attr("id","menu-item-modal-#{$.now()}")
        modalTrigger.attr("href","#menu-item-modal-#{$.now()}")

        # Initialize new MenuItem
        new MenuItem(added_item)

        # Initialize & open modal
        modalTrigger.leanModal()
        modal.openModal
          dismissible: false,
          ready: ->
            modal.find('input').enableClientSideValidations()

      # .on 'cocoon:before-remove', (e, removed_item) ->
      #   console.log 'Removed.'

    # $('.cancel-form').click ->
    #   # TODO: Think about this. Have to somehow reset the UI also
    #   $('form').resetForm()


