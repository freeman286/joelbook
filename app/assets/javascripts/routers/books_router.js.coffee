app.routers.Books = Backbone.Router.extend
  initialize : ->
    @books = new app.collections.Books window.books
    @indexView = new app.views.books.Index
      collection : @books

    @formView = new app.views.books.Form()

    $('body').append @indexView.render()
    $('body').append @formView.render()

  routes :
    "books/" : "index"
    "books/new" : "new"
    "books/:id" : "show"
    "books/:id/edit" : "edit"

  index : () ->
    $('.action-view').show()
    @indexView.$el.show()

  edit : (id) ->
    $('.action-view').show()
    @formView.model = @books.get id
    @formView.render()
    @formView.$el.show()      

  new : () ->
    $('.action-view').show()
    @formView.clear()
    @formView.$el.show()     