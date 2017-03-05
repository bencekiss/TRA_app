$(document).on("turbolinks:load",function(){
  $('.prime').on('click', function(){
    $('.secondary-caregiver').fadeOut();
    $('.caregivers').fadeIn();
    $('.patient').fadeOut();
  });
  $('.secondary').on('click', function(){
    $('.secondary-caregiver').fadeIn();
    $('.caregivers').fadeOut();
    $('.patient').fadeOut();
  });
  $('.emerge').on('click', function(){
    $('.secondary-caregiver').fadeOut();
    $('.caregivers').fadeOut();
    $('.patient').fadeIn();
  });
});
