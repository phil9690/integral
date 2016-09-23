class this.MenuItem
  # MenuItem constructor
  constructor: (container) ->
    @container = $(container)
    @modal = @container.find('.modal')
    @titleText = @container.find('.data .title')
    @urlText = @container.find('.data .url')
    @urlField = @modal.find('.url-field')
    @titleField = @modal.find('.title-field')

    @setupEvents()

  setupEvents: ->
    @modal.find('.confirm-btn').click (e) =>
      # Validate form before closing Modal
      if @_getForm().isValid(@_getFormValidators(@_getForm()))
        @modal.closeModal()

        # Update the menu item
        @titleText.text(@titleField.val())
        @urlText.text(@urlField.val())
      else
        # TODO: Update to I18n
        Materialize.toast('Please fix the form errors before continuing.', 4000, 'error')

  _getForm: ->
    $('form')

  _getFormValidators: (form) ->
    formValidators = ClientSideValidations.forms[form.attr('id')].validators
