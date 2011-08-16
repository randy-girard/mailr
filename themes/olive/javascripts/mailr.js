
function toggleCheckBoxes(formName){

    // toggle Check Boxes using Prototype Library
	var form=$(formName);
	var i=form.getElements('checkbox');
	i.each(function(item)
            {
                item.checked = !item.checked;

            }
	);
    // set our toggle box
    $('togglechkbox').checked = !$('togglechkbox').checked;

}
