$(document).ready(function() {
  var opts = {
    textarea: 'editor-text-area',
    clientSideStorage: false,
    button: {
      fullscreen: true,
    }
  }
  
  var editor = new EpicEditor(opts).load();
});

