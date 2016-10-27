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


// 現在地に合わせた地図表示
function successFunc(position) {
  console.log( position.coords.latitude );
  console.log( position.coords.longitude );

  handler = Gmaps.build('Google');
  handler.buildMap(
    {
      provider: {
        zoom: 16,
        center: new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      },
      internal: {id: 'map'}
    },
    function(){
      markers = handler.addMarkers(<%=raw @hash.to_json %>);
      handler.bounds.extendWith(markers);
      // handler.fitMapToBounds();
    }
  );
}

// 現在地の取得に失敗したとき，デフォルトの地図表示
function errorFunc(error) {
  console.log( error.code );

  handler = Gmaps.build('Google');
  handler.buildMap(
    {
      provider: {
        zoom: 16,
        center: new google.maps.LatLng(34.6945, 135.195)
      },
      internal: {id: 'map'}
    },
    function(){
      markers = handler.addMarkers(<%=raw @hash.to_json %>);
      handler.bounds.extendWith(markers);
      // handler.fitMapToBounds();
    }
  );
}

var optionObj = {
  "enableHighAccuracy": false,
  "timeout": 8000,
  "maximumAge": 5000
};
