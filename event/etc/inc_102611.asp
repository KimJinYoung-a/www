<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : AGV 이름짓기
' History : 2020.05.12 정태훈 생성
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
dim oItem
dim currenttime
	currenttime =  now()
'	currenttime = #11/10/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  102164
Else
	eCode   =  102611
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if userId="ley330" or userId="greenteenz" or userId="rnldusgpfla" or userId="cjw0515" or userId="thensi7" or userId = "motions" or userId = "jj999a" or userId = "phsman1" or userId = "jjia94" or userId = "seojb1983" or userId = "kny9480" or userId = "bestksy0527" or userId = "mame234" or userid = "corpse2" then
	currenttime = #05/15/2020 09:00:00#
end if

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, pagereload
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	pagereload	= requestCheckVar(request("pagereload"),2)

IF blnFull = "" THEN blnFull = True
IF blnBlogURL = "" THEN blnBlogURL = False

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 9		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 9		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	
	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

dim itemid 
Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style>
.agv-contest {position:relative; overflow:hidden;}
.agv-contest button {background:none;}
.agv-contest .hidden {position:absolute; color:transparent;}
.agv-contest .noti {background:#383838;}

.agv-contest .topic {position:relative; height:647px; background:#f73a3e url(//webimage.10x10.co.kr/fixevent/event/2020/102611/tit_agv.jpg) 50% 0 no-repeat;}
.agv-contest .topic .btn-more {top:470px; left:50%; margin-left:50px; width:100px; height:50px;}
.agv-contest .popup {display:none; position:absolute; top:353px; left:50%; z-index:5; margin-left:-462px; border-radius:48px; box-shadow:35px 5px 35px 0 rgba(0,0,0,0.3);}
.agv-contest .popup .btn-close {top:0; right:0; width:110px; height:110px;}

.agv-contest .info {position:relative; padding-top:1662px; background:#fff3e8 url(//webimage.10x10.co.kr/fixevent/event/2020/102611/txt_info.jpg) 50% 0 no-repeat;}
.agv-contest .info .vod {position:absolute; bottom:134px; left:50%; margin-left:-460px;}
.agv-contest .info .vod iframe {width:920px; height:517px; vertical-align:top;}
.agv-contest .info .btn-play {top:0; left:0; width:100%; height:100%; z-index:5; background:#000 url(//webimage.10x10.co.kr/fixevent/event/2020/102611/img_vod.jpg) center no-repeat;}

.agv-contest .cmt-section {position:relative; background:#f73a3e url(//webimage.10x10.co.kr/fixevent/event/2020/102611/txt_contest.jpg) 50% 0 no-repeat;}
.agv-contest .input-wrap {position:relative; display:flex; width:740px; height:90px; padding-top:588px; margin:0 auto 107px;}
.agv-contest .input-wrap input[type=text] {flex:1; display:block; padding:0 40px; font-size:28px; background:none;}
.agv-contest .input-wrap input[type=text]::-webkit-input-placeholder {color:#d4d4d4;}
.agv-contest .input-wrap input[type=text]:-ms-input-placeholder {color:#d4d4d4;}
.agv-contest .input-wrap input[type=text]::-moz-placeholder {color:#d4d4d4;}
.agv-contest .input-wrap input[type=text]::placeholder {color:#d4d4d4;}
.agv-contest .input-wrap .btn-submit {position:relative; width:180px;}
.agv-contest .cmt-list {width:1180px; margin:0 auto; padding:46px 0 0;}
.agv-contest .cmt-list ul {display:flex; flex-wrap:wrap; justify-content:center;}
.agv-contest .cmt-list li {position:relative; width:362px; height:137px; margin:15px 10px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/102611/bg_name.png) 0 0 no-repeat;}
.agv-contest .cmt-list li .num {position:absolute; top:30px; left:30px; font-weight:500; font-size:16px; color:#da9292;}
.agv-contest .cmt-list li .name {position:absolute; top:60px; left:30px; font-weight:700; font-size:26px; color:#222; text-align:left;}
.agv-contest .cmt-list li .writer {position:absolute; bottom:40px; right:30px; font-size:16px; color:#aeaeae; text-align:right;}
.agv-contest .cmt-list .btn-del {top:25px; right:23px; width:30px; height:30px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/102611/btn_del.png) center no-repeat;}

.pageWrapV15 {padding:50px 0 75px;}
.paging {height:auto;}
.paging a {overflow:visible; height:auto; line-height:normal; border:0 none;}
.paging a.current {position:relative; border:0 none;}
.paging a.current:before {content:' '; position:absolute; top:-10px; left:50%; width:4px; height:4px; margin-left:-2px; background:#fff; border-radius:2px;}
.paging a, .paging a:hover, .paging a.current, .paging a.current:hover, .paging a.arrow {background:none;}
.paging a span {height:auto; padding:0 12px; font-size:20px; color:#ffb2b4;}
.paging a.current span {color:#fff;}
.paging a.arrow {margin:0 20px;}
.paging a.arrow span {width:30px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/102611/ico_page_arrow.png) center no-repeat;}
.paging a.prev span {transform:scaleX(-1);}
.paging a.first, .paging a.end, .pageWrapV15 .pageMove {display:none;}
</style>
<script>
$(function(){
	$('.agv-contest .btn-more').on('click', function(){
		$(this).next('.popup').show();
	});
	$('.agv-contest .popup .btn-close').on('click', function(){
		$(this).closest('.popup').hide();
	});
	$('.agv-contest .info .btn-play').on('click', function(){
		$(this).fadeOut(400);
		$(this).siblings('iframe')[0].contentWindow.postMessage('{"event":"command","func":"' + 'playVideo' + '","args":""}', '*');
	});
});
</script>
<script type="text/javascript">
$(function(){
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#commentlist").offset().top}, 0);
}	

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10) >= "2020-05-15" and left(currenttime,10) < "2020-05-20" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 10){
					alert("이름은 5글자 이내로 지어주세요.");
					frm.txtcomm1.focus();
					return false;
				}
				frm.txtcomm.value = frm.txtcomm1.value
				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}

function jsDelComment(cidx)	{
	if(confirm("삭제하시겠습니까?")){
		document.frmdelcom.Cidx.value = cidx;
   		document.frmdelcom.submit();
	}
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
//			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
//			winLogin.focus();
//			return false;
		}
		return false;
	}
}
</script>

						<div class="evt102611 agv-contest">
							<div class="topic">
								<h2 class="hidden">AGV 이름 짓기 대회</h2>
								<button type="button" class="hidden btn-more" title="AGV란?">AGV란?</button>
								<div class="popup">
									<img src="//webimage.10x10.co.kr/fixevent/event/2020/102611/popup.png" alt="AGV 무인운반로봇 설명">
									<button type="button" class="hidden btn-close" title="닫기">닫기</button>
								</div>
							</div>
							<div class="info">
								<img src="//webimage.10x10.co.kr/fixevent/event/2020/102611/txt_vod.png" alt="AGV 관련영상">
								<div class="vod">
									<iframe src="https://www.youtube.com/embed/KLR84_a3m_E?enablejsapi=1&rel=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
									<button type="button" class="hidden btn-play">재생</button>
								</div>
							</div>
							<div class="cmt-section">
								<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
                                <input type="hidden" name="eventid" value="<%=eCode%>">
                                <input type="hidden" name="com_egC" value="<%=com_egCode%>">
                                <input type="hidden" name="bidx" value="<%=bidx%>">
                                <input type="hidden" name="iCC" value="<%=iCCurrpage%>">
                                <input type="hidden" name="iCTot" value="">
                                <input type="hidden" name="mode" value="add">
                                <input type="hidden" name="spoint" value="0">
                                <input type="hidden" name="isMC" value="<%=isMyComm%>">
                                <input type="hidden" name="pagereload" value="ON">
                                <input type="hidden" name="txtcomm">
                                <div class="input-wrap">
									<input type="text" maxlength="5" placeholder="이름은 5글자 이내로 지어주세요" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();"<%IF NOT(IsUserLoginOK) THEN%> readonly<%END IF%>>
									<button type="button" class="hidden btn-submit" onclick="jsSubmitComment(document.frmcom); return false;">응모하기</button>
								</div>
                                </form>
                                <form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
                                    <input type="hidden" name="eventid" value="<%=eCode%>">
                                    <input type="hidden" name="com_egC" value="<%=com_egCode%>">
                                    <input type="hidden" name="bidx" value="<%=bidx%>">
                                    <input type="hidden" name="Cidx" value="">
                                    <input type="hidden" name="mode" value="del">
                                    <input type="hidden" name="pagereload" value="ON">
                                </form>
                                <% IF isArray(arrCList) THEN %>
								<div class="cmt-list" id="commentlist">
									<ul>
                                        <% For intCLoop = 0 To UBound(arrCList,2) %>
										<li>
											<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %><button type="button" class="hidden btn-del" title="삭제" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;">삭제</button><% end if %>
											<span class="num">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></span>
											<span class="name"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></span>
											<span class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%> 님</span>
										</li>
                                        <% next %>
									</ul>
								</div>
                                <% End If %>
								<div class="pageWrapV15">
									<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
								</div>
							</div>
							<div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2020/102611/txt_noti.png" alt="유의사항"></div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->