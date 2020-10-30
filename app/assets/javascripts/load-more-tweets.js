$(document).ready(function() {
  if ($('#paginate-load-more-button').length > 0) {
    $('#paginate-load-more-button .pagination').hide()

    $('#load-more-tweets').show().click(function() {
      more_posts_url = $('#paginate-load-more-button .pagination a.next_page').attr('href');
      console.log(more_posts_url)
      $this = $(this);
      $this.html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />').addClass('disabled');
      $.getScript(more_posts_url, function() {
        if ($this) {
          $this.text('Load more posts').removeClass('disabled');
        }
      });
    });
  };
})