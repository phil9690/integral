# Modal which contains list of records
class this.RecordSelector
  constructor: (containerSelector) ->
    @containerSelector = containerSelector
    @container = $(containerSelector)
    @progressBar = @container.find('.progress')
    @confirmButton = @container.find('.close-button')
    @closeButton = @container.find('.close-btn')
    @searchButton = @container.find('.search-button')
    @searchPath = @container.data('record-path')
    @searchField = @container.find('.search-field')
    @pageField = @container.find('.page-field')
    @recordsContainer = @container.find('.records')
    @selectedText = @container.find('.selected')
    @previousSearch = ''
    @form = @container.find('form')

    @_setupEvents()

  # TODO: Set this to accept options
  open: (selectedId=-1, callbackSuccess, callbackFailure) ->
    @selectedId = selectedId
    @container.openModal(dismissible: false)
    @form.submit()
    @_callbackSuccess = callbackSuccess
    @_callbackFailure = callbackFailure

  _setupEvents: ->
    # Handle click on record
    @recordsContainer.on 'click', '.record', (e) =>
      $(@containerSelector).find(".record.selected").removeClass 'selected'
      @selectedRecord = $(e.target).closest('.record')
      @selectedData = @selectedRecord.data()
      @selectedId = @selectedData.id
      @selectedRecord.addClass 'selected'
      @confirmButton.removeClass 'disabled'
      @selectedText.text("Selected: #{@selectedData.title}")

    @searchField.keypress (ev) =>
      @pageField.val(1)
      @form.submit() if @searchField.val() != @previousSearch && ev.which == 13

    @searchButton.click (ev) =>
      @pageField.val(1)

    @recordsContainer.on 'click', '.pagination a', (ev) =>
      ev.preventDefault()
      pageNumber = @getUrlVars(ev.target.href)['page']
      @pageField.val(pageNumber)
      @form.submit()

    @form.on "ajax:beforeSend", (e, data, status, xhr) =>
      @_handleSearchSubmission()
    @form.on "ajax:success", (e, data, status, xhr) =>
      @_handleSuccessfulSearch(data)
    @form.on "ajax:error", (e, xhr, status, error) =>
      @_handleFailedSearch(error)

    @searchButton.click (ev) =>
      ev.preventDefault() if @searchField.val() == @previousSearch

    @closeButton.click (ev) =>
      @_handleQuit()

    @confirmButton.click (ev) =>
      ev.preventDefault()
      if @selectedRecord
        @container.closeModal()
        @container.trigger 'object-selection', [@selectedData]
        @_callbackSuccess(@selectedData)

  _handleQuit: ->
    @_callbackFailure()

  _handleSuccessfulSearch: (data) ->
    @recordsContainer.html(data['content'])
    @progressBar.hide()
    @recordsContainer.show()

    $(@containerSelector).find(".record[data-id='" + @selectedId + "']").addClass 'selected' if @selectedId

  # TODO: Implement this properly
  _handleFailedSearch: (data) ->
    console.log 'Fail'
    console.log data

  _handleSearchSubmission: ->
    @progressBar.show()
    @recordsContainer.hide()
    @previousSearch = @searchField.val()

  # Move out into main file to extend jquery
  getUrlVars: (url) ->
    vars = []
    hashes = url.slice(url.indexOf('?') + 1).split('&')

    for hash in hashes
      hashArr = hash.split('=')
      vars.push(hashArr[0])
      vars[hashArr[0]] = hashArr[1]
    vars

  getUrlVar: (url, name) ->
    @getUrlVars(url)[name]

