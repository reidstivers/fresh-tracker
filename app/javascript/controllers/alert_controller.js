import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert"
export default class extends Controller {
  static targets = [ "icon", "message", "container" ]

  connect() {
    console.log("Alert controller connected")

    const computedStyles = window.getComputedStyle(this.containerTarget);

    this.originalWidth = computedStyles.width;
    this.originalHeight = computedStyles.height;
    this.originalBackgroundColor = computedStyles.backgroundColor;
    this.originalBoxShadow = computedStyles.boxShadow;

    const messageComputedStyles = window.getComputedStyle(this.messageTarget);

    this.originalMessageMarginLeft = messageComputedStyles.marginLeft;
    this.originalMessageOpacity = messageComputedStyles.opacity;

    // Hides alert message after 5 seconds
    setTimeout(() => {
      this.shrinkMessage()
    }, 5000) // 5 seconds delay
  }

  shrinkMessage() {
    this.messageTarget.style.transition = "margin-left 2s ease, opacity 1s ease";
    this.messageTarget.style.marginLeft = "-100%";
    this.messageTarget.style.opacity = "0";

    // Checks the inital width to prevent sudeen collapse
    const intialWidth = this.containerTarget.offsetWidth + "px";
    const initialHeight = this.containerTarget.offsetHeight + "px";
    this.containerTarget.style.width = intialWidth;
    this.containerTarget.style.height = initialHeight;

    setTimeout(() => {
    this.containerTarget.style.transition = "width 2s, height 2s, background-color 2s, box-shadow 2s";
    this.containerTarget.style.width = "0px";
    this.containerTarget.style.height = "0px";
    this.containerTarget.style.backgroundColor = "transparent";
    this.containerTarget.style.boxShadow = "none";
    }, 100); // Split second delay

    this.iconTarget.style.transition = "transform 2s";
    this.iconTarget.style.transform = "scale(1.2)";

    setTimeout(() => {
      this.startRotation();
    }, 50);
  }

  startRotation() {
    this.iconTarget.style.animation = "pulseRotate 3s infinite";
  }

  reopenMessage() {
    this.iconTarget.style.animation = "none";
    this.iconTarget.style.transform = "scale(1)";

    // Expand container back to original
    this.containerTarget.style.transition = "width 2s, height 2, background-color 2s, box-shadow 2s";
    this.containerTarget.style.width = this.originalWidth;
    this.containerTarget.style.height = this.originalHeight;
    this.containerTarget.style.boxShadow = this.originalBoxShadow;
    this.containerTarget.style.backgroundColor = this.originalBackgroundColor;

    setTimeout(() => {
      this.messageTarget.style.transition = "margin-left 2s ease, opacity 2s ease";
      this.messageTarget.style.marginLeft = this.originalMessageMarginLeft; // Restore original margin
      this.messageTarget.style.opacity = this.originalMessageOpacity; // Restore original opacity
    }, 200);

    setTimeout(() => {
      this.shrinkMessage()
    }, 10000)
  }
}
