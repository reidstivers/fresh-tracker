// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"


// Below method allows me to create custom Turbo methods. We can call this anywhere in the app
// Just need to make sure that the user only needs to hit confirm or cancel
Turbo.setConfirmMethod((message, element) => {
  console.log(message, element)
  let dialog = document.getElementById("turbo-confirm")
  dialog.querySelector("p").textContent = message
  dialog.showModal()

  return new Promise((resolve, reject) => {
    dialog.addEventListener("close", () => {
      resolve(dialog.returnValue === "confirm")
    }, { once: true })
  })
})
