$(document).ready(function() {
  var sort_by = $('#folders').attr('data-sort-by');

  $grid = $('#folders').imagesLoaded(function() {
    $grid.isotope({
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
          return Date.parse(updated_at.innerText)
        },
        number_of_bookmarks: function(itemElem) {
          var number_of_bookmarks = $(itemElem).find('.number-of-bookmarks')
          return parseInt(number_of_bookmarks.text().match(/\d+/)[0]);
        }
      },
      sortBy: ['category', sort_by ],
      sortAscending: getAsc(sort_by),
      filter: function() {
        return qsRegex ? $(this).text().match( qsRegex ) : true;
      }
    })
  });

  // quick search regex
  var qsRegex;

  // use value of search field to filter
  var $quicksearch = $('#search-folder').on('keyup', debounce(function() {
    qsRegex = new RegExp($quicksearch.val(), 'gi');
    $grid.isotope();
  }, 200));

  // on 'remove search' button click
  $('#remove-search').on('click', debounce(function() {
    qsRegex = '';
    $grid.isotope();
  }, 200))

  // no results
  var no_results = $('#no-results');
  var sort_filters = $('#sort-filters');
  var search_term = $('#searchTerm');

  $grid.on('arrangeComplete',
  function(event, filteredItems) {
      if(filteredItems.length) {
        no_results.addClass('d-none'); 
        sort_filters.removeClass('d-none'); 
      } else {
        no_results.removeClass('d-none');
        sort_filters.addClass('d-none'); 
        search_term.text($quicksearch.val());
      }
    }
  );

  // debounce so filtering doesn't happen every millisecond
  function debounce( fn, threshold ) {
    var timeout;
    threshold = threshold || 100;
    return function debounced() {
      clearTimeout( timeout );
      var args = arguments;
      var _this = this;
      function delayed() {
        fn.apply( _this, args );
      }
      timeout = setTimeout( delayed, threshold );
    };
  }

  function getAsc(value) {
    if(value == 'number_of_bookmarks' || value == 'updated_at') {
      return false;
    } else {
      return { 
        category: false, 
        sortByValue: true,
      } 
    }
  }

  // change sort-by based on btn group data attr (sort-by)
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