$(document).ready(function() {
  toastr.options = {
    closeButton: false,
    debug: false,
    newestOnTop: false,
    progressBar: false,
    positionClass: 'toast-bottom-center',
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
    toastr.success('Tweet URL copied to clipboard!')  
  })

  $('input[maxlength], textarea').maxlength({
    alwaysShow: true, 
    warningClass: 'form-text badge badge-success mt-1', 
    limitReachedClass: 'form-text badge badge-danger mt-1', 
    postText: ' chars',
    placement: 'bottom-right-inside',
    showOnReady: true, 
    twoCharLinebreak: false,
  });
})