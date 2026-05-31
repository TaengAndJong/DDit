const cPath = document.body.dataset.contextPath;

function getCsrfToken() {
    return document.querySelector('meta[name="_csrf"]').getAttribute('content');
}

function getCsrfHeader() {
    return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
}

function sendRequest(url, method, data) {
    return fetch(url, {
        method: method,
        headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            [getCsrfHeader()]: getCsrfToken()
        },
        body: JSON.stringify(data)
    });
}

$(".issueBookmark").on("click", function(e) {
    e.preventDefault();

    const issueId = $(this).data("mark-id");
    const proId = $(this).data("pro-id");
    const url = cPath + "/mypage/bookmark/issue";

    sendRequest(url, "POST", { issueId: issueId, proId: proId })
        .then(resp => {
            if (resp.ok) {
                $(this).toggleClass("active");
                return resp.json();
            } else {
                throw new Error(`상태코드 ${resp.status} 수신`, { cause: resp });
            }
        })
        .then(jsonObj => {
            jsonObj;
        })
        .catch(err => {
            console.error(err);
        });
});

$(".boardBookmark").on("click", function(e) {
    e.preventDefault();

    const bpId = $(this).data("mark-id");
    const url = cPath + "/mypage/bookmark/board";

    sendRequest(url, "POST", { bpId: bpId })
        .then(resp => {
            if (resp.ok) {
                $(this).toggleClass("active");
                return resp.json();
            } else {
                throw new Error(`상태코드 ${resp.status} 수신`, { cause: resp });
            }
        })
        .then(jsonObj => {
            jsonObj;
        })
        .catch(err => {
            console.error(err);
        });
});

$(document).ready(function() {
    $(".issueMark").on("click", function(e) {
        e.preventDefault();
        let issueId = $(e.target).data("issueId");
        sendRequest(cPath + "/mypage/bookmark/issue/" + issueId, "DELETE")
            .then(resp => {
                if (resp.ok) {
               	 location.reload();
                    return resp.json();
                } else {
                    throw new Error(`상태코드 ${resp.status} 수신`, { cause: resp });
                }
            })
            .catch(err => {
                console.error(err);
            });
    });
});

$(document).ready(function() {
    $(".boardMark").on("click", function(e) {
        e.preventDefault();
        let bpId = $(e.target).data("boardId");
        sendRequest(cPath + "/mypage/bookmark/board/" + bpId, "DELETE")
            .then(resp => {
                if (resp.ok) {
                    location.reload(); 
                    return resp.json();
                } else {
                    throw new Error(`상태코드 ${resp.status} 수신`, { cause: resp });
                }
            })
            .catch(err => {
                console.error(err);
            });
    });
});