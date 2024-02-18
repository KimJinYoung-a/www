<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
Response.Addheader "P3P","policyref=""/w3c/p3p.xml"", CP=""CONi NOI DSP LAW NID PHY ONL OUR IND COM"""
'#############################################
' 그림일기 ajax - 이종화
' 2013-09-09 
'#############################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<%
	Dim oPictureDiary, i , idx , pagesize 
	dim CurrPage : CurrPage = getNumeric(requestCheckVar(request("cpg"),8))
	dim loginuserid : loginuserid = requestCheckVar(request("uid"),30)
	Dim playcode : playcode = 5 '메뉴상단 번호를 지정 해주세요

	if CurrPage="" then CurrPage=1
	pagesize = 12

	'//그림일기 리스트
	set oPictureDiary = new CPlayContents
		oPictureDiary.FPageSize = pagesize
		oPictureDiary.FCurrPage = CurrPage
		oPictureDiary.Fplaycode = playcode
		oPictureDiary.Fuserid = loginuserid
		oPictureDiary.fnGetPictureDiaryList()

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('img').load(function(){
			$(".diaryList").masonry({
				itemSelector: '.box'
			});
		});
		$(".diaryList").masonry({
			itemSelector: '.box'
		});

		//레이어
		$('a[name=lyrPopup]').click(function(e) {
			e.preventDefault();
			var id = "#playDiaryLyr"; //$(this).attr('href');
			var relval = $(this).attr('rel');
			var relval2 = $(this).attr('rel2');
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();

			$('#lyrPop').show();
			$('.window').show();

			jsGoView(relval,relval2);

			var winH = $(window).height();
			var winW = $(window).width();
			$(id).css('top', winH/2-$(id).height()/2);
			$(id).css('left', winW/2-$(id).width()/2);
			$(id).show();
		});
	});

	function jsGoView(val,val2){
		var str = $.ajax({
					type: "GET",
					url: "playPicDiaryView_ajax.asp?idx="+val+"&viewno="+val2+"&uid=<%=loginuserid%>",
					dataType: "text",
					async: false
					,error: function(err) {
					alert(err.responseText);
				}
			}).responseText;
		if(str!="") {
			$("#diaryview").empty().append(str);
		}
	}
	
	$('#swiperDiaryLt').unbind("click");
	$('#swiperDiaryLt').on('click', function(e){
		e.preventDefault();
		var minidx = $("#prevval").attr("rel");
		var minno = $("#prevval").attr("rel2");
		if (minidx > "0" )
		{
			jsGoView(minidx,minno);
			false;
		}else{
			alert("마지막 그림일기 입니다");
		}
	});
	
	$('#swiperDiaryRt').unbind("click");
	$('#swiperDiaryRt').on('click', function(e){
		e.preventDefault();
		var maxidx = $("#nextval").attr("rel");
		var maxno = $("#nextval").attr("rel2");
		if (maxidx > "0" )
		{
			jsGoView(maxidx,maxno);
			false;
		}else{
			alert("첫 그림일기 입니다");
		}
	});
</script>
<% if oPictureDiary.FresultCount > 0 then %>
<div class="diaryList">
	<% for i=0 to oPictureDiary.FresultCount-1 %>
	<div class="box">
		<p><a href="#playDiaryLyr" name="lyrPopup" rel="<%= oPictureDiary.FItemList(i).Fidx %>" rel2="<%= oPictureDiary.FItemList(i).Fviewno %>"><img src="<%= oPictureDiary.FItemList(i).Flistimg %>" alt="<%= oPictureDiary.FItemList(i).Fviewtitle %>" /></a></p>
		<div class="favoriteWrap"><div id="mywish<%=oPictureDiary.FItemList(i).Fidx%>" class="favoriteAct <%=chkiif(oPictureDiary.FItemList(i).Fchkfav > 0 ,"myFavor","")%>" <% If loginuserid <> "" Then %>onclick="TnAddPlaymywish('<%=playcode%>','<%= oPictureDiary.FItemList(i).Fidx %>','<%= oPictureDiary.FItemList(i).Fviewno %>');"<% Else %>onclick="jsChklogin();"<% End If %>><strong><%= FormatNumber(oPictureDiary.FItemList(i).Ffavcnt,0) %></strong></div></div>
	</div>
	<% Next %>
</div>
<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New(CurrPage,oPictureDiary.FTotalCount,PageSize,10,"jsGoPage") %></div>
<div id="tempdiv" style="display:none" ></div>
<% End If %>
<%
	Set oPictureDiary = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->