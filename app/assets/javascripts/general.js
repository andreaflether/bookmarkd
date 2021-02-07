$(document).ready(function() {
  initializeTippy();

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

  $('.has-max-length').maxlength({
    alwaysShow: true, 
    warningClass: 'small text-muted mt-1', 
    limitReachedClass: 'small text-danger mt-1', 
    placement: 'bottom-right-inside',
    showOnReady: true, 
    twoCharLinebreak: false,
    appendToParent: true
  });

  // Copy tweet link to clipboard
  $('#page-content').on('click', '.copyTweetLink', function (){
    let copyLink = $(this).closest('div[data-tweeturl]').attr('data-tweeturl')
    document.addEventListener('copy', function(e) {
      e.clipboardData.setData('text/plain', copyLink);
      e.preventDefault();
    }, true);
    document.execCommand('copy');
    toastr.info('Tweet URL copied to clipboard!')  
  })

  function switchForBrand(el) {
    el.prev().switchClass('text-muted', 'text-brand', 50, 'easeInOutQuad' );
  }
  
  function switchForMuted(el) {
    el.prev().switchClass('text-brand', 'text-muted', 50, 'easeInOutQuad' );
  }
  
  $('.hasToggledIcon').on('focusin', function() { switchForBrand($(this)); })
  $('.hasToggledIcon').on('focusout', function() { switchForMuted($(this)); })
})

function initializeTippy() {
  tippy('[data-tippy-content], button.btn-action', {
    arrow: false,
    theme: 'translucent',
    allowHTML: true,
    content(reference) {
      const title = reference.getAttribute('title');
      reference.removeAttribute('title');
      return title;
    },
  });
};
