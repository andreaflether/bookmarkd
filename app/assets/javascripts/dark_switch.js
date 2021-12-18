$(document).ready(function() {
  // --------------- Customization Points ---------------

  // Declare these methods before loading this script to override them.
  loadTheme = typeof loadTheme === 'function' ? loadTheme : () => localStorage.getItem('bookmarkd-theme')
  saveTheme = typeof saveTheme === 'function' ? saveTheme : theme => localStorage.setItem('bookmarkd-theme', theme)
  
  $('.application-mode').html(`<input type="checkbox" ${getTheme() === 'dark' ? 'checked' : ''} id="darkSwitch">`)

  $('#darkSwitch').bootstrapToggle({
    on: "<i class='fas fa-moon'></i>", 
    off: "<i class='fa fa-sun'></i>"
  })

  const themeChangeHandlers = []
  
  // =============== Initialization ===============
  initTheme()
  
  // =============== Methods ===============
  // adapted from https://github.com/coliff/dark-mode-switch
  
  function initTheme() {
    displayTheme(getTheme())
  }
  
  function getTheme() {
    return loadTheme() || (window.matchMedia(
      '(prefers-color-scheme: dark)').matches ? 'dark' : 'light')
  }
  
  function setTheme(theme) {
    saveTheme(theme)
    displayTheme(theme)
  }
  
  function displayTheme(theme) {
    document.body.setAttribute('data-theme', theme)
    for (let handler of themeChangeHandlers) {
      handler(theme)
    }
  }

  const darkSwitch = $('#darkSwitch')
  
  darkSwitch.on('change', function() {
    setTheme(darkSwitch.prop('checked') ? 'dark' : 'light')
  })
  
  themeChangeHandlers.push(theme => darkSwitch.prop('checked', theme === 'dark'))
})
