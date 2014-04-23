app.models.Posts = Backbone.Model.extend
  urlRoot : '/posts'
  defaults :
    name : ''
    num_pages : 0
    user_id : 0
    user_name : ''
    img_url : ''
    youtube_url : ''