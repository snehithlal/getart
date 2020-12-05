
(function (window, $) {
  var FILE_ICON_URL = 'https://icons.iconarchive.com/icons/zhoolego/material/512/Filetype-Docs-icon.png'

  function addFileToNewInput(file, newInput) {
    if (!newInput) { return }

    var dataTransfer = new DataTransfer()
    dataTransfer.items.add(file)
    newInput.files = dataTransfer.files
  }

  function addSrcToPreview(file, preview) {
    if (!preview) { return }

    if (file.type.match(/image/)) {
      var reader = new FileReader()
      reader.onload = function (e) { preview.src = e.target.result }
      reader.readAsDataURL(file)
    } else {
      preview.src = FILE_ICON_URL
    }
  }

  function breakIntoSeparateFiles(input, targetSelector, templateSelector) {
    var $input = $(input)
    var templateHtml = $(templateSelector).html()

    if (!input.files) { return }

    for(var file of input.files) {
      var $newFile = $(templateHtml).appendTo(targetSelector)
      addFileToNewInput(file, $newFile.find("input")[0])
      addSrcToPreview(file, $newFile.find("img")[0])
    }

    $input.val([])
  }

  window.breakIntoSeparateFiles = breakIntoSeparateFiles
})(window, jQuery);