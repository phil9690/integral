# Modal which contains list of records
class this.RecordSelector
  constructor: (containerSelector) ->
    @containerSelector = containerSelector
    @container = $(containerSelector)
    @progressBar = @container.find('.progress')
    @closeButton = @container.find('.close-button')
    @searchButton = @container.find('.search-button')
    @searchPath = @container.data('record-path')
    @searchField = @container.find('.search-field')
    @searchIcon = @container.find('.search-icon')
    @recordsContainer = @container.find('.records')
    @selectedText = @container.find('.selected')
    @form = @container.find('form')

    #
    # Initially create the selector
    # selector.open(objectId)
    #
    # selector highlights the current selected object
    #
    # Only one record selector for all menu items

    @_setupEvents()
    # @_setupForm()

  open: (objectId=-1) ->
    @container.openModal()
    @form.submit()

  _setupEvents: ->
    # Handle click on record
    @recordsContainer.on 'click', '.record', (e) =>
      $(@containerSelector).find(".record.selected").removeClass 'selected'
      @selectedRecord = $(e.target).closest('.record')
      @selectedData = @selectedRecord.data()
      @selectedRecord.addClass 'selected'
      @closeButton.removeClass 'disabled'
      @selectedText.text("Selected: #{@selectedData.title}")

     @searchField.keypress (ev) =>
       if ev.which == 13
         @form.submit() if @searchField.val() != ''


    # @recordsContainer.on 'click', '.record', (e) =>


    # @searchField.blur =>
    #   @searchIcon.removeClass 'active'
    #
    # @searchField.focus =>
    #   debugger
    #   @searchIcon.addClass 'active'

    @form.on "ajax:beforeSend", (e, data, status, xhr) =>
      @_handleSearchSubmission()
    @form.on "ajax:success", (e, data, status, xhr) =>
      @_handleSuccessfulSearch(data)
    @form.on "ajax:error", (e, xhr, status, error) =>
      @_handleFailedSearch(error)

    @searchField.on 'input propertychange paste change', =>
      if @searchField.val() == ''
        @searchButton.addClass 'disabled'
      else
        @searchButton.removeClass 'disabled'

    @searchButton.click (ev) =>
      ev.preventDefault() if @searchField.val() == ''

    @closeButton.click (ev) =>
      ev.preventDefault()
      @container.closeModal() if @selectedRecord

  _handleSuccessfulSearch: (data) ->
    @recordsContainer.html(data['content'])
    @progressBar.hide()
    @recordsContainer.show()

    $(@containerSelector).find(".record[data-id='" + @selectedData.id + "']").addClass 'selected' if @selectedData

  _handleFailedSearch: (data) ->
    console.log 'Fail'
    console.log data

  _handleSearchSubmission: ->
    @progressBar.show()
    @recordsContainer.hide()
