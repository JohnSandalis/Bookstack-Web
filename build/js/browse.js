jQuery( () => {
    $.ajax({
        url: 'http://ism.dmst.aueb.gr/ismgroup6/servlet/AvailableBookServlet',
        type: 'GET',
        dataType: 'json',
    })
    .done( data => {
        if (console && console.log) {
            console.log("Sample of data:", data.slice(0, 100));
        }
    });
})

