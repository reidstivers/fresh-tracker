import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggler"
export default class extends Controller {
  static targets = ["form", "api_form"]

  connect() {
    console.log("Toggler Connected!")
  }

  toggle(event) {
    const targetName = event.currentTarget.dataset.targetName
    const targetElement = this[`${targetName}Target`]
    console.log(`Toggling ${targetName}...`)
    if (targetElement) {
      targetElement.classList.toggle("d-none");
    } else {
      console.error(`Target element ${targetName} not found!`)
    }
  }
}
