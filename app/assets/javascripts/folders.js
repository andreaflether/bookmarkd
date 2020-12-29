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
    var value = $(this).val().toLowerCase();
    $('.folder').filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);

      var noResult = true;
      
      $('#folders').children('.folder').each(function () {
      	if ($(this).is(':visible')) {
          $grid.packery('layout');
        	noResult = false; // toggle flag to false when no folder is visible
        }
      });   

      if (noResult) {
        $('.no-results').show();      // show "no results" if search term was not found
        $('#searchTerm').text(value); // add the search term to the "no results"
      }    
    });

    // shows remove button when there is a search term
    $('#remove-search').toggle(value != 0).removeClass('d-none'); 

    // remove "no results" when there is no search term
    if(value.length == 0) {
      $('.no-results').hide();
    }
  });

  // remove search term value from input
  $('#remove-search').on('click', function() {
    $('#search-folder').val('');
    $(this).addClass('d-none');
    // shows all the folders again
    $('#folders').children('.folder').each(function () {
      $(this).show();
    });  
    $('.no-results').hide();
  })
})