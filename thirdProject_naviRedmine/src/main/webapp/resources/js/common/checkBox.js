//tableClass에 '클래스명이나 아이디값으로 호출하여 사용'
function checkbox(tableClass) {
    let checkAll = $("#checkAll");
    let checkboxes = $(tableClass).find("input[type='checkbox']");
    checkAll.attr("title", "");
    checkboxes.attr("title", "");
    
    console.log(checkAll);
    
    checkAll.on("click", function() {
        let checked = $(this).prop("checked");
        $(this).attr("title", checked ? "체크" : "체크해제");
        
        checkboxes.each(function() {
            $(this).prop("checked", checked);
            $(this).attr("title", checked ? "체크" : "체크해제");
        });
    });
}


//예시 checkbox('#todoListModal'); 