class this.ContactCreationModal
  @init: ->
    ps = new ContactCreationModal()
    ps.setupEvents()

  # ContactCreationModal constructor
  constructor: ->
    @modal = $('#new_image_modal')
    @submitBtn = $('#new_image_submit_btn')
    @imageHolder = $('#image-container')
    @imgContainerWidth = @_findFirstImage().outerWidth() + 1
    @form = $('#new_image')
    @formOpts =
      beforeSubmit:   @_handleFormSubmission
      success:        @_handleFormSuccess
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

  _handleFormSuccess: (responseText, statusText, xhr, $form) =>
    @imageHolder.prepend(responseText)
    @newImage = @_findFirstImage()
    @newImage.css("margin-left", -@imgContainerWidth)
    @newImage.removeClass("hide")
    @modal.closeModal( { complete: @handleModalClosure })

    Materialize.toast('Image created.', 4000, 'notice')

  _handleFormError: =>
    @resetForm()
    Materialize.toast('An error occured when uploading the image', 4000, 'error')

  handleModalClosure: =>
    @newImage.css("margin-left", "0") if @newImage

    @resetForm()

  _findFirstImage: =>
    $($('.integral-image')[0])
