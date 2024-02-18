<%
'#######################################################
'	History	:  2013.09.04 허진원 : 2013리뉴얼
'	History	:  2016.04.18 유태욱 : listisusing 추가
'	Description : culturestation
'#######################################################
%>
<script type="text/javascript">
$(function(){
	// culture station lnb
	// $('.cultureLnb > li .submenu').hide();
	// $('.cultureLnb > li .submenu:first').show();
	// $('.cultureLnb li:first > a').addClass("current");

	var navActiveIdx = $('.cult-head .nav').children('li.on').index();
	if (navActiveIdx !== 0) {
		$('.cultureLnb > li .submenu').hide();
		$('.cultureLnb > li').eq(navActiveIdx-1).find('.ico').addClass("current");
		$('.cultureLnb > li').eq(navActiveIdx-1).find('.submenu').show();
	}

	$('.cultureLnb > .feeling, .cultureLnb > .reading').click(function(){
		$('.cultureLnb > li .submenu').hide();
		$('.recentlyView').show();
		$(this).find('.submenu').show();
		$(this).find('.recentlyView').hide();
		$('.cultureLnb li .ico').removeClass("current");
		$(this).find(".ico").addClass("current");
		return false;
	});
	$('.cultureLnb > .editor > .ico').click(function(){
		$('.cultureLnb > li .submenu').hide();
		$('.recentlyView').show();
		$(this).parent().find('.submenu').show();
		$(this).parent().find('.recentlyView').hide();
		$('.cultureLnb li .ico').removeClass("current");
		$(this).parent().find(".ico").addClass("current");
		return false;
	});

	//selected open
<% if isNumeric(evt_type) then %>
	if($(".cultureLnb .submenu .current").length) {
		$('.cultureLnb > li .submenu').hide();
		$('.cultureLnb li .ico').removeClass("current");
		$(".cultureLnb .submenu .current").first().parent().parent().show().parent().find(".ico").addClass("current");
	}
	//컬쳐에디터 목록 접수
	getCultureList(1,0);
<% elseif evt_type="E" then %>
	$('.cultureLnb > li .submenu').hide();
	$('.recentlyView').hide();
	$('.cultureLnb li .ico').removeClass("current");
	$('.cultureLnb > .editor').find('.submenu').show();
	//컬쳐에디터 목록 접수
	getCultureList(<%=page%>,<%=editor_no%>);
<% else %>
	$('.cultureLnb > li .submenu').hide();
	$('.recentlyView').show();
	$('.cultureLnb li .ico').removeClass("current");
	//컬쳐에디터 목록 접수
	getCultureList(1,0);
<% end if %>
});

function getCultureList(pg,idx) {
	$.ajax({
		url: "act_cultureEditorList.asp?page="+pg+"&idx="+idx,
		cache: false,
		async: false,
		success: function(message) {
			$("#ediortList").empty().html(message);
		}
	});
}

function FnMovePage(pg) {
<% if evt_type="E" then %>
	getCultureList(pg,<%=editor_no%>);
<% else %>
	getCultureList(pg,0);
<% end if %>
}
</script>
<div class="lnbWrap">
	<ul class="cultureLnb">
		<%
			on error Resume Next
				'// 느껴봐
				Server.Execute "/chtml/culturestation/culturestation_category_1.asp"
				'// 읽어봐
				Server.Execute "/chtml/culturestation/culturestation_category_2.asp"
				'// 들어봐
				'Server.Execute "/chtml/culturestation/new_culturestation_category_3.asp"
			on error goto 0
		%>
	</ul>
</div>