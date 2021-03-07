$(document).ready(function() {
  $input = $('#sidebar-folder-search');
  var theme = $('meta[name=application-theme]').attr('content');

  var options = { 
    getValue: 'name',
    url: function(phrase) {
      return `/folders/search?utf8=✓&q[name_cont]=${phrase}`
    },
    categories: [{
      listLocation: 'folders'
    }],
    list: {
      onChooseEvent: function() {
        var url = $input.getSelectedItemData().url;
        window.location.href = url;
        $input.val('');
      }
    },
    theme: bootstrap,
  }

  $input.easyAutocomplete(options)
})