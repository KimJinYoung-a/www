<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2019.03.19 정태훈
'	Description : culturestation 메인
'#######################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : Culture Station"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/culturestation/culturestation_class.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
	'// 이벤트 목록 접수
	dim oevent , i, chkBig, bnrImg
	dim page, etype, sortMtd, mylist
	page = getNumeric(requestCheckVar(request("page"),5))
	etype = getNumeric(requestCheckVar(request("etype"),1))
	sortMtd = requestCheckVar(request("sort"),3)
	mylist = requestCheckVar(request("mylist"),1)
	if page="" then page=1
'	if etype="" then etype="0"
	if sortMtd="" then sortMtd="new"

	set oevent = new cevent_list
	oevent.FCurrPage = page
	oevent.FPageSize = 20		'한페이지 16개 (추가 접수는 18개)
	oevent.frectevt_type = etype
	oevent.frectSrotMtd = sortMtd
	If mylist="Y" Then
	oevent.frectUserid = GetEncLoginUserID()
	End If
	oevent.fevent_list()
%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('.cult-list').masonry({
			itemSelector: ".cult-list .conts",
			columnWidth:1
		});
		$(".cult-conts .cult-list .end-evt" ).prepend( "<p>종료된 <br/ >이벤트입니다 :)</p>" );

		// 스크롤 확인
		var pg = 1;
		$(window).scroll(function(){
			if( $(window).scrollTop()==($(document).height()-$(window).height()) ) {
				pg++;
				var linkurl;
				if($("#more").val()=="Y"){
					linkurl="act_culturestation_event_more.asp";
					$("#page2").val(Number($("#page2").val())+1);
				}else{
					linkurl="act_culturestation_event.asp";
				}
				//alert(linkurl+"?page="+pg+"&page2="+$("#page2").val()+"&etype=<%=etype%>&sort=<%=sortMtd%>&mylist=<%=mylist%>");
				//추가 페이지 접수
				$.ajax({
					url: linkurl+"?page="+pg+"&page2="+$("#page2").val()+"&etype=<%=etype%>&sort=<%=sortMtd%>&mylist=<%=mylist%>",
					cache: false,
					async: false,
					success: function(message) {
						if(message!="") {
							//추가 내용 Import!
							//$('.cultureList .box').last().after(message);
							$str = $(message)
							// 박스 내용 추가
							$('.cult-list').append($str).masonry('appended',$str);
						} else {
							//더이상 자료가 없다면 스크롤 이벤트 종료
							$(window).unbind("scroll");
						}
					}
				});

			}
		});
	});

	function TnSortView(objval){
		location.href="?etype=<%=etype%>&sort="+objval+"&mylist=<%=mylist%>";
	}
</script>
</head>
<body>
<div class="wrap cult-station-v17">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="cult-head">
				<h2><img src="http://fiximage.10x10.co.kr/web2017/culturestation/tit_cult.png" alt="CULTURE STATION" /></h2>
				<p><img src="http://fiximage.10x10.co.kr/web2017/culturestation/txt_cult.png" alt="" /></p>
				<ul class="nav">
					<!-- for dev msg : 선택된 li에 클래스 on 추가해주세요 -->
					<li class="all<%=chkIIF(etype=""," on","")%>"><a href="/culturestation/">전체</a></li>
					<li class="feel<%=chkIIF(etype="0"," on","")%>"><a href="/culturestation/?etype=0&sort=<%=sortMtd%>&mylist=<%=mylist%>">느껴봐</a></li>
					<li class="read<%=chkIIF(etype="1"," on","")%>"><a href="/culturestation/?etype=1&sort=<%=sortMtd%>&mylist=<%=mylist%>">읽어봐</a></li>
				</ul>
			</div>
			<div class="cult-conts">
				<div class="overHidden">
					<% If GetEncLoginUserID() <> "" Then %><a href="/my10x10/myeventmaster.asp" class="evtHistory ftLt"><% Else %><a href="javascript:top.location.href='/login/loginpage.asp?vType=G';" class="evtHistory ftLt"><% End If %>참여한 이벤트 보기 &gt;</a>
					<div class="sortingbar ftRt">
						<input type="hidden" id="page" value="1">
						<input type="hidden" id="page2" value="0">
						<select title="컬쳐이벤트 정렬 옵션" class="optSelect2" onChange="TnSortView(this.value);">
							<option value="new"<%=chkIIF(sortMtd="new"," selected","")%>>최신순</option>
							<option value="fav"<%=chkIIF(sortMtd="fav"," selected","")%> >인기순</option>
							<option value="dl"<%=chkIIF(sortMtd="dl"," selected","")%>>마감임박순</option>
						</select>
					</div>
				</div>
				<div class="cult-list">
				<%
					'// 이벤트 목록 출력
					if oevent.FResultCount>0 then
						for i=0 to oevent.FResultCount-1
				%>
					<div class="conts<%=chkIIF(i=0," main-cult","")%><%=chkIIF(oevent.FItemList(i).fevt_type="0"," feel"," read")%>" onClick="location.href='culturestation_event.asp?evt_code=<%=oevent.FItemList(i).fevt_code%>'"> <!-- for dev msg // 느껴봐(영화,연극,뮤지컬)일 경우 feel / 읽어봐(도서)일 경우 read -->
						<div class="info">
							<div class="thumbnail"><img src="<%=oevent.FItemList(i).fimage_barner2%>" alt="" /></div>
							<div class="des">
								<div class="inner">
									<p class="category"><span><%=chkIIF(oevent.FItemList(i).fevt_type="0","느껴봐","읽어봐")%></span></p>
									<p class="tit"><%=oevent.FItemList(i).fevt_name%></p> <!--for dev msg // 2줄 이상은 말줄임표 -->
									<p class="present"><%=oevent.FItemList(i).fevt_comment%></p>
									<p class="date"><%=formatDate(oevent.FItemList(i).fstartdate,"0000.00.00") & " ~ " & formatDate(oevent.FItemList(i).fenddate,"0000.00.00")%></p>
									<a href="culturestation_event.asp?evt_code=<%=oevent.FItemList(i).fevt_code%>#cmt" class="enter">참여하기</a>
								</div>
							</div>
						</div>
						<div class="summary">
							<span class="label<%=chkIIF(oevent.FItemList(i).fevt_kind="3"," musical","")%>"><%=oevent.FItemList(i).GetKindName%></span><!-- for dev msg // 뮤지컬 일 경우 musical -->
							<span class="present"><%=oevent.FItemList(i).fevt_comment%></span>
							<span class="numCmt"><%=chkIIF(oevent.FItemList(i).fdcount>999,"999+",oevent.FItemList(i).fdcount)%></span>
						</div>
					</div>
				<%
							'// 당첨자발표 박스 출력 (6번째 위치에 고정)
							If i=4 Or (oevent.FResultCount<5 And i=(oevent.FResultCount-1)) Then
								Server.Execute("main_cultureStationBox.asp")
							End If
						Next
					Else
						Response.Write "<center>진행하는 이벤트가 없습니다.</cetner>"
					End If
				%>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
	set oevent = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->