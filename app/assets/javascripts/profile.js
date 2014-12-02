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
