// ヘッダーのトグルボタンの開閉
$(function(){
  $("#toggle").click(function(){
    $("#menu").slideToggle();
    return false;
  });
  $(window).resize(function(){
    var win = $(window).width();
    var p = 480;
    if(win > p){
      $("#menu").show();
    } else {
      $("#menu").hide();
    }
  });
});


function successFunc(position) {
  console.log( position.coords.latitude );
  console.log( position.coords.longitude );
}

function errorFunc(error) {
  console.log( error.code );
}

var optionObj = {
  "enableHighAccuracy": false,
  "timeout": 8000,
  "maximumAge": 5000
};
