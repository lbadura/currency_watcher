cw = {}

cw.killActiveMenuClick = function ( ev ) {
  ev.stopPropagation();
  ev.preventDefault();
  return false;
}

$(document).ready(function() {
  $('ul a.active').live('click', cw.killActiveMenuClick);
});