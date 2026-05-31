document.addEventListener("DOMContentLoaded", () => {



  //배열로 ui 전부 가져옴
  var ui = document.querySelectorAll(".ui");

  //복사버튼에 각각 아이디를 부여
  for (var i = 0; i < ui.length; i++) {
    let btn = ui[i].querySelector(".copy");
    btn.id = "copyBtn" + i;
   // console.log(ui, btn);
  }

  // 복사버튼의 아이디를 각각 가져오기
  var btns = document.querySelectorAll(".copy");
  //코드 copy script
 // console.log(btns);

  btns.forEach(copyBtn => {
   
    new ClipboardJS(copyBtn, {
        target: function (trigger) {
        console.log("trigger", trigger); // 각각 버튼 타겟됨
        //각버튼의 복사할 컨테이너
          let codeContainer =copyBtn.nextElementSibling;
         //console.log(codeContainer);
          let codeText = codeContainer.querySelector(
            "[data-clipboard-text]"
          ).innerHTML; // 복사되는 텍스트
          codeContainer.dataset.value = codeText;
          return codeContainer;
        },
      });
    
      //DOMContentLoaded End
    });
    

  });

  