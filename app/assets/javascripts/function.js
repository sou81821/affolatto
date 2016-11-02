// サイドメニュー開閉処理
$(function (){
  var $body = $('body');
  $('#toggle').on('click', function () {
    $('.side-menu').show();
    $body.toggleClass('side-open');
  });
  $('#js__overlay').on('click', function () {
    $body.toggleClass('side-open');
  });
  $('.wrapper').on('transitionend', function(){
    if(!($body.hasClass('side-open'))){
      $('.side-menu').hide();
    }
  });
});
