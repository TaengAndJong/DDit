
document.addEventListener("DOMContentLoaded", function() {
	var navLinks = document.querySelectorAll('.nav-link');
	navLinks.forEach(function(link) {
		link.addEventListener('click', function(event) {
			event.preventDefault(); // 기본 동작 막기
			var targetUrl = link.getAttribute('href');
			var dataGoLink = link.getAttribute('data-go-link');
			if (dataGoLink) {
				window.location.href = dataGoLink;
			} else {
				window.location.href = targetUrl;
			}
		});
	});
	
	
	


	
	
	
	//end
});