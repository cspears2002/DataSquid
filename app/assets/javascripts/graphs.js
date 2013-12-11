// Grab the user id from rails and load graphs#new
var ready = function() {
  var user_id = $('.user_info').data('user-id');
  var route = ['/users', user_id, 'graphs', 'new'].join('/');
  $("#create_new_graph").load(route);
};

// Force a turbolinks page load
$(document).ready(ready);
$(document).on('page:load', ready);

// Make force directed graph
$(document).ready( function() {
  $("#refresh_btn").click(make_graph);
});

var make_graph = function() {

  // Clear out the div first
  $("#display_graph svg:first").remove();

  // Sets size
  var width = 960,
      height = 500;

  // Maps groups to colors
  var color = d3.scale.category20();

  // Select the div and append a svg
  var svg = d3.select("#display_graph").append("svg")
      .attr("width", width)
      .attr("height", height);

  // Pull json from graph
  var json_from_db = $('.graph_json').data('json');
  var json_nodes = json_from_db.nodes
  var json_links = json_from_db.links

  // Sets up the force directed graph
  var charge_val = $('#charge').val();
  var link_distance_val = $('#link_distance').val();
  var force = d3.layout.force()
      .charge(charge_val)
      .linkDistance(link_distance_val)
      .size([width, height])
      .nodes(json_nodes)
      .links(json_links)
      .start();

  var link = svg.selectAll(".link")
      .data(json_links)
    .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", function(d) { return Math.sqrt(d.value); });

  var node = svg.selectAll(".node")
      .data(json_nodes)
    .enter().append("g")
      .attr("class", "node")
      .call(force.drag);

  var radius = $('#radius').val();
  node.append("circle")
      .attr("r", radius)
      .style("fill", function(d) { return color(d.group); });
      
  node.append("text")
      .attr("dx", 12)
      .attr("dy", ".35em")
      .text(function(d) { return d.name; });

  force.on("tick", function() {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });
    node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
  });
};
