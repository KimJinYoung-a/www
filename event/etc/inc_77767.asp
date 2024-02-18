<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  꽃을 든 무민(하나은행제휴 이벤트)
' History : 2017-05-12 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%
	Dim eCode, vQuery, vUserID
	dim mycnt, myname, mycell, myaddr1, myaddr2, mysongjang, myregdate, myaddridx, myzipcode
	mycnt = 0

	IF application("Svr_Info") = "Dev" THEN
		eCode		=  66323
	Else
		eCode		=  77767
	End If

	vUserID = getEncLoginUserID

	dim oUserInfo, vTotalCount2, allcnt
	set oUserInfo = new CUserInfo
		oUserInfo.FRectUserID = vUserID
	if (vUserID<>"") then
		oUserInfo.GetUserData
	end If

	'// 전체 인원수 확인
	vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_temp_event_addr] WHERE evt_code ='"& eCode &"' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		allcnt = rsget(0)
	End If
	rsget.close()

	if vUserID <> "" then
		'// 내 신청내역 확인
		vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_temp_event_addr] WHERE evt_code ='"& eCode &"' and userid='"&vUserID&"' "
		rsget.Open vQuery,dbget,1
		IF Not rsget.Eof Then
			mycnt = rsget(0)
		End If
		rsget.close()
	end if

	if mycnt > 0 Then
		vQuery = "Select top 1 a.username, a.usercell, a.addr1, a.addr2, s.regdate, a.idx, a.zipcode" + vbcrlf
		vQuery = vQuery & " FROM [db_temp].[dbo].[tbl_temp_event_addr] as a" + vbcrlf	
		vQuery = vQuery & " 		join [db_event].[dbo].[tbl_event_subscript] as s " + vbcrlf	
		vQuery = vQuery & " 			on a.userid=s.userid and a.evt_code=s.evt_code " + vbcrlf	
		vQuery = vQuery & " WHERE a.evt_code='" & eCode & "' and a.userid='" & vUserID & "'" + vbcrlf	
		vQuery = vQuery & " order by a.idx desc, s.sub_idx desc " + vbcrlf	
'		response.write vQuery
		rsget.Open vQuery,dbget,1
		IF Not rsget.Eof Then
			myname = rsget(0)
			mycell = rsget(1)
			myaddr1 = rsget(2)
			myaddr2 = rsget(3)
			myregdate = rsget(4)
			myaddridx = rsget(5)
			myzipcode = rsget(6)
		end if
		rsget.Close

		vQuery = "Select top 1 songjangno " + vbcrlf
		vQuery = vQuery & " FROM [db_sitemaster].[dbo].tbl_etc_songjang  " + vbcrlf	
		vQuery = vQuery & " WHERE userid='" & vUserID & "'" + vbcrlf	
		vQuery = vQuery & " 	and gubunname='꽃을 든 무민' and gubuncd=99 and deleteyn='N' " + vbcrlf	
		vQuery = vQuery & " order by id desc " + vbcrlf	
'		response.write vQuery
		rsget.Open vQuery,dbget,1
		IF Not rsget.Eof Then
			mysongjang = rsget(0)
		end if
		rsget.Close
	end if

%>
<style>
.evt77767 {text-align:left; background:#99c84f url(http://webimage.10x10.co.kr/eventIMG/2017/77767/bg_ground.png) 50% 0 no-repeat;}
.inner {position:relative; width:1020px; margin:0 auto;}
.topic {height:260px; padding-top:140px;  text-align:center;}
.topic h2 {padding:23px 0 27px;}
.topic .date {position:absolute; left:50%; top:50px; margin-left:425px;}
.enterCode {width:370px; margin:0 auto; padding:57px 0 60px; text-align:center;}
.enterCode .inpArea {position:relative; overflow:hidden; margin:33px 0 20px; background:#fff;}
.enterCode .inpArea .number {float:left; width:190px; height:56px; padding:3px 30px 0; font-size:19px; font-weight:bold;}
.enterCode .inpArea .number::-input-placeholder {font-size:18px; color:#bbb;}
.enterCode .inpArea .number::-webkit-input-placeholder {font-size:18px; color:#bbb;}
.enterCode .inpArea .number::-moz-placeholder {font-size:18px; color:#bbb;}
.enterCode .inpArea .number:-ms-input-placeholder {font-size:18px; color:#bbb;}
.enterCode .inpArea .number:-moz-placeholder {font-size:18px; color:#bbb;}
.enterCode .inpArea .btnSubmit {float:right;}
.enterCode .soldout {position:absolute; left:0; top:0;}
.addrLayer {padding:50px 0 70px;}
.addrLayer .layerCont {width:730px; margin:0 auto; padding:45px 144px; background-color:#fff;}
.addrLayer table {margin-top:-5px;}
.addrLayer table th {padding-top:20px; vertical-align:top;}
.addrLayer table td input {width:220px; margin-top:20px; padding:0 15px; height:30px; border:1px solid #ddd; color:#888; font-size:12px; line-height:32px;}
.addrLayer table td i {display:inline-block; width:15px; text-align:center; color:#ddd;}
.addrLayer .btnFind {display:inline-block; margin-top:20px; vertical-align:top;}
.process {padding:50px 0 30px; background:#87b341;}
.process h3 {position:absolute; left:0; top:60px;}
.process p {padding-left:260px;}
.process .character {position:absolute; right:74px; top:-90px; width:71px; height:144px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77767/img_moomin.png) 0 0 no-repeat;}
.product {padding:83px 0 55px; background:#7696de url(http://webimage.10x10.co.kr/eventIMG/2017/77767/bg_product.png) 50% 50% no-repeat;}
.product h3 {position:absolute; left:0; top:28px;}
.product p {padding-left:250px;}
.slideTemplateV15 {position:relative; overflow:visible;}
.slideTemplateV15 .slidesjs-pagination {bottom:15px;}
.fullSlide .swiper-wrapper {position:relative; width:960px;}
.fullSlide .swiper-slide img {height:530px;}
.fullSlide .slidesjs-previous {left:20px;}
.fullSlide .slidesjs-next {right:20px;}
.fullSlide .limit {position:absolute; left:50%; top:-43px; margin-left:423px; z-index:30;}
.noti {padding:45px 0 33px; background-color:#777;}
.noti .inner {width:682px; padding-left:252px;}
.noti h3 {position:absolute; left:0; top:50%; margin-top:-13px;}
.noti li {padding:0 0 12px 16px; color:#e5e5e5; font-size:11px; line-height:12px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77767/blt_round.png) 0 2px no-repeat;}
.noti li strong {font-size:12px; color:#fff;}
.noti li em {color:#fff799;}

.applyList {width:960px; margin:0 auto; padding:10px 0 32px; text-align:center; line-height:1;}
.applyList .tit {width:282px; height:34px; margin:0 auto 20px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77767/btn_view.png) 50% 0 no-repeat; text-indent:-999em; cursor:pointer;}
.applyList .view {display:none; padding-bottom:20px;}
.applyList.listOn .tit {background-position:50% 100%;}
.applyList.listOn .view {display:block;}
.applyList table {overflow:hidden; border-radius:18px;}
.applyList th {height:48px;  border-left:1px solid #99c84f; background-color:#6c9a22; vertical-align:middle;}
.applyList td {padding:19px 10px; font-size:12px; line-height:22px; color:#888; border-left:1px solid #ddd; background-color:#fff;}
.applyList table thead th:first-child,.applyList table tbody td:first-child {border-left:0;}
.applyList .btnModify {display:inline-block; width:70px; height:22px; line-height:22px; color:#fff; background:#595858; text-decoration:none;}
.applyList .nodata {padding:48px 0;  background-color:#6c9a22; border-radius:18px;}
</style>
<script>
$(function(){
	$('.fullSlide .swiper-wrapper').slidesjs({
		width:960,
		height:530,
		pagination:{effect:'fade'},
		navigation:{effect:'fade'},
		play:{interval:3000, effect:'fade', auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.fullSlide .swiper-wrapper').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	// 신청내역 확인
	$(".applyList .tit").click(function(){
		$(".applyList").toggleClass("listOn");
	});
	$("#addrLayer").hide();
});

function fnedit() {
	$("#addrLayer").show();
}

function fnitsm(md,amd,maidx) {
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 신청할 수 있습니다.")){
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
		}
		return false;
	<% End If %>
	<% If vUserID <> "" Then %>
		$("#mode").val(md);
		$("#amode").val(amd);
		$("#myaddridx").val(maidx);
		var hncode = $("#hncode").val();
		var username = $("#username").val();
		var reqhp1 = $("#reqhp1").val();
		var reqhp2 = $("#reqhp2").val();
		var reqhp3 = $("#reqhp3").val();
		var txZip = $("#txZip").val();
		var txAddr1 = $("#txAddr1").val();
		var txAddr2 = $("#txAddr2").val();

		if(amd!="edit"){
			if(hncode==""||hncode.length != 11){
	            alert("정확한 코드를 입력해 주세요.");
	            $("#hncode").val('');
	            $("#hncode").focus();
	            return false;
	    	}
		}

		if(md=="frin"){
	        if(isNaN(hncode) == true) {
	            alert("숫자만 입력 가능합니다.");
	            $("#hncode").focus();
	            return false;
	        }
    	}else{
			if(username==""){
	            alert("이름을 입력해 주세요.");
	            $("#hncode").focus();
	            return false;
	    	}

			if(reqhp1==""){
	            alert("휴대폰 번호를 정확히 입력해 주세요");
	            $("#reqhp1").focus();
	            return false;
	    	}

			if(reqhp2==""){
	            alert("휴대폰 번호를 정확히 입력해 주세요");
	            $("#reqhp2").focus();
	            return false;
	    	}
			if(reqhp3==""){
	            alert("휴대폰 번호를 정확히 입력해 주세요");
	            $("#reqhp3").focus();
	            return false;
	    	}
			if(txZip==""){
	            alert("주소찾기를 통해 주소를 입력해 주세요");
	            $("#txZip").focus();
	            return false;
	    	}
			if(txAddr1==""){
	            alert("주소찾기를 통해 주소를 입력해 주세요");
	            return false;
	    	}
			if(txAddr2==""){
	            alert("주소를 입력해 주세요.");
	            $("#txAddr2").focus();
	            return false;
	    	}
	        if(isNaN($("#reqhp1").val()) == true) {
	            alert("전화번호는 숫자만 입력 가능합니다.");
	            $("#reqhp1").focus();
	            return false;
	        }
	        if(isNaN($("#reqhp2").val()) == true) {
	            alert("전화번호는 숫자만 입력 가능합니다.");
	            $("#reqhp2").focus();
	            return false;
	        }
	        if(isNaN($("#reqhp3").val()) == true) {
	            alert("전화번호는 숫자만 입력 가능합니다.");
	            $("#reqhp3").focus();
	            return false;
	        }
    	}
		$("#hanacode").val(hncode);
		var params = jQuery("#frmorder").serialize();
		var reStr;
		$.ajax({
			type: "POST",
			url:"/event/etc/doeventsubscript/doEventSubscript77767.asp",
			data: params,
			dataType: "text",
			async: false,
	        success: function (str) {
	        	reStr = str.split("|");
				if(reStr[0]=="OK"){
					if(reStr[1] == "dn") {
						if(amd=="add"){
							alert('신청이 완료되었습니다.');
							document.location.reload();
							return false;
						}else if(amd=="edit"){
							alert('수정이 완료되었습니다.');
							document.location.reload();
							return false;
						}else{
							document.location.reload();
							return false;
						}
					}else if(reStr[1] == "frin"){
						$("#addrLayer").show();
						$(".enterCode").hide();
					}else{
						alert('오류가 발생했습니다.');
						return false;
					}
				}else{
					errorMsg = reStr[1].replace(">?n", "\n");
					alert(errorMsg);
//					document.location.reload();
					return false;
				}
	        }
		});
	<% End If %>
}

function chgaddr(v){
	var frm = document.frmorder

	if (v == "N")
	{
		frm.reqname.value = "";
		frm.reqhp1.value = "";
		frm.reqhp2.value = "";
		frm.reqhp3.value = "";
		frm.txZip.value = "";
		frm.txAddr1.value = "";
		frm.txAddr2.value = "";
	}else if (v == "R"){
		frm.reqname.value = frm.tmp_reqname.value;
		frm.reqhp1.value = frm.tmp_reqhp1.value;
		frm.reqhp2.value = frm.tmp_reqhp2.value;
		frm.reqhp3.value = frm.tmp_reqhp3.value;
		frm.txZip.value = frm.tmp_txZip.value;
		frm.txAddr1.value = frm.tmp_txAddr1.value;
		frm.txAddr2.value = frm.tmp_txAddr2.value;
	}

}

//'주소찾기
function searchzip(frmName){
	var popwin = window.open('/common/searchzip_new.asp?target=' + frmName, 'searchzip10', 'width=560,height=680,scrollbars=yes,resizable=yes');
	popwin.focus();
}

//'나의 주소록
function PopOldAddress(){
	var popwin = window.open('/my10x10/MyAddress/popMyAddressList.asp','popMyAddressList','width=600,height=300,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function mysongjang(tid){
	var receiptUrl = "http://www.cjgls.co.kr/kor/service/service02_01.asp?slipno="+tid;
	var popwin = window.open(receiptUrl,"app","width=580,height=500,scrollbars=0");
	popwin.focus();
}
</script>
	<!-- 꽃을 든 무민 -->
	<div class="evt77767">
		<div class="flowerMoomin">
			<div class="topic">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_collabo.png" alt="텐바이텐과 하나은행이 함께하는" /></p>
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/tit_flower_moomin.png" alt="꽃을 든 무민" /></h2>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_gift.png" alt="지금 인증번호 입력하고 한정판 무민 코인뱅크 받아가세요!" /></p>
				<span class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_date.png" alt="2017.05.15~06.15" /></span>
			</div>
			<div class="slideTemplateV15 fullSlide">
				<p class="limit"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_limit.png" alt="선착순 3만명" /></p>
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/img_slide_01_v2.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/img_slide_02_v2.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/img_slide_03_v2.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/img_slide_04_v2.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/img_slide_05_v2.jpg" alt="" /></div>
					</div>
					<div class="pagination"></div>
					<button class="slideNav btnPrev">이전</button>
					<button class="slideNav btnNext">다음</button>
					<div class="mask left"></div>
					<div class="mask right"></div>
				</div>
			</div>
			<!-- 인증번호, 배송지 입력 -->
			<div class="enterCode">
				<%'<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_number.png" alt="인증번호를 입력해주세요" /></p>%>
				<div class="inpArea">
					<% if allcnt < 30000 then %>
						<input type="text" id="hncode" name="hncode" value="" maxlength="11" class="number" placeholder="" />
						<%'<button type="button" onclick="fnitsm('frin','',''); return false;" class="btnSubmit"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/btn_submit.png" alt="입력" /></button>%>
					<% end if %>

					<% if allcnt >= 27946 then %>
						<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_soldout.png" alt="한정 수량이 모두 소진되었습니다!" /></p>
					<% end if %>
				</div>
				<p style="line-height:14px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_caution.png" alt="* 본 이벤트는 ID당 한 번만 신청하실 수 있습니다" /></p>
			</div>
			<div id="addrLayer" class="addrLayer">
			<% If oUserInfo.FresultCount >0 Then %>
			<form name="frmorder" id="frmorder" method="post">
			<input type="hidden" name="reqphone1"/>
			<input type="hidden" name="reqphone2"/>
			<input type="hidden" name="reqphone3"/>
			<input type="hidden" id="hanacode" name="hanacode" />
			<input type="hidden" name="mode" id="mode" value=""/>
			<input type="hidden" name="amode" id="amode" value=""/>
			<input type="hidden" name="myaddridx" id="myaddridx" value=""/>
			<input type="hidden" name="tmp_reqname" value="<%=oUserInfo.FOneItem.FUserName%>"/>
			<input type="hidden" name="tmp_reqhp1" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>"/>
			<input type="hidden" name="tmp_reqhp2" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>"/>
			<input type="hidden" name="tmp_reqhp3" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>"/>
			<input type="hidden" name="tmp_txZip" value="<%= oUserInfo.FOneItem.FZipCode %>"/>
			<input type="hidden" name="tmp_txAddr1" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress1) %>"/>
			<input type="hidden" name="tmp_txAddr2" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress2) %>"/>
				<div class="layerCont">
					<h3 class="ct"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/tit_address.png" alt="배송지 주소 확인하기" /></h3>
					<div class="overHidden tPad20">
						<div class="ftLt" style="width:326px;">
							<div class="selectOption">
								<span><input type="radio" id="address01" name="addr" value="1" onclick="chgaddr('R');" checked /> <label for="address01"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_type_01.png" alt="기본 주소" /></label></span>
								<span class="lMar20"><input type="radio" id="address02" name="addr" value="2" onclick="chgaddr('N');"  /> <label for="address02"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_type_02.png" alt="새로 입력" /></label></span>
							</div>
							<table>
								<tbody>
								<tr>
									<th scope="row" style="width:76px;"><label for="username"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_name.png" alt="이름" /></label></th>
									<td style="width:250px;"><input type="text" maxlength="10" id="username" value="<% if myname<>"" then response.write myname else response.write oUserInfo.FOneItem.FUserName end if %>" name="reqname" /></td>
								</tr>
								<tr>
									<th scope="row"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_phone.png" alt="휴대폰" /></th>
									<td>
										<div class="group">
											<span><input type="text" style="width:39px;" maxlength="3" title="휴대폰번호 앞자리" value="<% if mycell<>"" then response.write Splitvalue(mycell,"-",0) else response.write Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) end if %>" name="reqhp1" id="reqhp1" /></span><i>-</i>
											<span><input type="text" style="width:40px;" maxlength="4" title="휴대폰번호 가운데 자리" value="<% if mycell<>"" then response.write Splitvalue(mycell,"-",1) else response.write Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) end if %>" name="reqhp2" id="reqhp2" /></span><i>-</i>
											<span><input type="text" style="width:39px;" maxlength="4" title="휴대폰번호 뒷자리" value="<% if mycell<>"" then response.write Splitvalue(mycell,"-",2) else response.write Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) end if %>" name="reqhp3" id="reqhp3" /></span>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_address.png" alt="주소" /></th>
									<td>
										<div class="group">
											<span><input type="text" style="width:130px;" title="우편번호" value="<% if myzipcode <>"" then response.write myzipcode else response.write oUserInfo.FOneItem.FZipCode end if %>" name="txZip" id="txZip" ReadOnly /></span><i></i>
											<a href="" onclick="searchzip('frmorder');return false;" class="btnFind"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/btn_find.png" alt="찾기" /></a>
										</div>
										<input type="text" title="기본주소" name="txAddr1" value="<% if myaddr1 <>"" then response.write myaddr1 else response.write doubleQuote(oUserInfo.FOneItem.FAddress1) end if %>" maxlength="100" ReadOnly style="margin-top:0.5rem;" />
										<input type="text" title="상세주소" name="txAddr2" value="<% if myaddr2 <>"" then response.write myaddr2 else response.write doubleQuote(oUserInfo.FOneItem.FAddress2) end if %>" maxlength="100" style="margin-top:0.5rem;" />
									</td>
								</tr>
								</tbody>
							</table>
						</div>
						<div class="ftRt" style="width:302px;">
							<p style="padding:35px 0 30px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_noti.png" alt="배송지 주소 확인하기" /></p>
							<% if mycnt > 0 then %>
								<button type="button" onclick="fnitsm('inst','edit','<%= myaddridx %>'); return false;" class="btnSubmit"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/btn_finish.png" alt="신청완료" /></button>
							<% else %>
								<button type="button" onclick="fnitsm('inst','add',''); return false;" class="btnSubmit"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/btn_finish.png" alt="신청완료" /></button>
							<% end if %>
						</div>
					</div>
				</div>
			</form>
			<% End If %>
			</div>

			<!-- 신청 내역 추가(0526) -->
			<div class="applyList">
				<p class="tit">신청내역</p>
				<div class="view">
					<% if mycnt > 0 then %>
						<!-- 신청내역 있을경우 -->
						<div>
							<table>
								<thead>
								<tr>
									<th width="150px"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_recipient.png" alt="수령인" /></th>
									<th width="150px"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_tel.png" alt="전화번호" /></th>
									<th><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_address_2.png" alt="주소" /></th>
									<th width="150px"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_delivery.png" alt="배송정보" /></th>
								</tr>
								</thead>
								<tbody>
								<tr>
									<td><%= myname %></td>
									<td><%= mycell %></td>
									<td><%= myaddr1 & myaddr2 %></td>
									<% if trim(left(myregdate,10)) = CStr(date()) then %>
										<td><a href="" onclick="fnedit(); return false;" class="btnModify">정보수정</a></td>
									<% else %>
										<% if mysongjang <>"" then %>
											<td>CJ대한통운 <a href="" onclick="mysongjang('<%= mysongjang %>'); return false;"><%= mysongjang %></a></td>
										<% else %>
											<td>상품 준비중</td>
										<% end if %>
									<% end if %>
								</tr>
								</tbody>
							</table>
							<p class="tPad20"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_tip.png" alt="배송지 수정은 신청 당일 자정 12시까지만 가능합니다." /></p>
						</div>
					<% else %>
						<div>
							<p class="nodata"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_nodata.png" alt="이벤트 신청 내역이 없습니다." /></p>
						</div>
					<% end if %>
				</div>
			</div>

			<!--// 인증번호, 배송지 입력 -->
		</div>
		<div class="process">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/tit_apply.png" alt="이벤트에 참여하려면?" /></h3>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_process.png" alt="01.하나은행 적금 가입하고 02.텐바이텐에서 신청!" /></p>
				<div class="character"></div>
			</div>
		</div>
		<div class="product">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/tit_product.png" alt="하나은행 이벤트 상품" /></h3>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/txt_product_v2.png" alt="하나머니세상 적금,하나멤버스 주거래 우대 적금,행복 Together 적금,주택청약종합저축,오늘은 얼마니? 적금 중 1개를 선택하여 신청하실 수 있습니다." usemap="#Map" /></p>
				<map name="Map" id="Map">
					<area shape="rect" coords="419,121,542,140" alt="더 자세히 알아보기" href="https://www.kebhana.com/cont/mall/mall08/mall0805/index.jsp?catId=spb_2812" target="_blank" />
				</map>
			</div>
		</div>
		<div class="noti">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/77767/tit_noti.png" alt="이벤트 유의사항" /></h3>
				<ul>
					<li><strong>무민 코인뱅크 잔여 수량 : <em><%= CurrFormat(27946-allcnt) %>개</em> / 30,000개</strong></li>
					<li>본 이벤트는 총 3만 명을 대상으로 진행되며 (1인 1개 제공) 사전 공지 없이 종료될 수 있습니다.</li>
					<li>본 사은품은 특별 제작 상품으로 배송이 지연될 수 있습니다.</li>
					<li>무민 코인뱅크는 비매품으로 타 상품과 교환 및 환불되지 않습니다.</li>
					<li>배송받을 주소를 입력한 후 ‘신청완료’ 버튼을 클릭하셔야 코인뱅크 신청이 완료되며, 이후에는 배송지를 변경하실 수 없습니다.</li>
				</ul>
			</div>
		</div>
	</div>
	<!--// 꽃을 든 무민 -->
<% Set oUserInfo = nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
