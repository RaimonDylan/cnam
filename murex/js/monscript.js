$(document).ready(function() {
	


	seconds = 10;
	minuteur = false;
	waitQuestion = false;
	waitAdventure = true;

    setInterval(function() {
		if(waitAdventure){
			$.ajax({
				url:"./bdd/waitAdventure.php",
				type:"POST",
				success:function(retour) {
					if(retour.trim() != "false"){
						$('.arch1').hide();
						$('.arch2').show();
						waitQuestion = true;
						waitAdventure = false;
					}
				},
				error:function(xhr, status, error){
					var err = eval("(" + xhr.responseText + ")");
					alert(err.Message);
				}
			});
		}
    	if(waitQuestion){
    		$.ajax({
		        	url:"./bdd/waitQuestion.php",
		        	type:"POST",
		        	success:function(retour) {
		        		if(retour.trim() != "false"){
		        			$('#panelQuestion').empty().append(retour);
							$(".arc").hide();
							$(".arch2").hide();
							$(".projectname").hide();
							$(".projectdesc").hide();
							$(".minuteur").show();
		        			waitQuestion = false;
		        			minuteur = true;
		        		}
		       		},
		       		error:function(xhr, status, error){
						var err = eval("(" + xhr.responseText + ")");
						alert(err.Message);
		       		}
			    });
    	}
		if(minuteur){
			$("#seconds").text(seconds);
			seconds--;
			if(seconds<0){
				$('.minuteur').hide();
				$.ajax({
					url:"./bdd/minuteur.php",
		        	type:"POST",
					data:{

					},
		        	success:function(retour) {
						minuteur = false;
						$('#panelQuestion').empty();
						$(".arc").show();
						$(".arch2").show();
						$(".projectname").show();
						$(".projectdesc").show();
						$(".minuteur").hide();
						seconds = 10;
						$("#seconds").text(seconds);
						waitQuestion = true;
		       		},
		       		error:function(){
		        		alert("error");
		       		}
			    });
			}
		}

	}, 1000);

	idLaunchOld = "";
	numChoiceOld = "";
	$(document).on('click','.choice',function(){
		$(".choice").css('background','rgba(240, 230, 220, .5)');
		$(this).css('background','rgba(240, 230, 220, .8)');
		var idLaunch = $('#question').data('id');
		var numChoice = $(this).data('num');
		var btn  = $(this);
		$.ajax({
			url:"./bdd/vote.php",
			type:"POST",
			dataType: "json",
			data:{
				idLaunch:idLaunch,
				numChoice:numChoice,
				idLaunchOld:idLaunchOld,
				numChoiceOld:numChoiceOld
			},
			success:function(data) {
				$(".choice").each(function( i ) {
					var numChoice = $(this).data('num');
					var nbVote = data[numChoice];
					if(nbVote)
						$(this).find('.nbVote').empty().append(nbVote);
					else
						$(this).find('.nbVote').empty().append(0);
				});
				idLaunchOld = idLaunch;
				numChoiceOld = numChoice;
			},
			error:function(){
				alert("error");
			}
		});
	});
});