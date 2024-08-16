import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="rotate"
export default class extends Controller {
  static targets = ["arrow", "list"];

  connect() {
    console.log("Rotate controller connected");

    // Sets initial state of list to closed
    this.listTargets.forEach((list) => {
      list.style.maxHeight = "0px";
      list.style.overflow = "hidden";
      list.style.transition = "max-height 0.5s ease";
    });
  }

  fire() {
    console.log("Firing");
    this.rotate_arrow();
    this.toggle_list()
  }

  rotate_arrow() {
    const arrow = this.arrowTarget;
    // Checks if arrow has been rotated yet or not
    const isRotated = arrow.style.transform === "rotate(90deg)";
    // Sets rotation speed
    arrow.style.transition = "transform 0.5s ease";
    // conditionally rotates
    if (isRotated) {
      arrow.style.transform = "rotate(0deg)";
    } else {
      arrow.style.transform = "rotate(90deg)";
    }
  }

  toggle_list() {
    console.log("Toggling list");
    const list = this.listTarget

    if (list.style.maxHeight && list.style.maxHeight !== "0px") {
      list.style.maxHeight = "0px"
    } else {
      list.style.maxHeight = (list.scrollHeight + 512) + "px"
      //list.style.maxHeight = list.scrollHeight + "px"
    }
  }
}
