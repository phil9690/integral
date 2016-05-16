$(document).on "ready page:load", ->
  $(".users").ready ->
    avatarUploader = $("#user_avatar-uploader")

    avatarUploader.on 'change', =>
      if (typeof (FileReader) != "undefined") 
        imageContainer = $('#user-avatar')
        reader = new FileReader()
        reader.onload = (e) =>
          imageContainer.attr('src', e.target.result)
        reader.readAsDataURL(avatarUploader[0].files[0])
      else
        console.log("This browser does not support FileReader.")

