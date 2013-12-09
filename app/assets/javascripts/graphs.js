// Grab the user id from rails and load graphs#new
$(function() {
  var user_id = $('.user_info').data('user-id');
  var route = ['/users', user_id, 'graphs', 'new'].join('/');
  $("#create_new_graph").load(route);
})