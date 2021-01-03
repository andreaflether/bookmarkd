$(document).ready(function() {
  toggleExpandedClass()
  toggleIcon();   

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
      if(e.target.matches('input, textarea')) return;
      toggleSidebarClass()
    }
  });
})

function toggleIcon() {
  let icon = $('#toggle-sidebar').find('i');
  if($('.folder-menu').hasClass('expanded')) {
    icon.switchClass('fa-folder', 'fa-folder-open');
  } else {
    icon.switchClass('fa-folder-open', 'fa-folder');
  }
}

function toggleExpandedClass() {
  if($(document).width() > 1350) {
    $('.folder-menu').addClass('expanded');
  } else {
    $('.folder-menu').removeClass('expanded');
  }
}

$(window).on('resize', function() {
  toggleExpandedClass();
  toggleIcon();
})