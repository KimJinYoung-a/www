<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
'#############################################
' T-episode - 김진영
' 2013-10-01 
'#############################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<%
	Dim ophotopick, i , idx , pagesize 
	dim CurrPage : CurrPage = getNumeric(requestCheckVar(request("cpg"),8))
	Dim playcode : playcode = 7 '메뉴상단 번호를 지정 해주세요

	if CurrPage="" then CurrPage=1
	pagesize =30
	'//그림일기 리스트
	set ophotopick = new CPlayContents
		ophotopick.FPageSize = pagesize
		ophotopick.FCurrPage = CurrPage
		ophotopick.Fplaycode = playcode
		ophotopick.sbGetPhotoPickItem()
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//레이어
		$('a[name=lyrPopup]').click(function(e) {
			e.preventDefault();
			var id =  "#playTepisodeLyr"; // $(this).attr('href');
			var relval = $(this).attr('rel');
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();

			$('#lyrPop').show();
			$('.window').show();

			jsGoView(relval);
			var winH = $(window).height();
			var winW = $(window).width();
			$(id).css('top', winH/2-$(id).height()/2);
			$(id).css('left', winW/2-$(id).width()/2);
			$(id).show();
		});
	});

	function jsGoView(val){
		var str = $.ajax({
					type: "GET",
					url: "playtepisodePhotopickView_ajax.asp?idx="+val,
					dataType: "text",
					async: false
					,error: function(err) {
					alert(err.responseText);
				}
			}).responseText;
		if(str!="") {
			$("#photopickview").empty().append(str);
		}
	}

	$(function() {
		$(".photoPickList .box a .description").hide();
		$(".photoPickList .box a").mouseover(function () {
			$(".photoPickList .box a .description").hide();
			$(this).children().show();
		});

		$(".photoPickList .box a").mouseleave(function () {
			$(".photoPickList .box a .description").hide();
		});
	});
</script>
<% If ophotopick.FResultCount > 0 Then %>
<div class="photoPickList">
	<% For i=0 to ophotopick.FresultCount-1 %>
	<div class="box">
		<a href="#playTepisodeLyr" name="lyrPopup" rel="<%= ophotopick.FItemList(i).Fidx %>">
			<span class="thumbnail">
				<% IF application("Svr_Info")="Dev" THEN %>
				<img src="<%= ophotopick.FItemList(i).FPPimg %>" height="200" alt="<%=html2db(ophotopick.FItemList(i).FViewtitle)%>" />
				<% Else %>
				<img src="<%= "http://thumbnail.10x10.co.kr/webimage/play" & Split(ophotopick.FItemList(i).FPPimg,"/play")(1) & "?cmd=thumb&h=200" %>" alt="<%=html2db(ophotopick.FItemList(i).FViewtitle)%>" />
				<% End If %>
			</span>
			<span class="description">
				<% If DateDiff("d", Date(), ophotopick.FItemList(i).FRegdate) >= -7 Then %>
				<em><img src="http://fiximage.10x10.co.kr/web2013/play/ico_new.gif" alt="NEW" /></em>
				<% End If %>
				<strong><%=html2db(ophotopick.FItemList(i).FViewtitle)%></strong>
				<button type="button">확대보기</button>
			</span>
		</a>
	</div>
	<% Next %>
</div>
<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(CurrPage,ophotopick.FTotalCount,PageSize,10,"jsGoPage") %></div>
<% End If %>
<%
	Set ophotopick = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->