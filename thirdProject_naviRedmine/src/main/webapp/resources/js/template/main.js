$("a[data-go-link]").each(function (index, atag) {
  const contextPath = $("body").data("contextPath");
  console.log(contextPath);
  let fullUrl = contextPath + $(atag).data("goLink");
  $(atag).attr("href", fullUrl);
});

AOS.init();

let header = document.querySelector("#header");
document.body.addEventListener("scroll", function () {
  let scrollbar = this.scrollTop;
  //console.log(scrollbar);
  if (scrollbar > 0) {
    header.classList.add("move");
  } else {
    header.classList.remove("move");
  }
});
