$(document).ready(function(){
    var nav1 = "#nav1";
    var nav2 = "#nav2";

    if(window.location.href.includes('emp')){
        if (window.location.href.includes('pms=pms')){
            $(nav2).addClass("active");
            $(nav1).removeClass("active");
        } else {
            $(nav1).addClass("active");
            $(nav2).removeClass("active");
        }
    } else {
        $(nav1).addClass("active");
        $(nav2).removeClass("active");
    }

	var nav3 = "#nav3";
    var nav4 = "#nav4";
 	if(window.location.href.includes('block')){
        if (window.location.href.includes('block=block')){
            $(nav4).addClass("active");
            $(nav3).removeClass("active");
        } else {
            $(nav3).addClass("active");
            $(nav4).removeClass("active");
        }
    } else {
        $(nav3).addClass("active");
        $(nav4).removeClass("active");
    }

	var nav5 = "#nav5";
    var nav6 = "#nav6";
 	if(window.location.href.includes('ing')){
        if (window.location.href.includes('ing=end')){
            $(nav6).addClass("active");
            $(nav5).removeClass("active");
        } else {
            $(nav5).addClass("active");
            $(nav6).removeClass("active");
        }
    } else {
        $(nav5).addClass("active");
        $(nav6).removeClass("active");
    }

	var nav7 = "#nav7";
    var nav8 = "#nav8";
    var nav9 = "#nav9";
 	if(window.location.href.includes('board')){
        if (window.location.href.includes('photo')){
            $(nav7).addClass("active");
            $(nav8).removeClass("active");
            $(nav9).removeClass("active");
        } else if (window.location.href.includes('prais')){
            $(nav8).addClass("active");
            $(nav7).removeClass("active");
            $(nav9).removeClass("active");
        } else{
            $(nav9).addClass("active");
            $(nav8).removeClass("active");
            $(nav7).removeClass("active");
        }
    } else {
        $(nav7).addClass("active");
        $(nav8).removeClass("active");
        $(nav9).removeClass("active");
    }

});