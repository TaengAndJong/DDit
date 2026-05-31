document.addEventListener("DOMContentLoaded",()=>{
    //코드 copy script
    new ClipboardJS('#clipBtn', {
        target: function(trigger) {
            let codeContainer = document.querySelector("#code pre");
            console.log(codeContainer);
            let codeText = codeContainer.querySelector("[data-clipboard-text]").innerHTML;           
            codeContainer.dataset.value= codeText;
            return codeContainer;
        }
    });
   



//DOMContentLoaded End
});