document.addEventListener('DOMContentLoaded', function() {
    var checkbox = document.querySelector('#editable');
    var fieldset = document.querySelector('.toggleable');

    checkbox.addEventListener('click', function() {
        fieldset.disabled = !checkbox.checked;
    });
});
