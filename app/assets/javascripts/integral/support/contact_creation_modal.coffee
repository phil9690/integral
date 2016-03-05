class this.ContactCreationModal
  @init: ->
    ps = new ContactCreationModal()
    ps.setupEvents()

  # ContactCreationModal constructor
  constructor: ->
    @modal = $('#new_image_modal')
    @submitBtn = $('#new_image_submit_btn')
    @imageHolder = $('.image-containers')
    @imgContainerWidth = $($('.image-container')[0]).outerWidth() + 1
    @form = $('#new_image')
    @formOpts =
      beforeSubmit:   @_handleFormSubmission
      success:        @_handleFormResponse
      error:          @_handleFormError
      clearForm:      true
      resetForm:      true

  # Sets event listeners on all gallery image thumbnails
  setupEvents: ->
    @form.ajaxForm(@formOpts)

    $('.modal-trigger-new-image').leanModal(
      ready: ->
        $('#new_image').enableClientSideValidations()
    )

  resetForm: ->
    @submitBtn.prop('disabled', false)
    @submitBtn.removeClass('disabled')
    @submitBtn.text('Create image')

  _handleFormSubmission: =>
    formValidators = ClientSideValidations.forms[@form.attr('id')].validators

    return false unless @form.isValid(formValidators)

    @submitBtn.prop('disabled', true)
    @submitBtn.addClass('disabled')
    @submitBtn.text('Uploading..')

  _handleFormResponse: (responseText, statusText, xhr, $form) =>
    @imageHolder.prepend(responseText)
    @newImage = $($('.image-container')[0])
    @newImage.css("margin-left", -@imgContainerWidth)
    @newImage.removeClass("hide")
    @modal.closeModal( { complete: @handleModalClosure })

    Materialize.toast('Image created.', 4000, 'notice')

  _handleFormError: =>
    @resetForm()
    Materialize.toast('An error occured when uploading the image', 4000, 'error')

  handleModalClosure: =>
    if @newImage
      @newImage.css("margin-left", "0")
      @newImage = nil

    @resetForm()

