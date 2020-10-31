// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


import "bootstrap"
import "../stylesheets/application"
import "@fortawesome/fontawesome-free/js/all"


$(function(){
  // jquery number field
  $(".numberField").keypress(function (e) {
    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
      return false;
    }
   });
   
   $(".decimalField").keypress(function (e) {
      if (e.which != 8 && e.which != 0 && ((e.which < 48 && e.which != 46) || e.which > 57)) {
       return false;
     }
    });
   
   $(".numberField").focusout(function (e) {
     if($(this).val() == 0){
       $(this).val('');
     }
   });
   
   $(".numberField").change(function (e) {
     if($(this).val() == 0){
       $(this).val('');
     }
   });
   
   $('.otp-field').keyup(function(e){
     if(e.which == 8){
       var no = parseInt($(this).attr("id").replace("otp_", ""));
       $(`#otp_${no-1}`).focus();
     }else {
       var intRegex = /^\d+$/;
       var value = $(this).val();
       if(intRegex.test(value)){
         $(this).next('.otp-field').focus();
         $(this).css("border", "0.15000000596046448px solid #52616B");
         $('input[type="submit"]').attr("disabled", false);
       }else{
         $(this).val("");
       }
     }
   })
   
   $('#user_password').keypress(function(e){
     $(this).css("border", "0.15000000596046448px solid #52616B");
   })
   
   $('#user_confirm_password').keypress(function(e){
     $(this).css("border", "0.15000000596046448px solid #52616B");
   })
})
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
