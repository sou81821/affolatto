$(function(){
  $("#toggle").click(function(){
    $("#menu").slideToggle();
    console.log("a");
    return false;
  });
  $(window).resize(function(){
    var win = $(window).width();
    var p = 480;
    console.log("b");
    if(win > p){
      $("#menu").show();
    } else {
      $("#menu").hide();
    }
  });
});

$("#toggle").on("click", function(){
  console.log("hoge");
})
