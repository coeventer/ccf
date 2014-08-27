$(document).ready(function(){
  $('#project_description').wysihtml5();
  $("#project_title").keyup(function(e){
    if($("#project_title").val().length > 0)
      $("#project_details").fadeIn();
    else
      $("#project_details").fadeOut();
  });
});