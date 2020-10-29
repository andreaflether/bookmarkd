$(document).ready(function() {
  let copyToClipboard = $('.copyTweetLink');

  copyToClipboard.on('click', function(e){
    e.preventDefault();
    let copyText = copyToClipboard.prev().attr('href');
    let formattedUrl = window.location.origin + copyText;
    document.addEventListener('copy', function(e) {
      e.clipboardData.setData('text/plain', formattedUrl);
      e.preventDefault();
    }, true);
    document.execCommand('copy');
    toastr.success('Tweet URL copied to clipboard!')  
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