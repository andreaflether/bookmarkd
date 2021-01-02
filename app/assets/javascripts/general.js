$(document).ready(function() {
  initializeTippy();
  toggleExpandedClass()
  toggleIcon();   

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
    toggleSidebarClass();  
  })

  // Switch toggle button classes
  function toggleSidebarClass() {
    $('.folder-menu').css('transition', 'all .5s ease')
    $('.folder-menu').toggleClass('expanded');
    toggleIcon();
  }

  // Toggle folder sidebar on F press
  $(document).keydown(function(e) {
    if (e.keyCode == 70) { // F key
      if(e.target.matches("input, textarea")) return;
      toggleSidebarClass()
    }
  });
})

function initializeTippy() {
  tippy('[data-tippy-content]', {
    arrow: false,
    theme: 'translucent',
    allowHTML: true,
  });
}

function toggleIcon() {
  let icon = $('#toggle-sidebar').find('i');
  if($('.folder-menu').hasClass('expanded')) {
    icon.switchClass('fa-folder', 'fa-folder-open');
  } else {
    icon.switchClass('fa-folder-open', 'fa-folder');
  }
}

$(window).on('resize', function() {
  toggleExpandedClass();
  toggleIcon();
})

function toggleExpandedClass() {
  if($(document).width() > 1350) {
    $('.folder-menu').addClass('expanded');
  } else {
    $('.folder-menu').removeClass('expanded');
  }
}