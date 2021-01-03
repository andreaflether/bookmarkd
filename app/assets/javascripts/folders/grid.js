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
})