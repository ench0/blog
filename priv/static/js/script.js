var $menu = $('#menu');
$(document).scroll(function() {
  // console.log($(this).scrollTop())
    $menu.css({"box-shadow": $(this).scrollTop() > 0? "0 0 10px rgba(0, 0, 0, .5)":"none"});
    // $menu.css({"background": $(this).scrollTop() > 0? "rgba(153, 0, 51, .95)":"none"});
    // $menu.css({"background": $(this).scrollTop() > 20? "#903":"transparent"});
    // $menu.css({"opacity": $(this).scrollTop() > 20? "0":"1"});
    // $menu.css({display: $(this).scrollTop() > 50? "block":"none"});
});