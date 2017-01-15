document.addEventListener "turbolinks:load", ->
  ## DATE PICKER ##
  $('.datepicker').pickadate(
    selectMonths: true
    selectYears: 25
  )

  ## TIME PICKER ##
  $('.timepicker').pickatime(
    twelvehour: true
    donetext: 'Done'
    beforeShow: ->
      activeElement = $(document.activeElement)
      activeForm = activeElement.closest('form')[0]

      # Remove existing validation errors
      activeForm.ClientSideValidations.removeError(activeElement)

      # Prevent a validation error occurring when element unfocusses
      activeElement.disableClientSideValidations()

    afterDone: ->
      activeElement = $(document.activeElement)
      $(activeElement).enableClientSideValidations()
  )
