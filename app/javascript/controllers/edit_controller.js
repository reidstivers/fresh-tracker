import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit"
export default class extends Controller {
  static targets = ["nameContent", "nameInput", "amountContent", "amountInput", "unitContent", "unitInput"]

  connect() {
    console.log("Edit connected");
  }

  edit(event) {
    event.stopPropagation();
    console.log("Edit clicked");
    // Retrieves field called on the event
    const field = event.currentTarget.getAttribute("data-field");
    switch(field) {
      case "name":
        this.toggleEditing(this.nameContentTarget, this.nameInputTarget, field);
        break;
      case "amount":
        this.toggleEditing(this.amountContentTarget, this.amountInputTarget, field);
        break;
      case "unit":
        this.toggleEditing(this.unitContentTarget, this.unitInputTarget, field);
        break;
    }
  }

  toggleEditing(contentTarget, inputTarget, field) {
    contentTarget.classList.add("d-none");
    inputTarget.classList.remove("d-none");
    inputTarget.focus();
    this.moveCursorToEnd(inputTarget);
    // Binds data when user clicks outside of the input field
    inputTarget.addEventListener("blur", () => this.update(contentTarget, inputTarget, field));
    // Binds data when user presses enter
    inputTarget.addEventListener("keydown", (event) => {
      if (event.key === "Enter") {
        this.update(contentTarget, inputTarget, field);
      }
    });
  }

  // Moves cursor to the end of the input field to improve UX
  moveCursorToEnd(element) {
    // Stores the original value, clears it, and adds it back in, putting cursor at the end
    const value = element.value;
    element.value = "";
    element.value = value;
  }

  update(contentTarget, inputTarget, field) {
    // saves value in the input field
    const newValue = inputTarget.value.trim();
    // resets the content to match the input
    contentTarget.textContent = newValue;
    // Sends the new value to the DB
    return this.save(field, newValue)
      .then(response => {
        if (response.status === "success") {
          contentTarget.textContent = response.ingredient[field];
          inputTarget.classList.add("d-none");
          contentTarget.classList.remove("d-none");
          this.clearErrorMessages();
        } else {
          this.showErrorMessages(response.errors);
        }
      })
      .catch(error => {
        console.error("Error:", error);
        this.showErrorMessages(["An error occurred. Please try again."]);
      });
  }

  save(field, newValue) {
    // Fetches the URL from the form (must be a variable to retrieve ingredient id)
    const url = this.element.getAttribute("data-url");
    console.log(url);
    // Retrieves the CSRF token from the meta tag (needs this to clear Rails inbuilt security)
    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
    // Sends the new value to the DB
    return fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({ ingredient: { [field]: newValue}})
    })
    .then(response => response.json())
    .catch(error => {
      console.error("Error:", error);
      return { status: "error", errors: [error.message] };
    });
  }

  showErrorMessages(errors) {
    const errorContainer = document.getElementById('error-messages');
    errorContainer.style.display = 'block';
    errorContainer.innerHTML = errors.join('<br>');
  }

  clearErrorMessages() {
    const errorContainer = document.getElementById('error-messages');
    errorContainer.style.display = 'none';
    errorContainer.innerHTML = '';
  }
}
