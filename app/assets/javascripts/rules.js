$(document).ready(function(){
	var checkbox = document.querySelector('#checkbox1');
  var fieldset = document.querySelector('.toggleable');

  $(checkbox).click(function() {
		fieldset.disabled = !checkbox.checked;
	});
})
