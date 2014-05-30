// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require_tree .

// image animation js jquery addon
$(document).ready(function() {
        $('.image-popup-no-margins').magnificPopup({
          type: 'image',
          closeOnContentClick: true,
          closeBtnInside: false,
          fixedContentPos: true,
          mainClass: 'mfp-no-margins mfp-with-zoom', // class to remove default margin from left and right side
          image: {
            verticalFit: true
          },
          zoom: {
            enabled: true,
            duration: 500 // don't foget to change the duration also in CSS
          }
        });
      });

//for devs that investigate code
console.log("+-------------------------------+")
console.log("|  Welcome to reddit-clone.com  |")
console.log("|     Coded by Chris Cowell     |")
console.log("|      cell: 614-370-9978       |")
console.log("|       github: cowell21        |")
console.log("+-------------------------------+")