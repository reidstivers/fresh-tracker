import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="jiggle"
export default class extends Controller {
  static targets = ["icon"];

  connect() {
    this.jiggleIcons();
    this.startJiggleInterval();
  }

  jiggleIcons() {
    this.iconTargets.forEach(icon => {
      icon.classList.add("jiggle")
      setTimeout(() => {
          icon.classList.remove("jiggle")
      }, 1000);
    });
  }

  startJiggleInterval() {
    setInterval(() => {
      this.jiggleIcons();
    }, 5000);
  }
}
