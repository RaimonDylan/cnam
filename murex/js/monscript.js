$(document).ready(function() {
	




	$("#btnDownload").click(function() {
		$(this).hide();
		$(".fadeleft").addClass("fadeInLeft animated");
		$(".faderight").addClass("fadeInRight animated");
		$(".choice").show();
		$("#question").show();
	});

	$(".accueil").after().css("cursor", "pointer"), $(".actualites").after().css("cursor", "pointer"), $(".classement").after().css("cursor", "pointer"), $(".forum").after().css("cursor", "pointer"), $(".medias").after().css("cursor", "pointer"), $(".contact").after().css("cursor", "pointer"), $(".accueil").after().mouseover(function() {
		$(".accueil a").css("color", "#fff")
	}), $(".accueil").after().mouseout(function() {
		$(".accueil a").css("color", "#9d9d9d")
	}), $(".actualites").after().mouseover(function() {
		$(".actualites a").css("color", "#fff")
	}), $(".actualites").after().mouseout(function() {
		$(".actualites a").css("color", "#9d9d9d")
	}), $(".accueil").after().click(function() {
		var o = $(".accueil > a").attr("href");
		window.location.href = o
	}), $(".actualites").after().click(function() {
		var o = $(".actualites > a").attr("href");
		window.location.href = o
	})
	 $(window).on("resize", function() {
		$(this).width() < 800 ? ($(".formcontact").addClass("col-md-12"), $(".formcontact").removeClass("col-md-6")) : ($(".formcontact").removeClass("col-md-12"), $(".formcontact").addClass("col-md-6"))
	})
	 /*
	const second = 1000;
	let countDown = new Date('Sep 30, 2019 00:00:00').getTime(),
    x = setInterval(function() {

      let now = new Date().getTime(),
          distance = countDown - now;

      document.getElementById('days').innerText = Math.floor(distance / (day)),
        document.getElementById('hours').innerText = Math.floor((distance % (day)) / (hour)),
        document.getElementById('minutes').innerText = Math.floor((distance % (hour)) / (minute)),
        document.getElementById('seconds').innerText = Math.floor((distance % (minute)) / second);
      
      //do something later when date is reached
      //if (distance < 0) {
      //  clearInterval(x);
      //  'IT'S MY BIRTHDAY!;
      //}

    }, second)
    */
});