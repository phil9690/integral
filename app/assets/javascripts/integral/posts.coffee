$(document).on "ready page:load", ->
  $(".posts.new").ready ->
    postTitle = $('#post_title')
    postSlug = $('#post_slug')
    customSlug = false

    postTitle.change ->
      if not customSlug
        title = postTitle.val()
        titleParameterized = title.toLowerCase()
          .replace(/[^\w\s-]/g, '')
          .replace(/[\s_-]+/g, '-')
          .replace(/^-+|-+$/g, '')

        postSlug.val(titleParameterized)
        Materialize.updateTextFields()

    postSlug.change ->
      customSlug = true
      slug = postSlug.val()
      slugParameterized = slug.toLowerCase()
          .replace(/[^\w\s-]/g, '')
          .replace(/[\s_-]+/g, '-')
          .replace(/^-+|-+$/g, '')

      postSlug.val(slugParameterized)

  $(".posts.edit").ready ->
    postTitle = $('#post_title')
    postSlug = $('#post_slug')

    postSlug.change ->
      slug = postSlug.val()
      slugParameterized = slug.toLowerCase()
          .replace(/[^\w\s-]/g, '')
          .replace(/[\s_-]+/g, '-')
          .replace(/^-+|-+$/g, '')

      postSlug.val(slugParameterized)

