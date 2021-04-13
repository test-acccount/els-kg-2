import tippy from 'tippy.js/dist/tippy.js'

document.addEventListener('turbolinks:load', function() {
  tippy('#tippy-navbar', {
    html: '#tippy-navbar-template',
    interactive: true,
    trigger: 'click',
    theme: 'light',
    size: 'compact',
    performance: true,
    arrow: true,
    arrowType: 'sharp',
    duration: 300,
    animation: 'fade'
  })

  const tippy_navbar_user = document.querySelector("#tippy-navbar-user")
  if (tippy_navbar_user) {
    tippy('#tippy-navbar-user', {
      html: '#tippy-navbar-user-template',
      interactive: true,
      trigger: 'click',
      theme: 'light',
      size: 'compact',
      performance: true,
      arrow: true,
      arrowType: 'sharp',
      duration: 300,
      animation: 'fade'
    })
  }

  const tippy_navbar_admin = document.querySelector("#tippy-navbar-admin")
  if (tippy_navbar_admin) {
    tippy('#tippy-navbar-admin', {
      html: '#tippy-navbar-admin-template',
      interactive: true,
      trigger: 'click',
      theme: 'light',
      size: 'compact',
      performance: true,
      arrow: true,
      arrowType: 'sharp',
      duration: 300,
      animation: 'fade'
    })
  }
})
