$(document).ready(function() {
  var sort_by = $('#folders').attr('data-sort-by')

  $grid = $('#folders').isotope({
    itemSelector: '.folder',
    percentPosition: true,
    masonry: {
      horizontalOrder: true,
      isAnimated: true
    },
    getSortData: {
      category: function(itemElem) {
        var category = $(itemElem).attr('data-pinned')
        return category === 'false' ? false : true
      },  
      name: function( itemElem ) {
        var name = $(itemElem).find('.folder-title').text();
        return name.toLowerCase();
      },
      updated_at: function(itemElem) {
        var html = $(itemElem).find('.card-subtitle').attr('data-tippy-content')
        var updated_at = document.createElement('div')
        updated_at.innerHTML = html 
        return updated_at.innerText
      },
      number_of_tweets: function(itemElem) {
        var number_of_tweets = $(itemElem).find('.number-of-tweets')
        return parseInt(number_of_tweets.text().split('')[0]);
      }
    },
    sortBy: ['category', sort_by ],
    sortAscending: getAsc(sort_by)
  });

  function getAsc(value) {
    if(value == 'number_of_tweets') {
      return false;
    } else {
      return { 
        category: false, 
        sortByValue: true,
      } 
    }
  }

  $('.sort-by-button-group').on('click', 'a', function() {
    $(this).parent().siblings().removeClass('btn-brand');
    var sortByValue = $(this).attr('data-sort-by');
    $('#folders').attr('data-sort-by', sortByValue)
    $grid.isotope({ 
      sortBy: [ 'category', sortByValue ], 
      sortAscending: getAsc(sortByValue)
    });
  });

  // change is-checked class on buttons
  $('.sort-by-button-group.btn-group').each(function(i, buttonGroup ) {
    var $buttonGroup = $(buttonGroup);
    $buttonGroup.find(`[data-sort-by=${sort_by}]`).addClass('is-checked')
    $buttonGroup.on('click', 'a', function() {
      $buttonGroup.find('.is-checked').removeClass('is-checked');
      $(this).addClass('is-checked');
    });
  });

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
          $grid.isotope('layout');
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
      $grid.isotope('layout')
    });  
    $('.no-results').hide();
  })
})