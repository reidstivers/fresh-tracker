import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "results", "form"];

  fire(event) {
    event.preventDefault();

    // Ensure inputTarget is defined
    // if (!this.hasFormTarget) {
    //   console.error("Input target not found.");
    //   return;
    // }
console.log(this.formTarget)
const query = this.inputTarget.value
const url = this.formTarget.action + "?query=" + query
console.log(url)
    fetch(url, {
      method: "GET",
      headers: { "Accept": "text/plain" },
      // body: new FormData(this.inputTarget)
    })
      .then(response => response.text())
      .then((data) => {
        console.log("got a result")
        // console.log(data)
        console.log(this.resultsTarget)
        this.resultsTarget.innerHTML = data
      })
}
}
