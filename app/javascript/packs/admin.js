import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /.js$/)
application.load(definitionsFromContext(context))

import $ from 'jquery'

import 'tachyons/css/tachyons'
import 'style'

import 'devbridge-autocomplete'
import '../admin-autocomplete'

import 'trix/dist/trix.css'
import 'trix/dist/trix.js'

import 'flatpickr/dist/flatpickr.css'
import flatpickr from 'flatpickr'

document.addEventListener("turbolinks:load", function() {
  // Setup date-picker for updating date of the next shipment
  flatpickr("#shipment_next_date_date", {
    minDate: "today"
  });

  const first_name = document.getElementById("package_guest_attributes_first_name")
  const last_name  = document.getElementById("package_guest_attributes_last_name")
  if (first_name && last_name) {
    createAutocompleteWidget(first_name, "first_name")
    createAutocompleteWidget(last_name, "last_name")
  }
});

const createAutocompleteWidget = (el, param_name) => {
  $(el).autocomplete({
    lookup: function(name, done) {
      let request_data = {};
      request_data[param_name] = name;
      fetch('/admin/autocomplete_suggestions', {
        method: 'post',
        body: JSON.stringify(request_data),
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        credentials: 'same-origin'
      }).then(data => {
          if (!data.ok) { throw new Error(); }
          return data.json();
      }).then(data => {
          return {
            suggestions: $.map(data, function(dataItem) {
              return { value: dataItem, data: dataItem };
            })
          };
      }).then(data => {
          done(data);
      })
    },
    deferRequestBy: 50
  });
}
