class this.SlugGenerator
  # Checks for any slugs on the page and initializes SlugGenerator
  @check_for_slugs: ->
    for slug in $('[data-slugify]')
      slug = $(slug)
      sluggable = $(slug.data('slugify'))
      new SlugGenerator(sluggable, slug) if sluggable.length != 0

  # Slugs given strings
  @slugify: (sluggable) ->
    sluggable.toString().toLowerCase()
    .replace(/\s+/g, '-')                 # Replace spaces with -
    .replace(/[^\u0100-\uFFFF\w\-]/g,'-') # Remove all non-word chars ( fix for UTF-8 chars )
    .replace(/\-\-+/g, '-')               # Replace multiple - with single -
    .replace(/^-+/, '')                   # Trim - from start of text
    .replace(/-+$/, '')

  # SlugGenerator constructor
  constructor: (inputField, outputField) ->
    @inputField = inputField
    @outputField = outputField

    @setupEvents()

  # Sets event listeners on slug fields
  setupEvents: =>
    @inputField.change =>
      if @outputField.val() == ''
        @setSlug(@inputField.val())

    @outputField.change =>
      @setSlug(@outputField.val())

  # Sets event listeners on slug fields
  setSlug: (sluggable) =>
    @outputField.val(SlugGenerator.slugify(sluggable))
    Materialize.updateTextFields()

