// 프로젝트상태 배경
var proElements = document.querySelectorAll('.projectState');
proElements.forEach(function(element) {
    var cmName = element.textContent.trim();

    if (cmName === '안정') {
        element.classList.toggle('ordinary', true);
    } else if (cmName === '긴급') {
        element.classList.toggle('emergency', true);
    } else if (cmName === '신규') {
        element.classList.toggle('project', true);
    }
});

var impElements = document.querySelectorAll('.impState');
impElements.forEach(function(element) {
    var impName = element.textContent.trim();

    if (impName === '낮음') {
        element.classList.toggle('ordinary', true);
    } else if (impName === '보통') {
        element.classList.toggle('cate4', true);
    } else if (impName === '높음') {
        element.classList.toggle('project', true);
    } else if (impName === '긴급') {
        element.classList.toggle('emergency', true);
    }
});

var stateElements = document.querySelectorAll('.issueState');
stateElements.forEach(function(element) {
    var stateName = element.textContent.trim();

    if (stateName === '해결') {
        element.classList.toggle('cate2', true);
    } else if (stateName === '보류') {
        element.classList.toggle('emergency', true);
    } else if (stateName === '신규') {
        element.classList.toggle('new', true);
    } else if (stateName === '진행') {
        element.classList.toggle('cate3', true);
    } else if (stateName === '거절') {
        element.classList.toggle('diss', true);
    }
});