#= require jquery
#= require jquery_ujs
#= require underscore
#= require bootstrap
#= require backbone
#= require auth
#= require config
#= require realtime
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./templates
#= require_tree ./views
#= require_tree ./routers
#= require app

$(document).ready ->
  if window.posts is undefined
    $('.action-view').hide()
