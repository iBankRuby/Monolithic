$(document).ready(function(){
	var checkbox = document.querySelector('#editable');
    var fieldset = document.querySelector('.toggleable');

    $(checkbox).click(function() {
	  fieldset.disabled = !checkbox.checked;
	});
})
