$(document).ready(function() {
  $('[data-toggle="tooltip"]').tooltip({
    container: 'body',
    trigger: 'hover',
  })

  $('[data-toggle="tooltip"]').on('click', function () {
    $(this).tooltip('dispose');
  });

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
    let copyLink = copyToClipboard.closest('div[data-tweeturl]').attr('data-tweeturl')
    document.addEventListener('copy', function(e) {
      e.clipboardData.setData('text/plain', copyLink);
      e.preventDefault();
    }, true);
    document.execCommand('copy');
    toastr.info('Tweet URL copied to clipboard!')  
  })

  $('.has-max-length').maxlength({
    alwaysShow: true, 
    warningClass: 'small text-white-50 mt-1', 
    limitReachedClass: 'small text-danger mt-1', 
    placement: 'bottom-right-inside',
    showOnReady: true, 
    twoCharLinebreak: false,
    appendToParent: true
  });

  $('.input-group-append').find('button').switchClass('btn-outline-secondary', 'btn-outline-light')
})