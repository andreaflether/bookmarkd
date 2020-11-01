$(document).ready(function() {
  // hide or show the "back to top button" depending on scroll from top
  $(window).scroll(function(){
    if ($(this).scrollTop() > 800 ) {
      $('.back-to-top-button').removeClass('invisible');
    } else {
      $('.back-to-top-button').addClass('invisible');
    }
  });
  
  // smooth scroll to top
  $('.back-to-top-button').on('click', function(event){
    event.preventDefault();
    $('body,html').animate({
      scrollTop: 0
      }
    );
  });
})
