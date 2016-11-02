// サイドメニュー開閉処理
// $(function () {
//   var $body = $('body');
//   $('#toggle').on('click', function () {
//     // $('.side-menu').show()
//     $body.toggleClass('side-open');
//   });
//
//   $('#js__overlay').on('click', function () {
//     $body.toggleClass('side-open');
//     // $('.side-menu').hide()
//   });
// });

// $(function (){
//   var $body = $('body');
//   $('#toggle').on('click', function () {
//     $('.side-menu').show();
//     $body.toggleClass('side-open');
//   });
//   $('#js__overlay').on('click', function () {
//     $('.side-open.wrapper').on('transitionend', function(){
//         $('.side-menu').hide();
//     });
//     $body.toggleClass('side-open');
//   });
// });


$(function (){
  var $body = $('body');
  $('#toggle').on('click', function () {
    $('.side-menu').show();
    $body.toggleClass('side-open');
  });
  $('#js__overlay').on('click', function () {
    $body.toggleClass('side-open');
  });
  if($body.hasClass('.side-open')){
    $('.wrapper').on('transitionend', function(){
      $('.side-menu').hide();
    });
  }　
});
