class this.MenuItem
  # MenuItem constructor
  constructor: (container) ->
    @outer_container = $(container)
    @container = @outer_container.find('.menu-item:first')
    @modal = @container.find('.modal')
    @titleText = @container.find('.data .title')
    @urlText = @container.find('.data .url')
    @urlField = @modal.find('.url-field')
    @titleField = @modal.find('.title-field')

    @setupEvents()

  openModal: ->
    @modal.openModal(@_modalOptions())

  setupEvents: ->
    # Initialize modal trigger
    @container.find('.modal-trigger').leanModal(@_modalOptions())

    # Set children menu items to be inserted in correct location
    @container.find('.add-children a').data "association-insertion-node", (link) =>
      @outer_container.find('.children')

    # Handle clicking of confirmation button
    @modal.find('.confirm-btn').click (e) =>
      e.preventDefault()
      @_handleConfirmClick()

  # Handles when user clicks the ok button on modal
  _handleConfirmClick: ->
    # Validate form before closing Modal
    if @_formIsValid()
      @modal.closeModal()

      # Update the menu item
      @titleText.text(@titleField.val())
      @urlText.text(@urlField.val())
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
