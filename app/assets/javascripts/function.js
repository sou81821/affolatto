// サイドメニュー開閉処理
$(function () {
  var $body = $('body');
  $('#toggle').on('click', function () {
    $body.toggleClass('side-open');
    $('#js__overlay').on('click', function () {
      $body.removeClass('side-open');
    });
  });
});
