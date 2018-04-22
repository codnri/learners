
$(document).ready(function() {
 $("#new_task_toggle").change(function(){
  
  //clear the input text field for new-task
  $('#subject_name').val('');
  
   if ($(this).is(':checked')) {
		$('#existing_task').css("display", "none");
		$('#new_task_name').css("display", "block");
	} else {
		$('#existing_task').css("display", "block");
		$('#new_task_name').css("display", "none");
	}
   
 });

});

