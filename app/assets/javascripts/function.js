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

var $body = $('body');
$('#toggle').on('click', function () {
  $('.side-menu').show()
  $body.toggleClass('side-open');
});
$('#js__overlay').on('click', function () {
    $body.removeClass('side-open');
});
$('.wrapper').on('transitionend', function(){
    $('.side-menu').hide()
});
