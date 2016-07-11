$(document).on "ready page:load", ->
  $(".posts.new").ready ->
    postTitle = $('#post_title')
    postSlug = $('#post_slug')
    customSlug = false

    postTitle.change ->
      if not customSlug
        title = postTitle.val()
        postSlug.val(toSlug(title))
        Materialize.updateTextFields()

    postSlug.change ->
      customSlug = true
      slug = postSlug.val()
      postSlug.val(toSlug(slug))

  $(".posts.edit").ready ->
    postTitle = $('#post_title')
    postSlug = $('#post_slug')

    postSlug.change ->
      slug = postSlug.val()
      postSlug.val(toSlug(slug))

window.toSlug = (text) ->
  text.toString().toLowerCase()
  .replace(/\s+/g, '-')                 # Replace spaces with -
  .replace(/[^\u0100-\uFFFF\w\-]/g,'-') # Remove all non-word chars ( fix for UTF-8 chars )
  .replace(/\-\-+/g, '-')               # Replace multiple - with single -
  .replace(/^-+/, '')                   # Trim - from start of text
  .replace(/-+$/, '')
