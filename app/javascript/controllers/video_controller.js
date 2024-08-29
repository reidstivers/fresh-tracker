import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="video"
export default class extends Controller {
  connect() {
    console.log(this.element);
    const video = this.element;

    // Ensure the video is loaded before playing
    video.addEventListener('canplay', () => {
      console.log("canplay event fired");
      video.play();
    });
  }
}
