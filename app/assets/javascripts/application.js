//= require jquery
//= require ajax_setup
//= require ajax_modal
//= require bootstrap
//= require flash_message
//= require visibility_map
//= require modal
//= require select2
//= require select2_init
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require course_page
//= require edit_course_page

$(document).ready(function(){
    $('.wysihtml5-manual').each(function(i, elem){
        $(elem).wysihtml5();
    });
});


$('.sort').on('click', function() {
  $(".blog-list").html($('#{j render ' + blog_list + '}'));
})

$(document).ready(function() {
  $('#filter-btn').on('click', function() {
    var el = $(this);
    el.text() == el.data("text-swap")
      ? el.text(el.data("text-original"))
      : el.text(el.data("text-swap"));
    el.text() == el.data('text-original') ? el.blur() : el.focus();
  });
});
