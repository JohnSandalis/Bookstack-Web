$(document).ready( () => {
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
        placeholder: "Subjects"
    })
})