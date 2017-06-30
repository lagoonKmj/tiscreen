/*================================================================================
 * @name: ui - ma.joo
 ================================================================================*/

$(document).ready(function(){
	//
	
	moveSlider();

	setTime();
	setInterval("setTime()", 1000);
	

});

//레이아웃설정
	$(window).load(function() {
		onResize();
	});
	
	$(window).resize(function() {
		onResize();
	});


//현재시간 설정
function setTime(){
  var now = new Date();
	
	var hours  = (now.getHours() < 10) ? ("0" + now.getHours()) : (now.getHours());
  var minutes  = (now.getMinutes() < 10) ? ("0" + now.getMinutes()) : (now.getMinutes());
  var seconds  = (now.getSeconds() < 10) ? ("0" + now.getSeconds()) : (now.getSeconds());
  
  var year = now.getFullYear();
  var month = ((now.getMonth() < 10) ? "0" : "") + (now.getMonth() + 1);
  var date =  ((now.getDate() < 10) ? "0" : "") + (now.getDate() + 1);
  var now_str = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds ;
	
	$(".current_time dd span").html(now_str);
	
}

//공지사항 롤링
	function moveSlider(){
	  var $noticeUl = $(".notice ul");
		
		var noticeBoxWidth = $(".notice dd").outerWidth();
		
		//각 li값을 더해 UL의 width값을 구한다
		var noticeUlWidth  = 0;
		$("li", $noticeUl).each(function(){ noticeUlWidth += parseInt($(this).outerWidth()); });
		
		$noticeUl.width(noticeUlWidth);
		var speed = parseInt(noticeUlWidth)*30;
		
		//흐르는 효과
		$noticeUl.css({left:noticeBoxWidth}).animate({left:-noticeUlWidth}, speed, "linear", function(){
			moveSlider();

		});
	}


function onResize(){
	//	var dd_width = parseInt($(".header .notice").outerWidth() - $(".header .notice dt").outerWidth());
	//	$(".header .notice dd").css("width", dd_width);
	
	
}




















