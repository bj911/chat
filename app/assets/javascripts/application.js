// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready (function (){
    Gallery();
    iAmOnline = function() {
        setInterval(function() {
            $.ajax({
                url:'/i_am_online',
                type: 'GET',
                success: function(response) {
                    $('.online_users').html(response);
                }
            });
        }, 60000);
    }
    iAmOnline();
});

function Gallery() {
    $(".gallery").fancybox(
        {
            "padding" : 20,
            "imageScale" : false,
            "zoomOpacity" : false,
            "zoomSpeedIn" : 1000,
            "zoomSpeedOut" : 1000,
            "zoomSpeedChange" : 1000,
            "frameWidth" : 700,
            "frameHeight" : 600,
            "overlayShow" : true,
            "overlayOpacity" : 0.8,
            "hideOnContentClick" :false,
            "centerOnScroll" : false
        });
};