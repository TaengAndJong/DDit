$('a[data-val]').on("click",function(event){
	event.preventDefault();
	let value=$(this).data("val")
	$(subjectForm).find("input[name='subCd']").val(value)
	console.log($(subjectForm).find("input[name='subCd']").val())
	$(subjectForm).submit()
})