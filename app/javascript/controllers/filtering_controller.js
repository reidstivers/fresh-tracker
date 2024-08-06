import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filtering"
export default class extends Controller {
  static targets = ["button"];

  connect() {
    console.log("Filter connected!");
  }

  showAll() {
    console.log("Showing all items");
    const sections = document.querySelectorAll(".category-section");
    sections.forEach(section => section.classList.remove("d-none"));
  }

  fire(event) {
    const button = event.currentTarget;
    const category = button.dataset.category;
    this.filterCategories(category);
  }

  filterCategories(category) {
    console.log(`Filtering items by category: ${category}`);
    const sections = document.querySelectorAll(".category-section");

    sections.forEach(section => {
      if (section.dataset.category === category) {
        section.classList.remove("d-none");
      } else {
        section.classList.add("d-none");
      }
    });
  }
}
