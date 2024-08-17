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
        console.log(data)
        console.log(this.resultsTarget)
        this.resultsTarget.innerHTML = data
      })
}
}
    // const searchInput = event.target.value.toLowerCase();
    //   this.submit
    // this.ingredientCardTargets.forEach((ingredientCard) => {
    //   const itemName = ingredientCard.querySelector(".item-name").textContent.toLowerCase();
    // });
    // ingredientList(ingredient) {
    //   this.resultsTarget.innerHTML = "testing"
      // const ingredientCard =
      // <% @categories.each do |category| %>
      // <% category_ingredients = @ingredients.select { |ingredient| ingredient.category == category } %>
      // <% if category_ingredients.any? %>
      //   <div data-category="<%= category.name %>" class="category-section">
      //     <%= render partial: "category", locals: { category: category, ingredients: @ingredients } %></div>

      //     this.resultsTarget.insertAdjacentHTML("beforeend", ingredientCard)





// const searchMovies = (event) => {
//   event.preventDefault();
//   const name = document.getElementById("ingredient-name").value;
// }

// const appendIngredientsToDom = (ingredients) => {
//   console.log(ingredients)
//   // const ingredientsContainer = document.getElementById("movie-cards");
//   ingredientsContainer.innerHTML = ""; // Clear the previous results if any
//   ingredients.forEach((movie) => {
//     cardHTML = createMovieCard(movie);
//     moviesContainer.insertAdjacentHTML('beforeend', cardHTML);
//   });
// }

// const createMovieCard = (movie) => {
//   return `
//     <div class="col-lg-3 col-md-4 col-sm-6 col-12">
//       <div class="card mb-2">
//         <img src="${movie.Poster}" class="card-img-top" alt="${movie.Title}">
//         <div class="card-body">
//           <span class="badge bg-primary mb-2">${movie.Year}</span>
//           <h5 class="card-title">${movie.Title}</h5>
//         </div>
//       </div>
//     </div>
//   `
// }

// const form = document.getElementById("search-ingredients");
// form.addEventListener("submit", searchIngredients)
