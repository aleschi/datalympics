// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require jquery
//= require bootstrap-sprockets
//= require jquery-ui
//= require jquery_ujs
//= require moment 
//= require moment/fr.js 
//= require activestorage
//= require toastr
//= require jquery.flexslider
//= require turbolinks
//= require bootstrap-datetimepicker

//= require chartkick
//= require_tree .

$(document).ready(function() {
  toastr.options = {
   "closeButton": true,
  "debug": false,
  "newestOnTop": false,
  "progressBar": false,
  "positionClass": "toast-top-right",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "1000",
  "hideDuration": "1000",
  "timeOut": "1000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
   }
});

 $(document).on("turbolinks:load", function() {
  $('#flexslider').flexslider({ 
    animation: "slide",
    animationLoop: false,
    slideshow: false,
    prevText: "",    
    nextText:'',
  });
 })
  $(document).on("turbolinks:load", function() {
  $('#flexslider-fin').flexslider({ 
    animation: "slide",
    animationLoop: false,
    slideshow: false,
    prevText: "Année suiv",    
    nextText:'Année préc',
  });
 })
 $( document ).on('turbolinks:load', function() {
  $('#datetimepicker').datetimepicker({
    locale: 'fr',
    //sideBySide: true,
    ignoreReadonly: true,
    format: "DD MMM YY à HH:mm",
    showClose: true,
    keepOpen: false,
    toolbarPlacement: "top",
    icons: {
            close: 'closeText',
        },
    allowInputToggle: true,
    minDate: moment()
  });
});