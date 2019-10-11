$(() => {
 bindClickOnHandlers()
 })

 const bindClickOnHandlers = () => {
   $('.all_recipes').on('click', r => {
     r.preventDefault()
     history.pushState(null, null, "/recipes")
     fetch(`/recipes.json`)
       .then(response => response.json())
       .then(recipe => {
         $('#app-container').html('')
           recipes.forEach(recipe => {
             let newRecipe = new Recipe(recipe)
             let recipeHtml = newRecipe.formatIndex()
              $('#app-container').append(recipeHtml)
           })
       })
   });
   $(document).on('click', ".show_link", function (e) {
     e.preventDefault()
     let id = $(this).attr('data-id')
     fetch(`/recipes/${id}.json`)
       .then(response => response.json())
       .then(recipe => {
         let newRecipe = new Recipe(recipe)
         let recipeHtml = newRecipe.formatShow()
   });
 };

   $("#new_recipe").on("create_recipe", function (e) {
     e.preventDefault()
     const values = $(this).serialize()
     $.recipe("/recipes", values).done(function (data) {
           $("#app-container").html('')
             const newRecipe = new Recipe(data)
             const htmlToAdd = newRecipe.formatShow()
           $("app-container").html('htmlToAdd')
       })
   })

 function Recipe(recipe) {
   this.id = recipe.id;
   this.title = recipe.title;
   this.instructions = recipe.instructions;
   this.culinary_artist = recipe.culinary_artist

 }

 Recipe.prototype.formatIndex = function (){
   let recipeHtml = `
     <a href="/recipes/${this.title}" data-id = "${this.id}" class="show_link" by <h6>${this.culinary_artist_id}</h6>
   `
   return recipeHtml
 }

 Recipe.prototype.formatShow = function (){
   let recipeHtml = `
       <h3>${this.title} </h3>
       <h4>${this.instructions}</h4>
     `
   return recipeHtml
