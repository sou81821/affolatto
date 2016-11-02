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


$(function () {
  var $body = $('body');
  $('#toggle').on('click', function () {
    $('.side-menu').show()
    $body.toggleClass('side-open');
  });
  $('#js__overlay').on('click', function () {
      $body.removeClass('side-open');
  });
  $('.side-open').on('webkitAnimationEnd', function(){
        $('.side-menu').hide()
  });
});
