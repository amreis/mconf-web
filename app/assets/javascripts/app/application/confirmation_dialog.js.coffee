# Replace Rails' confirmation dialog with a translatable Bootstrap modal dialog.
# Requires jQuery 1.7, Bootstrap, and i18n-js (https://github.com/fnando/i18n-js)
# Translation strings used: confirm.title, confirm.ok, confirm.cancel
# From: https://gist.github.com/1943094
# TODO: enabled i18n
class mconf.ConfirmationDialog

  # All forms with '.form-for-crop' will be associated with the crop
  # functionality. The contents returned after the form is submitted are
  # shown in a modal window and the image in it can be cropped.
  @bind: ->
    if $('[data-confirm]')
      $('body').append("<div class='modal hide' id='confirm_dialog'><div class='modal-header'><a class='close' data-dismiss='modal'>×</a><h3>Confirmation</h3></div><div class='modal-body'></div><div class='modal-footer'><a class='btn btn-danger'></a><a href='#' data-dismiss='modal' class='btn'>Cancel</a></div></div>")
      $('[data-confirm]').each ->
        link_elem = $(this)
        link_elem.off("click.mconfConfirmationDialog")
        link_elem.on "click.mconfConfirmationDialog", (e) ->
          e.preventDefault()
          confirm = $('#confirm_dialog > .modal-footer > .btn-danger')
          new_confirm = link_elem.clone()
          new_confirm.removeAttr('data-confirm id')
          new_confirm.attr('class', 'btn btn-danger')
          new_confirm.html('OK')
          confirm.replaceWith(new_confirm)
          $('#confirm_dialog').modal()

$ ->
  $.rails.confirm = (message) ->
    $("#confirm_dialog > .modal-body").html("<p><i class='icon-warning-sign'></i> " + message + '</p>')
    false
  mconf.ConfirmationDialog.bind()
