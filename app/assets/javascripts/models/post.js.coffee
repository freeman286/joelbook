app.models.Posts = Backbone.Model.extend
  urlRoot : '/posts'
  defaults :
    name : ''
    user_name : ''
    user_id : 0
    channel_id : 0
    user_img_url : ''
    img_url : ''
    youtube_url : ''