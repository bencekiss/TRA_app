$(document).on("turbolinks:load",function(){
  $('.messages').addClass('off')
  $('.trigger').on('click', function(eventObject){
    // eventObject.stopPropagation();
    $(this).parent().find('.messages').fadeToggle('slow')
  });
});
