// Grab the user id from rails and load graphs#new
$(function() {
  var user_id = $('.user_info').data('user-id');
  var route = ['/users', user_id, 'graphs', 'new'].join('/');
  $("#create_new_graph").load(route);
});

// Make force directed graph
$(function() {

  // Sets size
  var width = 960,
      height = 500;

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
  var force = d3.layout.force()
      .charge(-120)
      .linkDistance(30)
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
    .enter().append("circle")
      .attr("class", "node")
      .attr("r", 5)
      .style("fill", function(d) { return color(d.group); })
      .call(force.drag);

  node.append("title")
      .text(function(d) { return d.name; });

  force.on("tick", function() {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node.attr("cx", function(d) { return d.x; })
        .attr("cy", function(d) { return d.y; });
  });
});
