# Present confirmation dialog to user
$.rails.showConfirmationDialog = (link) ->
  message = link.data("confirm")
  modalSelector = $.rails.appendConfirmationDialog(link, message)

  $(modalSelector).openModal()

# Build confirmation Dialog
$.rails.buildConfirmationDialog = (message, modalId, confirmBtnId, cancelBtnId) ->
  "<div id='#{modalId}' class='modal modal-confirmation'>
    <div class='modal-content center-align'>
      <h4>#{I18n.t('integral.backend.confirmation_modal.title')}</h4>
      <p>#{message}</p>
      <span>
        <a id='#{confirmBtnId}' class='waves-effect waves-light btn'>#{I18n.t('integral.backend.confirmation_modal.confirm')}</a>
        <a id='#{cancelBtnId}' class='waves-effect waves-light btn red lighten-2'>#{I18n.t('integral.backend.confirmation_modal.cancel')}</a>
      </span>
    </div>
  </div>"

# Add confirmation dialog to DOM and setup event listeners
$.rails.appendConfirmationDialog = (link, message) ->
  id = Date.now()
  modalId = "rails_confirm_modal_#{id}"
  confirmBtnId = "rails_confirm_modal_#{id}_confirm_btn"
  cancelBtnId = "rails_confirm_modal_#{id}_cancel_btn"
  modalSelector = "##{modalId}"

  confirmationDialogContents = $.rails.buildConfirmationDialog(message, modalId, confirmBtnId, cancelBtnId)
  $(confirmationDialogContents).appendTo 'body'

  $("##{confirmBtnId}").click ->
    $.rails.confirmed(link)
    $(modalSelector).closeModal()

  $("##{cancelBtnId}").click =>
    $(modalSelector).closeModal()

  modalSelector

# Handle user confirmation of confirm modal
$.rails.confirmed = (link) ->
  link.data('confirm', '')
  link.trigger("click.rails")

# Override the default confirm dialog by rails
$.rails.allowAction = (link) ->
  return true if link.data('confirm') == '' || link.data('confirm') == undefined

  $.rails.showConfirmationDialog(link)
  false

