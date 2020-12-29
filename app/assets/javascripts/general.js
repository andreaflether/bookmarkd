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

  // Active pages on the toggle folders sidebar
  var current = location.pathname;
  $('a.list-group-item-action').each(function(){
      var $this = $(this);
      // if the current path is like this link, make it active
      if($this.attr('href') == current){
          $this.addClass('active');
      }
  })

  // Folders toggle sidebar
  $('#toggle-sidebar').on('click', function() {
    toggleSidebarClass($(this))
  })
  
  // Switch toggle button classes
  function toggleSidebarClass(el) {
    $('.folder-menu').toggleClass('expanded');
    let icon = $('#toggle-sidebar').find('svg')
    if(icon.hasClass('fa-folder')) {
      window.setTimeout(function() {
        icon.switchClass('fa-folder', 'fa-folder-open');
      }, 300);
    } else {
      window.setTimeout(function() {
        icon.switchClass('fa-folder-open', 'fa-folder');
      }, 200);
    }
  }

  // Toggle folder sidebar on F press
  $(document).keydown(function(e) {
    if (e.keyCode == 70) { // F key
      if(e.target.matches("input, textarea")) return;
      toggleSidebarClass($('#toggle-sidebar').find('svg'))
    }
  });
})

$(document).ajaxComplete(function() {
  initializeTippy();
});

function initializeTippy() {
  tippy('[data-tippy-content]', {
    arrow: false,
    theme: 'translucent',
  });
}