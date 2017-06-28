
function px2int(px) {
  var tmp = px.substring(0, px.length - 2)
  tmp = parseInt(tmp)
  return tmp
}

function doResize() {
  // resize location image
  $("#locationImage").css('height', px2int($("#locationImage").css('width')) * 750 / 1333);

  // resize sword
  $(".i-item").each(function(itemIdx) {
    var item = $(".i-item")[itemIdx];
    $(item).css('width', $(item).height());
  });

  // fix top of inventoryCollapse
  var newTop = ($("#worldMap").height() - 30) + "px";
  $("#inventoryCollapse").css('top', newTop);
}

(function($) {
  $.dragScroll = function(options) {
    var settings = $.extend({
      scrollVertical: true,
      scrollHorizontal: true,
      cursor: null
    }, options);

    var clicked = false;
    var clickY;
    var clickX;

    var getCursor = function() {
      if (settings.cursor) return settings.cursor;
      if (settings.scrollVertical && settings.scrollHorizontal) return 'move';
      if (settings.scrollVertical) return 'row-resize';
      if (settings.scrollHorizontal) return 'col-resize';
    }

    var updateScrollPos = function(e, el) {
      var $el = $(el);

      $('html').css('cursor', getCursor());

      // settings.scrollVertical && $el.scrollTop($el.scrollTop() + (clickY - e.pageY));
      // settings.scrollHorizontal && $el.scrollLeft($el.scrollLeft() + (clickX - e.pageX));

      var setTop = px2int($el.css('top')) + (clickY - e.pageY);
      var maxTop = $el.height() - $("#worldMap").height();

      var setLeft = $el.css('left');
      setLeft = setLeft.substring(0, setLeft.length - 2);
      setLeft = parseInt(setLeft) + (clickX - e.pageX);
      var maxLeft = $el.width() - $("#worldMap").width();

      if (settings.scrollVertical && setTop < 0 && setTop > -maxTop) {
        $el.css('top', setTop);
      }
      if (settings.scrollHorizontal && setLeft < 0 && setLeft > -maxLeft) {
        $el.css('left', setLeft);
      }
    }

    $(document).on({
      'mousemove': function(e) {
        clicked && updateScrollPos(e, '#worldMap .container');
      },
      'mousedown': function(e) {
        if (e.pageY < $("#worldMap").height() &&
            e.pageX < $("#worldMap").width()
        ) {
          clicked = true;
        }
        clickY = e.pageY;
        clickX = e.pageX;
      },
      'mouseup': function() {
        clicked = false;
        $('html').css('cursor', 'auto');
      }
    });
  }
}(jQuery))

$.dragScroll();

$(document).ready(function () {
  doResize();
});

window.onresize = function () { doResize() };

var worldMapCollapsed = false;
function worldMapCollapse () {
  if (worldMapCollapsed) {
    $("#worldMap").css('width', '33%');
    $("#worldMapCollapse").css('left', '33%');
    $("#locationMap").css('left', '33%');
    $("#locationMap").css('width', '67%');
    worldMapCollapsed = false;
  } else {
    $("#worldMap").css('width', '2%');
    $("#worldMapCollapse").css('left', '2%');
    $("#locationMap").css('left', '2%');
    $("#locationMap").css('width', '98%');
    worldMapCollapsed = true;
  }
  doResize();
};
