# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "axios", to: "https://cdn.jsdelivr.net/npm/axios@1.7.9/+esm"
pin "lodash-es", to: "https://cdn.jsdelivr.net/npm/lodash-es@4.17.21/+esm"
