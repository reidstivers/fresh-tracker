import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "submit"];

  connect() {
    console.log("Search connected")
  }
  fire(event) {
    console.log("search!");
    event.preventDefault();
  }
}




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
