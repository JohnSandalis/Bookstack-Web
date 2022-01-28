jQuery( () => {
    $("#acquire_form").submit(function(event) {
	if confirm("You are about to spend credits to get this book."         		+ " Are you sure you want to proceed?") {

		alert("Successful book acquisition!");

	else {
		event.preventDefault();
	}
})
