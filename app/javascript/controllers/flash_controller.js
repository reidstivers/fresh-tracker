import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["flash"]

  connect() {
    setTimeout(() => {
      this.close()
    }, 2000)
  }

  close() {
    this.flashTarget.classList.add('fade-out');
    setTimeout(() => {
      this.flashTarget.remove();
    }, 500);
  }
}
