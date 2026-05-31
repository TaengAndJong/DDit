//$(document).ready(function(){
//    $(".moveMenu").each(function(i, e){
//        let url = $(e).data("url");
//        let realUrl = window.location.href;
//
//        if (realUrl.endsWith(url)){
//            $(e).children().addClass("active");
//        }
//    });
//});
$(document).ready(function(e){
	$(".moveMenu").each(function(i,e){
		let url = $(e).data("url");		
		let realUrl=window.location.href
		let arr = realUrl.split("/");
		console.log(arr[5])
		if(arr[5]=="modify"){
			arr[5]="verification"
		}
		let a = arr[5].split("?");
		if(url.includes(a[0])){
			$(e).children().addClass("active");
		}
	})
	
})