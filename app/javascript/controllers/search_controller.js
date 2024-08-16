import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "submit", "results"];

  connect() {
    this.inputTarget.addEventListener('keyup', (event) => {
      this.fire(event);
    });
  }

  fire(event) {
    console.log("search!");
    event.preventDefault();
    const query = this.inputTarget.value;
    const url = new URL(this.inputTarget.closest('form').action);
    url.searchParams.set('query', query);

    fetch(url, {
      headers: { 'Accept': 'text/vnd.turbo-stream.html' }
    })
    .then(response => response.text())
    .then(html => {
      document.getElementById('search-results').innerHTML = html;
    })
    .catch(error => console.error('Error:', error));
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
