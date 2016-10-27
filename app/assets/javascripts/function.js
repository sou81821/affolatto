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


// // 現在地の取得
// function getCenter(){
// if(navigator.geolocation) {
//   navigator.geolocation.getCurrentPosition(
//     function(position){
//       var result =  new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
//       console.log(result);
//       return result;
//     },
//
//     function(error){
//       var result =  new google.maps.LatLng(34.6945, 135.195);
//       console.log(result);
//       return result;
//     },
//
//     {
//       "enableHighAccuracy": false,
//       "timeout": 8000,
//       "maximumAge": 5000
//     }
//   );
// }
// }
