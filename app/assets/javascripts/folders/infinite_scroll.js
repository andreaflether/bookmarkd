$(document).ready(function() {
  $(window).on('scroll', function() { 
    if($('#tweets-container').length) {
    more_bookmarks_url = $('.page-link.next').attr('href');
      if (more_bookmarks_url && ($(window).scrollTop() > $(document).height() - $(window).height() - 60)) {
        $('#pagination').html('<i class="fas fa-sync fa-spin fa-2x"></i>');
        $.getScript(more_bookmarks_url);
      }
    }
  })
})