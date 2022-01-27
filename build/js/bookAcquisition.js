jQuery( () => {
    $("confirmation-btn").on("click", function() {
        if(confirm("You are about to spend credits to get this book."
        + "Are you sure you want to proceed?")) {
            console.log("OK");
        } else {
            console.log("NOT OK");
        }
    })
})