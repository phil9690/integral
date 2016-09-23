$(document).on "ready page:load", ->
  $(".menus.show").ready ->
    sortable '.sortable',
      items: '.menu-item-container'

    # Calculate & set menu item priorities
    sortable('.sortable')[0].addEventListener 'sortupdate', =>
      # TODO: Convert this into a method as it's used in 3 different places
      $('.menu-item-container').each (priority, itemContainer) =>
        $(itemContainer).find('.priority-field').val(priority)

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

        # Reinitalize Sortable
        sortable '.sortable',
          items: '.menu-item-container'

        $('.menu-item-container').each (priority, itemContainer) =>
          $(itemContainer).find('.priority-field').val(priority)

        # Initialize & open modal
        modalTrigger.leanModal()
        modal.openModal
          dismissible: false,
          ready: ->
            modal.find('input').enableClientSideValidations()

      .on 'cocoon:before-remove', (e, removed_item) ->
        $('.menu-item-container').each (priority, itemContainer) =>
          $(itemContainer).find('.priority-field').val(priority)

    # $('.cancel-form').click ->
    #   # TODO: Think about this. Have to somehow reset the UI also
    #   $('form').resetForm()


