class this.List
  # List constructor
  constructor: (container) ->
    @listItemContainer = $('.list-item-container')
    @_createListItems()
    @_initializeSortable()
    @_setupEvents()

    @_setupForm()

  _setupEvents: ->
    # Attempt to handle dynamic placeholder lengths
    # $('.sortable').each (sortable_index, sortable_element) =>
    #   sortable_element.addEventListener 'sortstart', (ev) =>
    #     item = $(ev.detail.item)
    #     placeholder = $(ev.detail.placeholder)
    #
    #     placeholder.css('height', item.css('height'))
    #     placeholder.css('width', item.css('width'))

    $('.sortable').each (sortable_index, sortable_element) =>
      sortable_element.addEventListener 'sortupdate', =>
        @_calculateListItemPriorities()

    # Handle new ListItem Insertion & Removal
    $('#list-items')
      .on 'cocoon:after-insert', (e, new_item) =>
        @_handleListItemInsertion(new_item)

      .on 'cocoon:before-remove', (e, removed_item) =>
        @_calculateListItemPriorities()

    # Handle Edit click for title or description
    $('.overview .input-display').on 'click', '.material-icons', (e) =>
      @_showListField(e.target)

    # Handle overview input-field defocus
    $('.overview input').focusout (e) =>
      @_hideListField(e.target)

    # Do not allow submit on enter
    $('form').on 'keyup keypress', (e) =>
      keyCode = e.keyCode or e.which
      if keyCode == 13
        e.preventDefault()
        inputId = e.target.id

        if inputId == 'list_description' or inputId == 'list_title'
          @_hideListField(e.target)


  _setupForm: ->
    @formValidator = $('.edit_list').parsley
      successClass: '',
      errorClass: 'has-error',
      errorsWrapper: '<div class=\"parsley-error-block\"></div>',
      errorTemplate: '<span></span>'
      classHandler: (element) =>
        element.$element.closest('.input-field')

  # Hides title or description input
  _hideListField: (input) ->
    iconHtml = "<i class='material-icons'>edit</i>"
    inputContainer = $(input.closest('.input-field'))
    inputContainer.addClass 'hide'
    inputContainer.prev('.input-display').html "#{input.value}#{iconHtml}"
    inputContainer.prev('.input-display').removeClass 'hide'

  # Shows title or description input
  _showListField: (input) ->
    displayContainer = $(input.closest('.input-display'))
    displayContainer.addClass 'hide'
    displayContainer.next('.input-field').removeClass 'hide'
    displayContainer.next('.input-field').find('input').focus()

  # Initalize drag and drop
  _initializeSortable: ->
    sortable '.sortable',
      items: '.list-item-container'

  # Create List Item objects
  _createListItems: ->
    @listItemContainer.each (i, itemContainer) =>
      new ListItem(@, itemContainer)

  # Calculate & set list item priorities
  _calculateListItemPriorities: ->
    $('.list-item-container').each (priority, itemContainer) =>
      $(itemContainer).find('.priority-field').val(priority)

  # Initializes new List Item
  _handleListItemInsertion: (new_item) ->
    # Create connection to modal
    modal = new_item.find('.modal')
    modalTrigger = new_item.find('.modal-trigger')
    modal.attr("id","list-item-modal-#{$.now()}")
    modalTrigger.attr("href","#list-item-modal-#{$.now()}")

    # Initialize new ListItem
    list_item = new ListItem(@, new_item)

    @_initializeSortable()
    @_calculateListItemPriorities()
    new_item.find('select').material_select()

    # Open modal
    list_item.openModal()
