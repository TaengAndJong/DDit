 function handleScroll() {
    	var scrollbar = document.documentElement.scrollTop;
        var quick = document.getElementById('qickScroll');
        var footer = document.getElementById('footer');

       // console.log(scrollbar,footer.offsetHeight);
        //console.log(((footer.offsetTop  - scrollbar) * 0.3));
      
        
        
  	quick.classList.remove("show");
        
        if(scrollbar > 0){
        	quick.classList.add("show");
        	
        }
        
          if(((footer.offsetTop  - scrollbar) * 0.3) <= footer.offsetHeight){
        	quick.classList.remove("show");
        } 
        
    }
    
    //함수 참조
    window.addEventListener('scroll', handleScroll);   