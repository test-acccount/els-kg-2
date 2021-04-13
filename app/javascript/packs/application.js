import Rails from "rails-ujs"
import Turbolinks from "turbolinks"
Rails.start()
Turbolinks.start()

import "vendor/cocoon.js"

import "tippy.js/dist/tippy.css"
import "tippy.js/dist/themes/light.css"
import "tippy.js"

// Turbolinks: remove alert between turbolinks visits
document.addEventListener("turbolinks:before-cache", function() {
  let alert = document.querySelector("div.js-alert")
  if (alert) {
    alert.remove()
  }
})
