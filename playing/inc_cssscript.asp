<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<% If vCate = "1" Then	'### playlist %>
<script type="text/javascript">
$(function(){
	<% If RequestCheckVar(request("iscomm"),1) = "o" Then %>
	setTimeout("jsCa1Down()",500);
	<% End If %>
});

function jsCa1Down(){
	window.$('html,body').animate({scrollTop:$("#licmt1").offset().top}, 0);
}

function jsCa1Page(p){
	frm1com.page.value = p;
	frm1com.submit();
}

function jsCa1ComDel(i){
	frm1comdel.idx.value = i;
	frm1comdel.submit();
}
</script>
<% ElseIf vCate = "2" OR vCate = "21" OR vCate = "22" Then	'### inspiration %>
<script type="text/javascript">
$(function(){
	$(".inspiration #hgroup").css({top:"50%", margin:"-"+($(".inspiration #hgroup").height() / 2)+"px 0 0 0"+"px"});
});
</script>
<% ElseIf vCate = "3" Then	'### azit %>
<script type="text/javascript">
$(function(){
	<% If RequestCheckVar(request("iscomm"),1) = "o" Then %>
	setTimeout("jsCa3Down()",500);
	<% End If %>
});

function jsCa3Down(){
	window.$('html,body').animate({scrollTop:$("#licmt3").offset().top}, 0);
}

function jsCa3Page(p){
	frm3com.page.value = p;
	frm3com.submit();
}

function jsCa3ComDel(i){
	frm3comdel.idx.value = i;
	frm3comdel.submit();
}
</script>
<% ElseIf vCate = "42" Then	'### thingthing %>
<script type="text/javascript">
$(function(){
	/* swiper js rolling */
	if ($("#thingRolling .swiper-container .swiper-slide").length > 1) {
		var mySwiper = new Swiper("#thingRolling .swiper-container",{
			loop:true,
			resizeReInit:true,
			calculateHeight:true,
			pagination:'.paginationDot',
			paginationClickable:true,
			speed:1500,
			autoplay:1500
		});
	} else {
		var swiper1 = new Swiper("#thingRolling .swiper-container", {
			pagination:false,
			simulateTouch:false
		});
	}
	
	<% If RequestCheckVar(request("iscomm"),1) = "o" Then %>
	setTimeout("jsCa42Down()",500);
	<% End If %>
});

function jsCa42Down(){
	window.$('html,body').animate({scrollTop:$("#licmt42").offset().top}, 0);
}

function jsCa42Page(p){
	frm42ent.page.value = p;
	frm42ent.submit();
}

function chkfrm42(f){
<% If IsUserLoginOK() Then %>
	if(f.entryvalue.value == ""){
		alert("내 이름을 지어주세요!");
		f.entryvalue.focus();
		return false;
	}
	return true;
<% Else %>
	location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx&"")%>';
	return false;
<% End If %>
}

function jsCa42EntDel(i){
	frm42entdel.idx.value = i;
	frm42entdel.submit();
}

function jsTCommentEnd(){
	alert("응모기간이 마감되었습니다.\n당첨자 발표를 기대 해 주세요!");
	return false;
}
</script>
<% ElseIf vCate = "5" Then	'### comma %>
<% Else %>
<script type="text/javascript">
$(function(){

});
</script>
<% End If %>