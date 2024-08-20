import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit"
export default class extends Controller {
  static targets = ["content", "input"];

  connect() {
    console.log("Edit connected");
  }

  edit() {
    this.contentTarget.classList.add("d-none");
    this.inputTarget.classList.remove("d-none");
    this.inputTarget.focus();
    // Binds data when user clicks outside of the input field
    this.inputTarget.addEventListener("blur", this.update.bind(this));
  }

  update() {
    // saves value in the input field
    const newValue = this.inputTarget.value;
    // resets the content to match the input
    this.contentTarget.textContent = newValue;
    // Sends the new value to the DB
    this.save(newValue);
    // Rehides the input field
    this.inputTarget.classList.add("d-none");
    this.contentTarget.classList.remove("d-none");
  }

  save(newValue) {
    // Fetches the URL from the form
    const url = this.element.getAttribute("data-url");
    console.log(url);
    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
    // stores field to use on any part of the card
    // Sends the new value to the DB
    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({ ingredient: { amount: newValue}})
    })
    .then(response => response.json())
    .catch(error => console.error("Error:", error))
  };
}
