
jQuery( () => {
    // Retrieve subjects from serlet
    $("#subjects").select2({
        ajax: {
            url: 'http://ism.dmst.aueb.gr/ismgroup6/servlet/SubjectServlet',
            dataType: 'json',
            delay: 250,
            data: (params) => {
                return {
                    name: params.term
                }
            }
        },
        minimumInputLength: 3,
        placeholder: 'Subjects',
        closeOnSelect: false
    });

    // Init authors select2
    $("#authors").select2({
        ajax: {
            url: 'http://ism.dmst.aueb.gr/ismgroup6/servlet/AuthorServlet',
            dataType: 'json',
            delay: 250,
            data: (params) => {
                return {
                    name: params.term
                }
            }
        },
        minimumInputLength: 3,
        tags: true,
        tokenSeparators: [','],
        placeholder: 'Authors'
    });

    // Remove disabled state from select element, in order to submit form
    $('#bookForm').on('submit', function () {
        $(this).find('#subjects, #authors').removeAttr('disabled');
    });

})




