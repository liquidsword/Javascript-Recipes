

const bindClickOnHandlers = () => {
   $('.all_recipes').on('click', r => {
       r.preventDefault()
       history.pushState(null, null, "recipes")
       fetch(`/recipes`)
         .then(response => response.json())
         .then(recipes => {
             $('#app-container').html('')
             recipes.forEach(recipe => {
                 let newRecipe = new Recipe(recipe)
                 let recipeHtml = newRecipe.formatIndex()
                 $('#app-container').append(recipeHtml)
             })
         })
    })

    $('#sort').on('click', s => {
      s.preventDefault()
      fetch(`/recipes`)
        .then(response => response.json())
        .then(recipes => {
          $('#app-container').html('')
          recipes.sort(function(a, b) {
              var titleA = a.title.toUpperCase(); // ignore upper and lowercase
              var titleB = b.title.toUpperCase(); // ignore upper and lowercase
              if (titleA < titleB) {
                return -1;
              }
              if (titleA > titleB) {
                return 1;
              }
              return 0;
            });
          recipes.forEach(recipe => {
              let newRecipe = new Recipe(recipe)
              let recipeHtml = newRecipe.formatIndex()
              $('#app-container').append(recipeHtml)
            })
        })
    })

    $('#filter').on('click', f => {
      f.preventDefault()
      fetch(`/recipes`)
            .then(response => response.json())
            .then(recipes => {
                $('#app-container').html('')
                  let filteredRecipes = recipes.filter(recipe => recipe.title === "Check again");
                filteredRecipes.forEach(recipe => {
                  let newRecipe = new Recipe(recipe)
                  let recipeHtml = newRecipe.formatIndex()
                  $('#app-container').append(recipeHtml)
                })
              })
        })

    $(document).on('click', ".show_link", function (e) {
      e.preventDefault()
      $('#app-container').html('')
      let id = $(this).attr('data-id')
      fetch(`/recipes/${id}.json`)
        .then(response => response.json())
        .then(recipe => {
          let newRecipe = new Recipe(recipe)
          let recipeHtml = newRecipe.formatShow()
          $('#app-container').append(recipeHtml)
    });
  });


    $("#new_recipe").on("submit", function (e) {
      e.preventDefault()
      const values = $(this).serialize()
      $.post("/recipes", values).done(function(data) {
        $('#app-container').html('')
            const newRecipe = new Recipe(data)
            const htmlToAdd = newRecipe.formatShow()
          $('#app-container').html(htmlToAdd)
      })
    })
}

$(() => {
  bindClickOnHandlers()
})

   function Recipe(recipe) {
     this.id = recipe.id
     this.title = recipe.title
     this.instructions = recipe.instructions
     this.culinary_artist_id = recipe.culinary_artist_id
     this.ingredients = recipe.ingredients
     }


   Recipe.prototype.formatIndex = function (){
     let recipeHtml = `
          <a href="/recipes/${this.id}" data-id="${this.id}"
       class="show_link"><h1>${this.title}</h1> by <h6>${this.culinary_artist_id}</h6>
     `
     return recipeHtml
   }

   Recipe.prototype.formatShow = function (){
     let ingredientList = ""
          this.ingredients.forEach(ingredient => ingredientList += `<li>${ingredient.name}</li>`)
     let recipeHtml =`
            <h3>${this.title} </h3>
            <h4>${this.instructions}</h4>
            <h4>Ingredients: </h4>
              <ul>
                   ${ingredientList}
              </ul>
              `
     return recipeHtml
   }
