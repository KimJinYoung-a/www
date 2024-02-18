<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  위시리스트 이벤트
' History : 2018-11-01 최종원 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/etc/wishlist/UserWisheventCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim eCode, userid, orderoption, pagereload, vreturnurl, isParticipation
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "89181"
Else
	eCode   =  "90144"
End If

vreturnurl = Request.ServerVariables("url") &"?"&Request.ServerVariables("QUERY_STRING")

userid = GetEncLoginUserID()

Dim page, i, y
page = request("page")
orderoption = request("orderoption")
pagereload	= requestCheckVar(request("pagereload"),2)

if orderoption = "" then
	orderoption = 1
end if

If page = "" Then 
page = 1
end if
%>

<%
dim userWishFolderO
set userWishFolderO = new UserWishFolder

	userWishFolderO.FPageSize	= 6
	userWishFolderO.FCurrPage	= page	
	userWishFolderO.Frectuserid = userid
	userWishFolderO.FRectOrderOption = orderoption
	userwishfoldero.GetUserFolderList()		
	userwishfoldero.GetUsersFolderList()
	isParticipation = userwishfoldero.isParticipatedUser(userid)	
%>
<%
Function fnDisplayPaging_New(strCurrentPage, intTotalRecord, intRecordPerPage, intBlockPerPage, strJsFuncName)
	'변수 선언
	Dim intCurrentPage, strCurrentPath, vPageBody
	Dim intStartBlock, intEndBlock, intTotalPage
	Dim strParamName, intLoop

	'현재 페이지 설정
	intCurrentPage = strCurrentPage		'현재 페이지 값

	'해당페이지에 표시되는 시작페이지와 마지막페이지 설정
	intStartBlock = Int((intCurrentPage - 1) / intBlockPerPage) * intBlockPerPage + 1
	intEndBlock = Int((intCurrentPage - 1) / intBlockPerPage) * intBlockPerPage + intBlockPerPage

	'총 페이지 수 설정
	intTotalPage =   int((intTotalRecord-1)/intRecordPerPage) +1
	''eastone 추가
	if (intTotalPage<1) then intTotalPage=1

	vPageBody = ""
	strJsFuncName = trim(strJsFuncName)

	vPageBody = vPageBody & "<div class=""paging"">" & vbCrLf

	'## 이전 페이지
	If intStartBlock > 1 Then
		vPageBody = vPageBody & "	<button class=""prev"" onclick=""" & strJsFuncName & "(" & intStartBlock-1 & ");return false;""><img src="""" alt=""이전페이지로 이동""></button>" & vbCrLf
	Else
		vPageBody = vPageBody & "	<button class=""prev"" onclick=""return false;""><img src="""" alt=""이전페이지로 이동""></button>" & vbCrLf
	End If

	'## 현재 페이지
	If intTotalPage > 1 Then
		For intLoop = intStartBlock To intEndBlock
			If intLoop > intTotalPage Then Exit For
			If Int(intLoop) = Int(intCurrentPage) Then
				vPageBody = vPageBody & "	<a href=""#"" title=""" & intLoop & " 페이지"" class=""current"" onclick=""" & strJsFuncName & "(" & intLoop & ");return false;""><span style=""cursor:pointer;"">" & intLoop & "</span></a>" & vbCrLf
			Else
				vPageBody = vPageBody & "	<a href=""#"" title=""" & intLoop & " 페이지"" onclick=""" & strJsFuncName & "(" & intLoop & ");return false;""><span style=""cursor:pointer;"">" & intLoop & "</span></a>" & vbCrLf
			End If
		Next
	Else
		vPageBody = vPageBody & "	<a href=""#"" title=""1 페이지"" class=""current"" onclick=""" & strJsFuncName & "(1);return false;""><span style=""cursor:pointer;"">1</span></a>" & vbCrLf
	End If

	'## 다음 페이지
	If Int(intEndBlock) < Int(intTotalPage) Then	'####### 다음페이지
		vPageBody = vPageBody & "	<button class=""next"" onclick=""" & strJsFuncName & "(" & intEndBlock+1 & ");return false;""><span style=""cursor:pointer;""><img src="""" alt=""다음 페이지로 이동""></button>" & vbCrLf
	Else
		vPageBody = vPageBody & "	<button class=""next"" onclick=""return false;""><span style=""cursor:pointer;""><img src="""" alt=""다음 페이지로 이동""></button>" & vbCrLf
	End If	

	vPageBody = vPageBody & "</div>" & vbCrLf

	fnDisplayPaging_New = vPageBody
End Function    
%>
<style type="text/css">
.evt90144 button{border:0 none;background-color:transparent;background:none;cursor:pointer;} 
.evt90144 button::-moz-focus-inner, input::-moz-focus-inner { border: 0; padding: 0; }
.evt90144 button:focus{ outline: none}
.evt90144 *{box-sizing: border-box;}
.evt90144 {background:url('http://webimage.10x10.co.kr/fixevent/event/2018/90144/bg_img.png?v=1.03') 50% 0 #ffb6b8; height: 3175px;}
.evt90144 .top-area{position: relative;}
.evt90144 .top-area dt,
.evt90144 .top-area dd{position: absolute; top: 0; left: calc(50% + -153px);}
.evt90144 .top-area dt{position: absolute; top: 99px; opacity: 0; animation: show .8s both 1 ;}
.evt90144 .top-area dd{position: absolute; top: 194px; opacity: 0; animation: show .8s .8s both 1 ;}
.evt90144 .top-area button{position: absolute; top: 410px; left: calc(50% - 226px); animation: moveX .8s infinite ease-in-out;}
.evt90144 .top-area span{position: absolute; top: 80px; left: calc(50% + 280px); animation: bounce2 1s 100 ease-in-out;}
.evt90144 .cont{position: absolute; top: 790px; width: 930px; left: calc(50% - 470px);}
.evt90144 .cont .sort{position: absolute; top:-55px; right: -7px;}
.evt90144 .cont .sort a{display: inline-block; width: 64px; height: 45px; text-indent: -9999px; background-image: url('http://webimage.10x10.co.kr/fixevent/event/2018/90144/btn_order.png?v=1.01'); background-position-y: 100%;}
.evt90144 .cont .sort a:last-child{background-position-x: 100%; } 
.evt90144 .cont .sort a.active{background-position-y: 0;}
.evt90144 .cont li{border-bottom: 1px solid #e7dfdf; text-align: left; padding:50px 0 50px 20px;}
.evt90144 .cont li:last-child{border-bottom: 0;}
.evt90144 .cont li span{*zoom:1; display: inline-block; vertical-align: top; } 
.evt90144 .cont li span:after{clear:both;display:block;content:'';}
.evt90144 .cont li span a{display: block; background-color: #fedcdc; width: 220px; height: 220px; overflow: hidden; float: left; margin-right: 20px;}
.evt90144 .cont li div{font-family: AppleSDGothicNeo; font-size: 14px; text-align: left; width: 180px; display: inline-block; height: 220px; padding: 43px 0 0 10px; color: #000;}
.evt90144 .cont li div b{font-family: verdana; font-weight: 600; position: relative;}
.evt90144 .cont li div b.vvip:before{content: ''; display: block; width: 63px; height: 29px; background-image: url('http://webimage.10x10.co.kr/fixevent/event/2018/90144/ico_vvip.png'); position: absolute; top:-37px; left:-7px; }
.evt90144 .cont li div p{font-family: verdana; font-weight: 600; font-size: 13px; color: #505050; margin:2px 0 32px;}
.evt90144 .cont li.joined div{position: relative;}
.evt90144 .cont li.joined div span{position: absolute; top: 10px;}
.evt90144 .cont li.joined div b.vvip:before{top:-45px; left:123px}
.evt90144 .cont .paging{margin-top: 15px;}
.evt90144 .cont .paging a{border: none; background: none; font-family: 'Verdana'; font-weight: bold; color: #de7678; width: 28px; height: 26px; margin: 0 5px;}
.evt90144 .cont .paging a span{font-size: 12px; color: #de7678;}
.evt90144 .cont .paging a.current,
.evt90144 .cont .paging a.current:hover,
.evt90144 .cont .paging a:hover{background-color: unset; border: 0;}
.evt90144 .cont .paging a.current span,
.evt90144 .cont .paging a.current:hover span,
.evt90144 .cont .paging a:hover span{ background-image: url('http://webimage.10x10.co.kr/fixevent/event/2018/90144/pagination.png');  color: #fff; height: 100%;}
.evt90144 .cont .paging .prev,
.evt90144 .cont .paging .next{background: url('http://webimage.10x10.co.kr/fixevent/event/2018/90144/btn_prev.png') 50% 50% no-repeat; vertical-align: middle; margin: 0 20px; width: 20px; text-indent: -9999px }
.evt90144 .cont .paging .next{transform: rotateY(180deg)}
.evt90144 .notice{font-size:13px; line-height: 23px; font-family: "malgun Gothic","맑은고딕", Dotum, "돋움", sans-serif; color: #fff; text-align:left; position: absolute; text-align: left; bottom: 77px; left: calc(50% - 90px);}

#lyrSch .layer {top:160px; left:calc(50% - 272px); width:545px; height: 520px; background-color:#fff; border-radius:16px;padding:63px 0 43px;}
#lyrSch .layer h3{margin:0 auto 22px}
#lyrSch .layer a{margin:auto}
.layer-popup {display:none; position:absolute; left:0; top:0; z-index:9997; width:100%; height:100%;}
.layer-popup .layer {overflow:hidden; position:absolute;z-index:99999;}
.layer-popup a.close{position: absolute; top:30px; right: 30px;}
.layer-popup button{position: absolute; bottom: 50px; left: calc(50% - 127px);}
.layer-popup .mask {display:block; position:absolute; left:0; top:0; z-index:9998; width:100%; height:100%; background:rgba(0,0,0,.5);}
.layer-popup .popHeader{background-color:#d50c0c; width: 467px; margin: 0 auto 30px; height: 68px; padding-top: 24px;}
.layer-popup .popHeader h1{text-align: left; padding-left:15px}
.layer-popup .folderList {width: 407px; max-height: 150px; margin: 0 auto; position: relative; overflow-y: auto; border-top: 2px solid #555; border-bottom: 1px solid #ddd; background: #f9f9f9;}
.layer-popup .folderList li {text-align:left; height: 49px; padding: 15px 20px 14px; border-top: 1px solid #ddd; }
@keyframes bounce2 {from, to{transform:translateY(0);} 50%{transform:translateY(10px)}}
@keyframes moveX {from, to{transform:translateX(0);}	50%{transform:translateX(5px)}}
@keyframes show {from {opacity: 0;}	 to {opacity: 1;}}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function() {	
	<% if pagereload <> "" then%>
	window.parent.$('html,body').animate({scrollTop:$('#cont').offset().top}, 0);
	<% end if %>			
	$('.layer-popup .close').click(function(){
		$('.layer-popup').fadeOut();
	});
	$('.layer-popup .mask').click(function(){
		$('.layer-popup').fadeOut();
	});    
});    
</script>
<script>
function addViewCnt(idx){
	var str = $.ajax({
		type: "GET",
		url:"/event/etc/wishlist/doWishEvtProc.asp",
		data: "idx="+idx,
		dataType: "text",
		async: false
	}).responseText;	
}
function fnViewUserWish(userid, idx){
	addViewCnt(idx);
	var frm = document.frmsearch;
	frm.action = "/my10x10/mywishlist.asp"
	frm.wishsearch.value = userid
	frm.submit();	
}
function setItemCnt(cnt){
	var frm = document.frm;	
	var result;
	frm.itemCnt.value = cnt;	
}
function chkItemCnt(){
	var frm = document.frm;		
	result = true;
	if(frm.itemCnt.value < 4){
		result = false;
	}	
	return result;	
}
function shareWishFolder(){
	<% If not IsUserLoginOK() Then %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% else %>	
        <% if userWishFolderO.FUfolderTotalCount = 0 then %>
        alert("위시리스트 폴더가 없습니다. 폴더를 생성해주세요.");
        return false;
        <% end if %>    	
	$('#lyrSch').fadeIn();
	window.parent.$('html,body').animate({scrollTop:$('#lyrSch').offset().top}, 800);	
	<% end if %>
}
function fnShare(){
	var frm = document.frm;
	if(!chkItemCnt()){
		alert("위시리스트에 상품을 4개 이상\n담아주셔야 공유 가능합니다!");
		return false;
	}
	<% If IsUserLoginOK() Then %>
		<% If Now() > #11/11/2018 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If Now() > #11/02/2018 00:00:00# and Now() < #11/11/2018 23:59:59# Then %>				
				frm.action="/event/etc/wishlist/doWishEvtProc.asp";				
				frm.submit();
			<% Else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% End If %>
		<% End If %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End If %>	
}
function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}
function fnSort(sortmet){
	document.location.href="/event/eventmain.asp?eventid=<%=eCode%>&pagereload=ON&orderoption="+sortmet
}
function pagedown(){	
	window.$('html,body').animate({scrollTop:$("#lyrSch").offset().top}, 0);
}
</script>
                <div class="eventContV15 tMar15">
                    <!-- event area(이미지만 등록될때 / 수작업일때) -->
                    <div class="contF contW">
                        <div class="evt90144">
                            <div class="top-area">
                                <dl>
                                    <dt><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90144/txt_wish_on.png" alt=""></dt>
                                    <dd><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90144/txt_list_on.png" alt=""></dd>
                                </dl>
								<% if isParticipation then %>
									<button class="wishgo" type="button" onclick="return false;"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90144/btn_off.png" alt="내 위시 공유 완료!"></button>								
								<% else %>
									<button class="wishgo" type="button" onclick="shareWishFolder();"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90144/btn_on.png" alt="위시리스트 공유하기"></button>
								<% end if %>
                                <span><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90144/bnr_img.png" alt="추첨을 통해 20분에게 기프트 카드를 드립니다!"></span>
                            </div>
							<% if userWishFolderO.FResultCount > 0 then %>
                            <div class="cont" id="cont">
                                <div class="sort">
                                    <a href="javascript:fnSort(1);" class="<%=chkIIF(orderoption=1, "active", "")%>">인기순</a>
                                    <a href="javascript:fnSort(2);" class="<%=chkIIF(orderoption=2, "active", "")%>">최신순</a>
                                </div>
                                <ul>
								<% 
								dim itemArr, itemImg, itemId, vUserid, vFidx, testobj, vViewCnt, vIdx, isVVIP, myBtnImg, isMyWish, joinImg, myId
								set testobj = new UserWishFolder
								For i = 0 to userWishFolderO.FResultCount -1 
								vUserid = userWishFolderO.FItemList(i).Fuserid
								vFidx = userWishFolderO.FItemList(i).Ffidx 	
								vViewCnt = userWishFolderO.FItemList(i).Fviewcnt	
								vIdx = userWishFolderO.FItemList(i).Fidx	
								itemArr = userWishFolderO.GetMyItems(vUserid,vFidx)
								isVVIP = chkIIF(userWishFolderO.FItemList(i).Fuserlevel = 4, " class=""vvip""", "") 	
								isMyWish = (vUserid = userid)
								joinImg = chkIIF(isMyWish, " class=""joined""", "")
								myBtnImg = chkIIF(isMyWish, "http://webimage.10x10.co.kr/fixevent/event/2018/90144/btn_more_on.png", "http://webimage.10x10.co.kr/fixevent/event/2018/90144/btn_more.png") 																
								myId = chkIIF(isMyWish, vUserid, printUserId(vUserid,2,"*"))
								%>									
                                    <li <%=joinImg%>>
                                        <span>										
											<% if isArray(itemArr) then %>	
												<% for y=0 to uBound(itemArr,2) %>											
													<a href="/shopping/category_prd.asp?itemid=<%=itemArr(0,y)%>" onclick="addViewCnt(<%=vIdx%>);"><img src="<%=getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(itemArr(0,y))&"/"&itemArr(1,y),240,240,"true","false")%>" alt=""></a>
												<% next %>	
											<% end if %>									
                                        </span>
                                        <div>
                                            <!-- for dev msg :  공유 전 아이디 뒤에 별 **  / 공유 후에 내 위시 노출될 때, 본인 아이디는 **표시 X  -->
											<% if isMyWish then %><span><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90144/txt_wishok.png" alt=""></span><% end if %>											
                                            <b <%=isVVIP%>><%=myId%></b>님의 위시
                                            <p>view <em><%=FormatNumber(vViewCnt, 0)%></em></p>
                                            <button type="button" onclick="fnViewUserWish('<%=vUserid%>', <%=vIdx%>);"><img src="<%=myBtnImg%>" alt=""></button>
                                        </div>
                                    </li>								
								<% next %>
                                </ul>
								<div class="pageWrapV15">
									<%= fnDisplayPaging_New(page,userWishFolderO.FTotalCount,6,10,"jsGoPage") %>
								</div>													
                            </div>
							<% end if %>
                            <div class="notice">
                                · 본 이벤트는 하나의 ID당 1번 응모 가능합니다. <br />
                                · 당첨자는 20명으로, 11월 12일 공지사항을 통해 발표합니다.<br />
                                · 공개 설정되어있는 위시리스트 폴더에 총 4가지 이상의 상품을 담아주셔야 응모가 가능합니다<br />
                                · 기프트카드는 11월 19일에 일괄 지급될 예정입니다.
                            </div>
                            <!-- 레이어 -->
                            <div id="lyrSch" class="layer-popup">
                                <div class="layer">
									<form name="frm" method="post">
									<input type="hidden" name="eventid" value="<%=eCode%>">
									<input type="hidden" name="returnurl" value="<%=vreturnurl%>">
									<input type="hidden" name="itemCnt" value="">
                                    <h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90144/pop_txt.png" alt="공유할 폴더를 선택해주세요"></h3>
                                    <div class="popHeader">
                                        <h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_wish_folder.gif" alt="위시 폴더"></h1>
                                    </div>
                                    <div class="folderList">
									<% if userid <> "" then %>
                                        <ul>										
										<% if userWishFolderO.FUfolderTotalCount > 0 then %>
											<% For i = 0 to userWishFolderO.FUfolderTotalCount -1  %>
												<li><span><input type="radio" onChange="setItemCnt(<%=userWishFolderO.FFolderItemList(i).FUitemCnt%>);" name="selfidx" value="<%=userWishFolderO.FFolderItemList(i).FUfidx%>" class="check"> <label for=""><%=userWishFolderO.FFolderItemList(i).FUfoldername%>(<%=userWishFolderO.FFolderItemList(i).FUitemCnt%>)</label></span>
												<% if userWishFolderO.FFolderItemList(i).FUviewisusing = "Y" then %>
												<img src="http://fiximage.10x10.co.kr/web2013/common/ico_open.gif" alt="공개">
												<% end if %>													
												</li>											
											<% next %>
										<% end if %>
                                        </ul>
									<% end if %>	
                                    </div>
                                    <button class="layer-btn" type="button" onclick="fnShare();"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90144/pop_btn.png" alt="위시 공유하기" /></button>
                                    <a href="javascript:void(0);" class="close"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90144/pop_btn_close.png" alt="닫기"></a>
									</form>
                                </div>
                                <div class="mask"></div>
                            </div>
                        </div>
                    </div>
                    <!-- //event area(이미지만 등록될때 / 수작업일때) -->
                </div>				
<form name="frmsearch" method="post">
<input type="hidden" name="wishsearch" value="">
</form>				
<form name="pageFrm" method="get" action="/event/eventmain.asp?eventid=<%=eCode%>">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="pagereload" value="ON">
	<input type="hidden" name="page" value="">				
	<input type="hidden" name="orderoption" value="<%=orderoption%>">					
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->