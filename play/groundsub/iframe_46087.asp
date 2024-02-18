<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'#### 2013-10-11이종화 작성 ###################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  20982
Else
	eCode   =  46087
End If

dim com_egCode, bidx
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	'그룹 번호(엣지1, 초식2, 연하3)

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 16		'한 페이지의 보여지는 열의 수
	iCPerCnt = 10		'보여지는 페이지 간격

	'선택범위 리플개수 접수
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iSelTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	'코멘트 데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
	$(function(){
		var wrapHeight = $(".socksManual").innerHeight();

		$(".socksManual .pic area").click(function(e){
			e.preventDefault();
			var sNum = parseInt($(this).attr("alt"))+1;

			// 슬라이드 내용 구성
			$("#socksLyr").empty().html($("#socksLyrOrg").html());
			$('#socksLyr .slide').slidesjs({
				height:'440px',
				navigation: {
					effect: "fade"
				},
				play: {
					interval:3000,
					effect: "fade"
				},
				start:sNum
			});

			//modal창 띄움
			$(".socksManual .pic").append("<div class='dimmed'></div>");
			$(".dimmed").css("height",wrapHeight);
			$(".viewSock").show();

			//modal 닫기
			$(".closeBtn").one("click",function(){
				$(".dimmed").remove();
				$(".viewSock").hide();
			});
		});
	});
</script>
<script type="text/javascript">
<!--
 	function jsGoComPage(iP){
		document.frmcom.iCC.value = iP;
		document.frmcom.iCTot.value = "<%=iCTotCnt%>";
		document.frmcom.submit();
	}

	function jsSubmitComment(frm){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

	   if(!(frm.spoint[0].checked||frm.spoint[1].checked||frm.spoint[2].checked||frm.spoint[3].checked)){
	    alert("이미지를 선택해주세요");
	    return false;
	   }

	   if(!frm.txtcomm.value||frm.txtcomm.value=="최대 50자 입력가능"){
	    alert("코멘트를 입력해주세요");
		document.frmcom.txtcomm.value="";
	    frm.txtcomm.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.txtcomm.value)>50){
			alert('최대 50자 입력가능');
	    frm.txtcomm.focus();
	    return false;
		}

	   frm.action = "/event/lib/comment_process.asp";
	   return true;
	}

	function jsDelComment(cidx)	{
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
	   		document.frmdelcom.submit();
		}
	}

	function jsChklogin11(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.txtcomm.value =="최대 50자 입력가능"){
				document.frmcom.txtcomm.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChkUnblur()
	{
		if(document.frmcom.txtcomm.value ==""){
			document.frmcom.txtcomm.value="최대 50자 입력가능";
		}
	}

	function Limit(obj)
	{
	   var maxLength = parseInt(obj.getAttribute("maxlength"));
	   if ( obj.value.length > maxLength ) {
		alert("최대 50자 입력가능");
		obj.value = obj.value.substring(0,maxLength); //100자 이하 튕기기
		}
	}

//-->
</script>
<style type="text/css">
.groundCont {min-width:1140px; background:#fce275 url(http://webimage.10x10.co.kr/play/ground/20131014/bg_socks_gr_area.jpg) center top no-repeat; background-size:100% 288px;}
.groundCont .grArea {background:#fff;}
.groundCont .tagView {padding:60px 20px;}
.playGr1014 {width:1100px; margin:0 auto; padding-top:20px;}
.playGr1014 .socksCmt {width:1050px; margin:0 auto; padding-bottom:50px; background:#fffae2;}
.playGr1014 .socksCmt .selectSocks {overflow:hidden; width:867px; padding-left:183px; background:url(http://webimage.10x10.co.kr/play/ground/10_14/10_14_cmt_bg_01.jpg) center top no-repeat;}
.playGr1014 .socksCmt .selectSocks li {float:left; padding-right:116px; text-align:center;}
.playGr1014 .socksCmt .selectSocks li label {display:block; margin-bottom:15px;}
.playGr1014 .socksCmt .writeCmt {position:relative; overflow:hidden; width:922px; height:62px; padding:4px; margin:30px auto 0; background:#ffb55e;}
.playGr1014 .socksCmt .writeCmt textarea {float:left; display:block; border:0; width:728px; height:32px; padding:25px 20px 5px; font-size:12px; color:#777; vertical-align:top;}
.playGr1014 .socksCmt .writeCmt .enroll {position:absolute; right:0; top:0;}
.playGr1014 .socksCmtList {overflow:hidden; margin:0 auto; width:1035px; padding:0 0 0 15px;}
.playGr1014 .socksCmtList ul {overflow:hidden; width:1040px; margin-bottom:30px;}
.playGr1014 .socksCmtList li {float:left; width:178px; height:154px; padding:30px; margin:30px 20px 0 0; line-height:18px; background-position:30px 30px; background-repeat:no-repeat;}
.playGr1014 .socksCmtList li.socks01 {border:1px solid #f98819; background-image:url(http://webimage.10x10.co.kr/play/ground/10_14/10_14_socks_bg_01.jpg);}
.playGr1014 .socksCmtList li.socks02 {border:1px solid #7cca9c; background-image:url(http://webimage.10x10.co.kr/play/ground/10_14/10_14_socks_bg_02.jpg);}
.playGr1014 .socksCmtList li.socks03 {border:1px solid #f5aebb; background-image:url(http://webimage.10x10.co.kr/play/ground/10_14/10_14_socks_bg_03.jpg);}
.playGr1014 .socksCmtList li.socks04 {border:1px solid #8698d5; background-image:url(http://webimage.10x10.co.kr/play/ground/10_14/10_14_socks_bg_04.jpg);}
.playGr1014 .socksCmtList li.socks01 .writer {color:#f98819;}
.playGr1014 .socksCmtList li.socks02 .writer {color:#7cca9c;}
.playGr1014 .socksCmtList li.socks03 .writer {color:#f5aebb;}
.playGr1014 .socksCmtList li.socks04 .writer {color:#8698d5;}
.playGr1014 .socksCmtList li .writer {text-align:right; height:57px; padding-top:7px;}
.playGr1014 .socksCmtList li .txt {padding-top:25px;}
.playGr1014 .paging{width:1100px; margin:0 auto; padding-bottom:50px; border-bottom:1px solid #ddd;}
.playGr1014 .socksManual {position:relative; width:1050px; height:680px; margin:25px auto 20px;}
.playGr1014 .closeBtn {position:absolute; right:8px; top:10px; cursor:pointer;}
.playGr1014 .socksManual .pic {position:relative;}
.playGr1014 .viewSock {display:none; position:absolute; left:50%; top:50%; z-index:100; width:450px; height:440px; margin-left:-225px; margin-top:-220px;}
.playGr1014 .slide {position:relative; width:450px; height:440px;}
.playGr1014 .slidesjs-container {width:450px; height:440px;}
.playGr1014 .slide .slidesjs-navigation {position:absolute; top:50%; z-index:50; width:29px; height:44px; margin-top:-22px; text-indent:-999em;}
.playGr1014 .slide .slidesjs-previous {left:10px; background:url(http://webimage.10x10.co.kr/play/ground/20131021/btn_prev.png) left top no-repeat;}
.playGr1014 .slide .slidesjs-next {right:10px; background:url(http://webimage.10x10.co.kr/play/ground/20131021/btn_next.png) left top no-repeat;}
.dimmed {position:absolute; top:0; left:0; width:100%; height:100%; z-index:10; background:url(http://webimage.10x10.co.kr/play/ground/20131021/bg_mask.png);}

.pageWrapV15 {width:1040px; margin:0 auto;}
</style>
<div class="playGr1014">
	<div class="playSocks">
		<div class="socksManual">
			<div class="pic">
				<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_play_socks.jpg" alt="" usemap="#playSocksPic" />
				<map name="playSocksPic" id="playSocksPic">
					<area shape="rect" coords="0,0,146,168" href="#socksLyr01" onfocus="this.blur();" alt="0" />
					<area shape="rect" coords="150,0,297,168" href="#socksLyr02" onfocus="this.blur();" alt="1" />
					<area shape="rect" coords="300,0,448,169" href="#socksLyr03" onfocus="this.blur();" alt="2" />
					<area shape="rect" coords="450,0,599,507" href="#socksLyr04" onfocus="this.blur();" alt="3" />
					<area shape="rect" coords="601,0,747,171" href="#socksLyr05" onfocus="this.blur();" alt="4" />
					<area shape="rect" coords="750,1,896,169" href="#socksLyr06" onfocus="this.blur();" alt="5" />
					<area shape="rect" coords="900,0,1047,167" href="#socksLyr07" onfocus="this.blur();" alt="6" />
					<area shape="rect" coords="0,170,148,337" href="#socksLyr08" onfocus="this.blur();" alt="7" />
					<area shape="rect" coords="151,170,297,338" href="#socksLyr09" onfocus="this.blur();" alt="8" />
					<area shape="rect" coords="301,171,448,339" href="#socksLyr10" onfocus="this.blur();" alt="9" />
					<area shape="rect" coords="900,172,1048,338" href="#socksLyr11" onfocus="this.blur();" alt="10" />
					<area shape="rect" coords="0,341,146,507" href="#socksLyr12" onfocus="this.blur();" alt="11" />
					<area shape="rect" coords="150,341,447,507" href="#socksLyr13" onfocus="this.blur();" alt="12" />
					<area shape="rect" coords="900,340,1046,507" href="#socksLyr14" onfocus="this.blur();" alt="13" />
					<area shape="rect" coords="1,511,146,678" href="#socksLyr15" onfocus="this.blur();" alt="14" />
					<area shape="rect" coords="151,512,298,677" href="#socksLyr16" onfocus="this.blur();" alt="15" />
					<area shape="rect" coords="301,511,448,678" href="#socksLyr17" onfocus="this.blur();" alt="16" />
					<area shape="rect" coords="451,511,597,678" href="#socksLyr18" onfocus="this.blur();" alt="17" />
					<area shape="rect" coords="600,511,746,676" href="#socksLyr19" onfocus="this.blur();" alt="18" />
					<area shape="rect" coords="749,511,1047,676" href="#socksLyr20" onfocus="this.blur();" alt="19" />
				</map>
			</div>
			<div id="socksLyr" class="viewSock"></div>
			<div id="socksLyrOrg" style="display:none;">
				<div class="slide" id="lyrSlide">
					<div id="socksLyr01" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img01.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr02" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img02.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr03" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img03.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr04" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img04.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr05" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img05.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr06" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img06.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr07" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img07.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr08" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img08.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr09" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img09.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr10" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img10.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr11" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img11.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr12" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img12.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr13" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img13.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr14" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img14.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr15" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img15.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr16" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img16.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr17" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img17.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr18" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img18.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr19" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img19.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
					<div id="socksLyr20" class="socksWindow">
						<img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_layer_img20.jpg" alt="" />
						<p class="closeBtn"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_btn_close.png" class="pngFix" alt="닫기" /></p>
					</div>
				</div>
			</div>
		</div>
		<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
		<input type="hidden" name="iCTot" value="">
		<input type="hidden" name="mode" value="add">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
		<div class="socksCmt">
			<p><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_cmt_img_01.jpg" alt="양말로 할 수 있는 이야기를 들려주세요" /></p>
			<ul class="selectSocks">
				<li>
					<label for="socks01"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_socks_img_01.png" alt="socks1" class="pngFix" /></label>
					<input type="radio" id="socks01" name="spoint" value="1"/>
				</li>
				<li>
					<label for="socks02"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_socks_img_02.png" alt="socks2" class="pngFix" /></label>
					<input type="radio" id="socks02" name="spoint" value="2"/>
				</li>
				<li>
					<label for="socks03"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_socks_img_03.png" alt="socks3" class="pngFix" /></label>
					<input type="radio" id="socks03" name="spoint" value="3"/>
				</li>
				<li>
					<label for="socks04"><img src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_socks_img_04.png" alt="socks4" class="pngFix" /></label>
					<input type="radio" id="socks04" name="spoint" value="4"/>
				</li>
			</ul>
			<div class="writeCmt">
				<textarea cols="" rows="3" name="txtcomm"  maxlength="50" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onblur="jsChkUnblur()" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');return Limit(this);" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%>  value="최대 50자 입력가능" autocomplete="off">최대 50자 입력가능</textarea>
				<input type="image" class="enroll" src="http://webimage.10x10.co.kr/play/ground/10_14/10_14_cmt_btn_enroll.jpg" alt="코멘트입력" />
			</div>
		</div>
		</form>
		<form name="frmdelcom" method="post" action="/event/lib/comment_process.asp" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="Cidx" value="">
		<input type="hidden" name="mode" value="del">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
		</form>
		<% IF isArray(arrCList) THEN %>
		<div class="socksCmtList">
			<ul>
				<%For intCLoop = 0 To UBound(arrCList,2)%>
				<li class="socks0<%=arrCList(3,intCLoop)%>">
					<p class="writer"><strong>NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></strong><br /><%=printUserId(arrCList(2,intCLoop),2,"*")%>님</p>
					<p class="txt"><%=db2html(arrCList(1,intCLoop))%>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<a href="javascript:jsDelComment('<% = arrCList(0,intCLoop) %>')"><img src="http://fiximage.10x10.co.kr/web2009/common/cmt_del.gif" width="19" height="11" style="padding-left:5px;" border="0"></a>
					<% end if %>
					</p>
				</li>
				<% Next %>
			</ul>
		</div>
		<% End If %>
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->