/*$(document).ready(function  () {

  $('form').click(function(){
    event.preventDefault();

    search_pattern = $('#search_text').val()

    $.ajax({
      type: "POST",
      url: '/search',
      data: {search_pattern:search_pattern}
    }).done(function(data){
      $('#comments-main').hide();
      html = ''
      JSON.parse(data).forEach(function(el){
        html = html + `<li class="list-group-item">${el.text}</li>`;
      });
      if (html.length == 0){
        html = 'Nothing was found with your query...'
      }
      $('#comments-search').append(`<ul class='list-group'>${html}</ul>`);
    })
  });
})

*/