class this.MenuItem
  # MenuItem constructor
  constructor: (container) ->
    @outerContainer = $(container)
    @container = @outerContainer.find('.menu-item:first')
    @modal = @container.find('.modal')
    @titleText = @container.find('.data .title')
    @urlText = @container.find('.data .url')
    @urlField = @modal.find('.url-field')
    @titleField = @modal.find('.title-field')
    @targetField = @modal.find('.target-field')
    @objectField = @modal.find('.object-field')
    @objectTypeField = @modal.find('.object-type-field')
    @objectWrapper = @modal.find('.object-wrapper')
    @linkWrapper = @modal.find('.link-wrapper')

    @setIcon()
    @setupEvents()

  setupEvents: ->
    # Initialize modal trigger
    @container.find('.modal-trigger').leanModal(@_modalOptions())

    # Set children menu items to be inserted in correct location
    @container.find('.add-children a').data "association-insertion-node", (link) =>
      @outerContainer.find('.children')

    @container.find('.add-children a').click =>
      @expandChildren()

    # Handle clicking of confirmation button within modal
    @modal.find('.confirm-btn').click (e) =>
      e.preventDefault()
      @_handleConfirmClick()

    # Handle clicks on identifier button (submenu dropdown toggle)
    @container.on 'click', '.identifier.action', =>
      @_toggleChildren()

    # Handle new MenuItem Insertion & Removal
    @outerContainer.on 'cocoon:after-insert', '.children', =>
        @setIcon()
    @outerContainer.on 'cocoon:after-remove', '.children', =>
        @setIcon()

    @objectField.change (e) =>
      @handleObjectUpdate()

  handleObjectUpdate: ->
    switch @objectField.val()
      when 'basic' then @handleBasicSelection()
      when 'link' then @handleLinkSelection()
      when 'object' then @handleObjectSelection()

  handleBasicSelection: ->
    @objectWrapper.addClass 'hide'
    @linkWrapper.addClass 'hide'

  handleLinkSelection: ->
    @objectWrapper.addClass 'hide'
    @linkWrapper.removeClass 'hide'


  handleObjectSelection: ->
    objectType = @objectField.find(":selected").data('object-type')
    @objectTypeField.val(objectType)
    console.log "Set type field to #{objectType}"

    # TODO: Implement proper object selection through additional modal
    @objectWrapper.removeClass 'hide'
    @linkWrapper.removeClass 'hide'

  expandChildren: ->
    @_getChildren().removeClass 'hide'
    @setIcon()

  setIcon: ->
    icon = 'web'
    classes = ''

    if @_hasChildren()
      icon = if @_getChildren().hasClass('hide') then 'expand_more' else 'expand_less'
      classes = 'action'
    else
      icon = 'cloud' if @targetField.is(':checked')
      icon = 'list' if @objectField.val() == 'basic'

    @container.find('.identifier').addClass(classes)
    @container.find('.identifier').text(icon)

  _hasChildren: ->
    return true if @outerContainer.has('.children .menu-item').length
    false

  openModal: ->
    @modal.openModal(@_modalOptions())

  # Toggle children element visibility
  _toggleChildren: ->
    @_getChildren().toggleClass 'hide'
    @setIcon()

  # Get element which contains children
  _getChildren: ->
    @outerContainer.find('.children')

  # Handles when user clicks the ok button on modal
  _handleConfirmClick: ->
    # Validate form before closing Modal
    if @_formIsValid()
      @modal.closeModal()
      @container.trigger 'modal-close'

      # Update the menu item
      @titleText.text(@titleField.val())
      @urlText.text(@urlField.val())
      @setIcon()
    else
      # TODO: Update to I18n
      Materialize.toast('Please fix the form errors before continuing.', 4000, 'error')

  # Returns validity of form
  _formIsValid: ->
    form = $('form')

    return false unless form.isValid(ClientSideValidations.forms[form.attr('id')].validators)

    # Have to add custom validation as for some reason ClientSideValidation is not working for children menu items
    if $.trim(@titleField.val())=='' or $.trim(@urlField.val())==''
      return false
    true

  # Modal Initialization options
  _modalOptions: ->
    dismissible: false,
    ready: =>
      @modal.find('input').enableClientSideValidations()
    complete: =>
      @container.trigger 'modal-close'

