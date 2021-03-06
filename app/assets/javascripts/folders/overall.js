$(document).ready(function() {
  const PRIVACY_DESCRIPTIONS = {
    'open': '<i class="fas fa-link"></i> Any user with a link can access the folder.',
    'secret': '<i class="fas fa-lock"></i> Only you have access to the folder.'
  }

  // add folder 'Privacy' description based on the selected option
  $('#folder_privacy').change(function() {
    let input_value = $(this).val();
    $('#privacy-description').html(PRIVACY_DESCRIPTIONS[input_value])
  }).change();

  // hide or show the "back to top button" depending on scroll from top
  $(document).on('scroll load', function(){
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