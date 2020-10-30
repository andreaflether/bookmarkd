$(document).ready(function() {
  $('[data-toggle="tooltip"]').tooltip({
    container: 'body',
    placement: 'bottom',
    trigger: 'hover'
  })

  toastr.options = {
    closeButton: false,
    debug: false,
    newestOnTop: false,
    progressBar: false,
    positionClass: 'toast-top-center',
    preventDuplicates: false,
    onclick: null,
    showDuration: '300',
    hideDuration: '4000',
    timeOut: '5000',
    extendedTimeOut: '3000',
    showEasing: 'linear',
    hideEasing: 'linear',
    showMethod: 'fadeIn',
    hideMethod: 'fadeOut'
  }

  let copyToClipboard = $('.copyTweetLink');

  copyToClipboard.on('click', function(e){
    e.preventDefault();
    let copyLink = copyToClipboard.next().parent().attr('data-tweetURL');
    document.addEventListener('copy', function(e) {
      e.clipboardData.setData('text/plain', copyLink);
      e.preventDefault();
    }, true);
    document.execCommand('copy');
    toastr.info('Tweet URL copied to clipboard!')  
  })

  $('input[maxlength], textarea').maxlength({
    alwaysShow: true, 
    warningClass: 'form-text badge badge-success mt-1', 
    limitReachedClass: 'form-text badge badge-danger mt-1', 
    postText: ' chars',
    placement: 'bottom-right-inside',
    showOnReady: true, 
    twoCharLinebreak: false,
    appendToParent: true
  });

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