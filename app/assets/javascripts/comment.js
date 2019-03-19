$(function(){
  function buildHTML(comment){
    var html = `
                <ul>
                  <li class= 'clearfix'>
                      <a class="message-user"></a>
                    <div class='message-user__name'>
                      <a>${comment.user_name}</a>
                    </div>
                    <div class='message-body'>
                      <div class='message-body__text'>
                      ${comment.text}
                        <div class='message-body__text_delete'>
                        </div>
                      </div>
                    </div>
                  </li>
                </ul>
               `
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var href = window.location.href + '/comments'
    $.ajax({
      url: href,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.item-message__content').append(html)
      $('.textbox').val('')
    })
    .fail(function(){
      alert('error');
    })
  })
});
