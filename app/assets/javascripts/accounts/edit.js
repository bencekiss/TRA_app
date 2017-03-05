$(document).on("turbolinks:load",function(){
 $('.third-back').hide();
 $('.prime').on('click', function(){
   $('.secondary-caregiver').fadeOut();
   $('.caregivers').fadeIn();
   $('.patient').fadeOut();
   $('.third-back').hide();
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
 $('.secondary-next').on('click', function(){
   $('.secondary-caregiver').fadeIn();
   $('.caregivers').fadeOut();
   $('.patient').fadeOut();
   $('.third-back').show();
   $('.secondary-back').hide();
 });
   $('.third-back').on('click', function(){
     $('.secondary-caregiver').fadeOut();
     $('.caregivers').fadeIn();
     $('.patient').fadeOut();

 });
 $('.emerge-next').on('click', function(){
   $('.secondary-caregiver').fadeOut();
   $('.caregivers').fadeOut();
   $('.patient').fadeIn();
   $('.third-back').hide();
 });

 $('.fourth-back').on('click', function(){
   $('.secondary-caregiver').fadeIn();
   $('.caregivers').fadeOut();
   $('.patient').fadeOut();
   $('.third-back').show();
 });

});
