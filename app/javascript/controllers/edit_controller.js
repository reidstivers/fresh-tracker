import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit"
export default class extends Controller {
  static targets = ["nameContent", "nameInput", "amountContent", "amountInput", "unitContent", "unitInput", "expirationContent", "expirationInput", "errorMessages"]

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
      case "expiration_date":
        this.toggleEditing(this.expirationContentTarget, this.expirationInputTarget, field);
        break;
    }
  }

  toggleEditing(contentTarget, inputTarget, field) {
    contentTarget.classList.add("d-none");
    inputTarget.classList.remove("d-none");
    inputTarget.focus();

    if (field === "expiration_date") {

      let fp;

      fp = flatpickr(inputTarget, {
        onClose: () => {
          console.log("Flatpickr closed for", inputTarget);
          this.update(contentTarget, inputTarget, field);
          fp.destroy();
          document.removeEventListener('mousedown', this.handleClickOutside);
        },
        onReady: () => {
          this.handleClickOutside = (event) => {
            const calendar = document.querySelector('.flatpickr-calendar');
            console.log("Calendar:", calendar);
            if (!inputTarget.contains(event.target) && (!calendar || !calendar.contains(event.target))) {
              console.log("Clicked outside input field");
              document.removeEventListener('mousedown', this.handleClickOutside);
              fp.close();
            }
          };
          // Gives flatpickr time to load, necessary for mobile
          setTimeout(() => {
            document.addEventListener('mousedown', this.handleClickOutside);
          }, 1000);
        },
      });
      // Prevents backspace from clearing the entire input
      inputTarget.addEventListener("keydown", (event) => {
        if (event.key === "Backspace" && inputTarget.value.length === 0) {
          event.preventDefault();
          fp.destroy();
          this.toggleEditing(contentTarget, inputTarget, field);
        }
      });
    } else {
      this.moveCursorToEnd(inputTarget);
      inputTarget.addEventListener("blur", () => {
        console.log("Blur event triggered for", inputTarget);
        this.update(contentTarget, inputTarget, field);
      });
        // Binds data when user presses enter
      inputTarget.addEventListener("keydown", (event) => {
        if (event.key === "Enter") {
          console.log("Enter key pressed for", inputTarget);
          this.update(contentTarget, inputTarget, field);
        }
      });
    }
  }

  // Moves cursor to the end of the input field to improve UX
  moveCursorToEnd(element) {
    // Stores the original value, clears it, and adds it back in, putting cursor at the end
    const value = element.value;
    element.value = "";
    element.value = value;
  }

  update(contentTarget, inputTarget, field) {
    console.log("Update called for", field);
    // saves value in the input field
    const newValue = inputTarget.value.trim();
    // resets the content to match the input
    contentTarget.textContent = newValue;
    // Sends the new value to the DB
    return this.save(field, newValue)
      .then(response => {
        console.log("Response:", response,);
        if (response.status === "success") {
          contentTarget.textContent = response.ingredient[field];
          inputTarget.classList.add("d-none");
          contentTarget.classList.remove("d-none");
          this.clearErrorMessages(inputTarget);
        } else {
          this.showErrorMessages(response.errors, inputTarget);
        }
      })
      .catch(error => {
        console.error("Error:", error);
        this.showErrorMessages(["An error occurred. Please try again."], inputTarget);
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

  showErrorMessages(errors, inputTarget) {
    this.errorMessagesTarget.style.display = 'block';
    this.errorMessagesTarget.innerHTML = errors.map(error => `<div>${error}</div>`).join('');
    inputTarget.style.border = '1px solid red';
    inputTarget.style.boxShadow = '0 0 0 0.2rem rgba(255, 0, 0, 0.25)';
  }

  clearErrorMessages(inputTarget) {
    console.log("clearing:", inputTarget);
    this.errorMessagesTarget.style.display = 'none';
    this.errorMessagesTarget.innerHTML = '';
    inputTarget.style.border = 'none';
    inputTarget.style.boxShadow = '0 0 0 3px rgba(0, 123, 255, 0.5)';
  }
}
