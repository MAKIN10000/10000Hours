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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require_tree .
var Profile = {
  setup: function() {
    var ul = $('#goals')
    $(document).on('click', '#goals_tab', Profile.getGoalInfo);
  }
  ,getGoalInfo: function() {
    var ul = $('#goals')
    $.ajax({type: 'GET',
      url: "/goals/list/"+ul.data('user'),
      timeout: 5000,
      success: Profile.showGoals,
      error: function(xhrObj, textStatus, exception) { alert('Error!'); }
    });
    return(false);
  }
  ,showGoals: function(data, requestStatus, xhrObject) {
    var ul = $('#goals')
    ul.html(data);
  }
};
$(Profile.setup);
