/*================================================================================
 * @name: ui - ma.joo
 ================================================================================*/

$(document).ready(function(){
	
	//공지사항
	moveSlider();

	//현재시간
	setTime();
	setInterval("setTime()", 1000);
	
	
	$(".tiscreen_dashboard").delay(300).animate({opacity:1}, 1000);
 
	
	//메뉴 드롭다운
	$(".dashboard_setting" ).on( "click", function(e) {
		var selector = $(e.target).closest("button");
		runEffect(selector);
	});
		//메뉴 드롭다운 : close 버튼 클릭
	/*$(".dashboard_control .inner button.close" ).on( "click", function() {
		var selector = $(e.target).closest("button");
		runEffect();
	});
	*/
	
	$(".dropdown_toggle").on("click", function(){
		if(!$(this).closest().hasClass("disabled")){
			if($("~.dropdown_layer", this).css("display")==="block"){
				$("~.dropdown_layer", this).slideUp("fast");
				$(this).removeClass("selected");
			}else{
				$(".dropdown_layer").slideUp("fast");
				$("~.dropdown_layer", this).slideDown("fast");
				$(".dropdown_toggle").removeClass("selected");
				$(this).addClass("selected");
			}	
		}
	
	});
	
	//테이블 header 고정
	$(".fixTable").tableHeadFixer(); 
	

	
	//No data
	//$(".no_data").html("<div><span class='icon'></span><span class='text'>No data</span></div>");
	
});

//레이아웃설정
	$(window).load(function() {
		onResize();
		container_h();
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

//대시보드 메뉴
function runEffect(selector) { 
	// Run the effect
	$(".dashboard_control .inner").toggle("blind", 300);
	selector.toggleClass("selected");
}


  $(document).click(function(e){    
    var v1 = $(e.target).closest(".dropdown_toggle").length;
    var v2 = $(e.target).closest(".dropdown_layer").length;
    if(!(v1===1 || v2===1)){
	  	$(".dropdown_toggle").removeClass("selected");
      $(".dropdown_layer").slideUp("fast");
    }
  });

function container_h(){
		
	var container_h = 0;
	//alert(container_h);
	$(".grid-stack-item-content-container").each(function(){
		container_h = parseInt($(this).closest(".grid-stack-item-content").height() - $(this).prev().outerHeight()-10);
		$(this).css("height", container_h);
		
	});
	
}


function onResize(){
	//	var dd_width = parseInt($(".header .notice").outerWidth() - $(".header .notice dt").outerWidth());
	//	$(".header .notice dd").css("width", dd_width);
	
}




















