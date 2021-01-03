$(document).ready(function() {
  // hide or show the "back to top button" depending on scroll from top
  $(window).scroll(function(){
    if ($(this).scrollTop() > 1000 ) {
      $('.back-to-top').removeClass('invisible');
    } else {
      $('.back-to-top').addClass('invisible');
    }
  });
  
  // smooth scroll to top
  $('.back-to-top').on('click', function(event){
    event.preventDefault();
    $('body, html').animate({
      scrollTop: 0
    });
  });
 
  // search for a folder  
  $('#search-folder').on('keyup', function() {
    var value = $(this).val();
    // shows remove button when there is a search term
    $('#remove-search').toggle(value != 0).removeClass('d-none'); 
  });

  // remove search term value from input
  $('#remove-search').on('click', function() {
    $('#search-folder').val('');
    $(this).addClass('d-none');
  })
})