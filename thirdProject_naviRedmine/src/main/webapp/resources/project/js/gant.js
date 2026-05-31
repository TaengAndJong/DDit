document.addEventListener("DOMContentLoaded", function() {
   const cPath = document.body.dataset.contextPath;
   function getCsrfToken(){
      return document.querySelector('meta[name="_csrf"]').getAttribute('content');
   }
   function getCsrfHeader(){
      return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
   }
   
   
   let proId=$("#nav-tab").data("pro");
   fetch(cPath+"/project/gantt/"+proId,{
      method:"POST",
      headers:{
         "Accept":"application/json",
         "Content-Type": "application/json",
         [getCsrfHeader()]: getCsrfToken()
      }
   }).then(resp=>{
      if(resp.ok){
         return resp.json();
      }else{
         throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
      }
   }).then(jsonObj=>{
      console.log(jsonObj)
       var demoSource = jsonObj;
         
         console.log("demoSource=",demoSource);

         // shifts dates closer to Date.now()
         var offset = new Date().setHours(0, 0, 0, 0) -
             new Date(demoSource[0].values[0].from).setDate(35);
         for (var i = 0, len = demoSource.length, value; i < len; i++) {
             value = demoSource[i].values[0];
             value.from += offset;
             value.to += offset;
         }
         console.log(demoSource)
         $(".gantt").gantt({
             source: demoSource,
             navigate: "scroll",
             scale: "days",
             maxScale: "months",
             minScale: "days",
             itemsPerPage: 10,
             scrollToToday: false,
             useCookie: true,
             onItemClick: function(data) {
                 alert("Item clicked - show some details");
             },
             onAddClick: function(dt, rowId) {
                 alert("Empty space clicked - add an item!");
             },
             onRender: function() {
                 if (window.console && typeof console.log === "function") {
                     console.log("chart rendered");
                 }
             }
         });

         $(".gantt").popover({
             selector: ".bar",
             title: function _getItemText() {
                 return this.textContent;
             },
             container: '.gantt',
             content: "Here's some useful information.",
             trigger: "hover",
             placement: "auto right"
         });

         prettyPrint();
   }).catch(err=>{
      console.error(err);
   })
});