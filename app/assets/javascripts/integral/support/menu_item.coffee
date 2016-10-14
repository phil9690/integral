class this.MenuItem
  # MenuItem constructor
  constructor: (menu, container) ->
    @menu = menu
    @outerContainer = $(container)
    @container = @outerContainer.find('.menu-item:first')
    @modal = @container.find('.modal')
    @titleText = @container.find('.data .title')
    @urlText = @container.find('.data .url')
    @urlField = @modal.find('.url-field')
    @titleField = @modal.find('.title-field')
    @targetField = @modal.find('.target-field')
    @typeField = @modal.find('.type-field')
    @fakeTypeField = @modal.find('.faketype-field')
    @objectTypeField = @modal.find('.object-type-field')
    @objectIdField = @modal.find('.object-id-field')
    @objectPreview = @modal.find('.object-preview')
    @objectWrapper = @modal.find('.object-wrapper')
    @linkWrapper = @modal.find('.link-wrapper')

    if @object()
      @objectData = @objectPreview.data()

    @setIcon()
    @setupEvents()

  setupEvents: ->
    @outerContainer.on 'modal-close', =>
      sortable('.sortable', 'enable')

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

    @fakeTypeField.change (e) =>
      @handleObjectUpdate()

    @objectPreview.click =>
      @_openSelector()

  handleObjectUpdate: ->
    # Remove errors (resetting form causes wierd problems)
    @menu.formValidator.toHide = @menu.formValidator.errors()
    @menu.formValidator.hideErrors()
    $('form .has-error').removeClass('has-error')

    @typeField.val @fakeTypeField.find(':selected').data('true-value')
    switch @typeField.val()
      when 'Integral::Basic' then @handleBasicSelection()
      when 'Integral::Link' then @handleLinkSelection()
      when 'Integral::Object' then @handleObjectTypeSelection()

  handleBasicSelection: ->
    @objectWrapper.addClass 'hide'
    @linkWrapper.addClass 'hide'
    @titleField.addClass 'required'

  handleLinkSelection: ->
    @objectWrapper.addClass 'hide'
    @linkWrapper.removeClass 'hide'

    @titleField.addClass 'required'
    @urlField.addClass 'required'

  handleObjectTypeSelection: ->
    @_openSelector()

  handleObjectSelectionFail: =>
    @typeField.val('Integral::Basic')
    @typeField.material_select()

  handleObjectSelection: (data) =>
    objectType = @typeField.find(":selected").data('object-type')
    @objectTypeField.val(objectType)
    @objectData = data

    # Update object preview
    @objectIdField.val(data.id)
    @objectPreview.find('img').attr('src', data.image)
    @objectPreview.find('h5').text(data.title)
    @objectPreview.find('.subtitle').text(data.subtitle)
    @objectPreview.find('.url').text(data.url)

    @objectWrapper.removeClass 'hide'
    @linkWrapper.removeClass 'hide'

    # Update validation
    @titleField.removeClass 'required'
    @urlField.removeClass 'required'
    @objectIdField.addClass 'required'

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
      icon = 'list' if @basic()

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

  _updateMenuItem: ->
    title = ''
    url = ''
    if @object()
      title = @objectData.title
      url = @objectData.url
    title = @titleField.val() if @titleField.val() != ''
    url = @urlField.val() if @urlField.val() != ''

    @titleText.text(title)
    @urlText.text(url)
    @setIcon()

  basic: ->
    if @typeField.val() == 'Integral::Basic'
      return true
    false

  _getObjectData: ->
    selectedObject = @objectIdField.find(':selected')
    selectedObject.data()

  object: ->
    if @typeField.val() == 'Integral::Object'
      return true
    false

  # Handles when user clicks the ok button on modal
  _handleConfirmClick: ->
    # Validate form before closing Modal
    if $('form').valid()
      @modal.closeModal()
      @container.trigger 'modal-close'

      @_updateMenuItem()
    else
      # TODO: Update to I18n
      Materialize.toast('Please fix the form errors before continuing.', 4000, 'error')

  # Modal Initialization options
  _modalOptions: ->
    dismissible: false,
    ready: =>
      sortable('.sortable', 'disable')
    complete: =>
      @container.trigger 'modal-close'


  _openSelector: ->
    selectorOpts =
      preselectedId: @objectIdField.val()
      callbackSuccess: @handleObjectSelection
      callbackFailure: @handleObjectSelectionFail

    RecordSelector.open(@fakeTypeField.find(":selected").data('record-selector'), selectorOpts)

