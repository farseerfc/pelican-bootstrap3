var other_blog = (function(){
  function escapeHtml(str) {
    return $('<div/>').text(str).html();
  }
  function render(data, t){
    var target = $(data).find('.btn-lg > h2');
    var i = 0;
    var fragment = '<div class="list-group" id="other_blog">';
    for(i = 0; i < target.length; i++ ){
        fragment += '<div class="list-group-item">'
        fragment += '<a class="btn btn-default withripple" href="' + target[i].parentNode.href + '" target="_blank">'+target[i].innerText+'</a>'
        fragment += '</div>'
    }
    fragment += '</div>';
    $(t).html(fragment);
  }
  return {
    showRepos: function(options){
      $.ajax({
          url: options.url
        , dataType: 'html'
        , error: function (err) { $(options.target + ' li.loading').addClass('error').text("Error loading feed"); }
        , success: function(data) {
          render(data, options.target);
        }
      });
    }
  };
})();
