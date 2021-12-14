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

  // add 'warning' on potentially destructive actions confirmation modal
  $(document).on('show.bs.modal', function (event) {
    let modal = $(event.target);
    let modal_body = modal.find('.modal-body');

    let destructive_warning = modal.find('.modal-content #destructive-warning');
   
    if(modal_body.find('p.destructive').length) {
      if(destructive_warning.length) {
        return;     
      } else {
        let last_paragraph = modal_body.find('p:last');
        let content = last_paragraph.text();

        last_paragraph.html(content);
        
        let warning_content = ` \
          <p id="destructive-warning"> \
            <i class='fas fa-exclamation-triangle'></i> \
            <b>Warning:</b> this is a potentially destructive action, therefore permanent. \ 
            Once you do it, there is no going back. \ 
          </p> \
        `;
        $(warning_content).insertAfter(modal.find('.modal-header'))   
      }
    }
  });

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
  $('#page-content').on('click', '.copyLink', function (){
    if ($(this).attr('data-copy') == 'folder') {
      var copyLink = window.location.href;  
      var msg = 'Folder link copied to clipboard!';
    } else {
      var copyLink = $(this).closest('div[data-tweeturl]').attr('data-tweeturl');  
      var msg = 'Tweet URL copied to clipboard!';
    } 
    document.addEventListener('copy', function(e) {
      e.clipboardData.setData('text/plain', copyLink);
      e.preventDefault();
    }, true);
    document.execCommand('copy');

    toastr.info(msg)  
  })

  function switchForBrand(el) {
    el.prev().switchClass('text-muted', 'text-primary', 50, 'easeInOutQuad' );
  }
  
  function switchForMuted(el) {
    el.prev().switchClass('text-primary', 'text-muted', 50, 'easeInOutQuad' );
  }
  
  $('.hasToggledIcon').on('focusin', function() { switchForBrand($(this)); })
  $('.hasToggledIcon').on('focusout', function() { switchForMuted($(this)); })
})

function initializeTippy() {
  tippy('[data-tippy-content], button.btn-action', {
    arrow: false,
    theme: 'translucent',
    allowHTML: true,
    content(reference) {
      const title = reference.getAttribute('title');
      reference.removeAttribute('title');
      return title;
    },
  });
};
