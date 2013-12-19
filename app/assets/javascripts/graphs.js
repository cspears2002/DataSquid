// Get these up and running on page load
var ready = function() {
  
  // Grab the user id from rails and load graphs#new and graphs#edit
  var user_id = $('.user_info').data('user-id');
  var graph_id = $('.graph_info').data('graph-id');
  var new_route = ['/users', user_id, 'graphs', 'new'].join('/');
  var edit_route = ['/users', user_id, 'graphs', graph_id, 'edit'].join('/');
  $("#create_new_graph").load(new_route);
  $("#edit_graph").load(edit_route);

  // Make graphs on page load
  make_graph();

  // Rebuilds graph with data from the checkboxes
  $("#rebuild_btn").click( function() {
    // Get valus from checkboxes
    checked_val = $( "input:checked" ).map(function () { 
      return $(this).val(); 
    });

    // Pull json from web page as a string
    json_str = $(".graph_json").attr("data-json");
    json_obj = jQuery.parseJSON(json_str);
    nodes = json_obj["nodes"];
    var nodes_array = []
    for (var i=0, len=nodes.length; i<len; i++) {
      var name = nodes[i]["name"];
      nodes_array.push(name);
    }
    console.log(nodes_array);

    var links_obj = {"links":[]};
    for (var i=0, len=checked_val.length; i<len; i++) {
      var source = checked_val[i].split(':')[0];
      var target = checked_val[i].split(':')[1];
      var source_index = nodes_array.indexof(source);
      var target_index = nodes_array.indexof(target);
      var link = { "source" : source_index,
                   "target" : target_index,
                   "value"  : 1 };
      links_obj["links"].push(link);
    }

    console.log(links_obj);
    
  });

  // Make force directed graph on button click
  $("#refresh_btn").click( function() {
    // Make sure fisheye is turned off
    $('#fisheye_btn').css('color', 'white');
    fisheye_on = false;
    make_graph();
  });

  // Turn on and off fisheye distortion
  $('#fisheye_btn').click( function() {
    var glyph_color = $(this).css('color');
    // original color is white
    orig_color = 'rgb(255, 255, 255)';

    if (glyph_color == orig_color) {
      $(this).css('color', 'orange');
      fisheye_on = true;
      make_graph();
    } else {
      $(this).css('color', orig_color);
      fisheye_on = false;
      make_graph();
    };
  });
};

// Force a turbolinks page load
$(document).ready(ready);
$(document).on('page:load', ready);


// Global variables
var svg, node, link; 
var fisheye_on = false;

function make_graph() {

  // Clear out the div first
  $("#display_graph svg:first").remove();

  // Sets size
  var width = 960,
      height = 500;

  // Maps groups to colors
  var color = d3.scale.category20();

  // Select the div and append a svg
  svg = d3.select("#display_graph").append("svg")
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

  link = svg.selectAll(".link")
      .data(json_links)
    .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", function(d) { return Math.sqrt(d.value) + 0.5; });

  var font_size_px = $('#font_size').val();
  node = svg.selectAll(".node")
      .data(json_nodes)
    .enter().append("g")
      .attr("class", "node")
      .style("font-size", font_size_px)
      .call(force.drag);

  var radius = $('#radius').val();
  node.append("circle")
      .attr("r", radius)
      .style("fill", function(d) { return color(d.group); });
      
  node.append("text")
      .attr("dx", 12)
      .attr("dy", ".35em")
      .text(function(d) { return d.name; });

  if (fisheye_on == false) {

    force.on("tick", function() {
      link.attr("x1", function(d) { return d.source.x; })
          .attr("y1", function(d) { return d.source.y; })
          .attr("x2", function(d) { return d.target.x; })
          .attr("y2", function(d) { return d.target.y; });
      node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
    });

  } else {

    var fisheye = d3.fisheye.circular()
      .radius(120)
      .distortion(2);

    svg.on("mousemove", function() {
      fisheye.focus(d3.mouse(this));

      node.each(function(d) { d.fisheye = fisheye(d); });

      node.selectAll("circle")
          .attr("cx", function(d) { return d.fisheye.x - d.x; })
          .attr("cy", function(d) { return d.fisheye.y - d.y; })
          .attr("r", function(d) { return d.fisheye.z * 4.5; });

      node.selectAll("text")
          .attr("dx", function(d) { return d.fisheye.x - d.x; })
          .attr("dy", function(d) { return d.fisheye.y - d.y; });
          
      link.attr("x1", function(d) { return d.source.fisheye.x; })
          .attr("y1", function(d) { return d.source.fisheye.y; })
          .attr("x2", function(d) { return d.target.fisheye.x; })
          .attr("y2", function(d) { return d.target.fisheye.y; });
    });
  };
};
