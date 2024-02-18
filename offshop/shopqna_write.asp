<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/shopqna_write.asp
' Description : 오프라인숍 Qna 글쓰기
' History : 2009.07.14 강준구 생성
'           2009.08.13 허진원 탑배너 및 내용 크기 수정
'			2018.06.14 정태훈 리뉴얼
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/shopping/offshopcls.asp" -->
<!-- #include virtual="/offshop/inc/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/offshop/inc/commonFunction.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim cookieuserid, cookieuseremail, cookieusername, iCurrentPage

'If GetLoginUserID = "" Then
'	Response.Write "<script>location.href='/offshop/point/point_login.asp?reurl=/offshop/shopqna_write.asp?shopid=" & shopid & "&tabidx=3';</script>"
'	Response.End
'End If

iCurrentPage	= Request("iCP")

cookieuserid 	= GetLoginUserID
cookieuseremail = GetLoginUserEmail
cookieusername 	= GetLoginUserName

'매장 정보 가져오기
Dim offshopinfo, shopid
shopid = requestCheckVar(request("shopid"),16)
Set  offshopinfo = New COffShop
offshopinfo.FRectShopID=shopid
offshopinfo.GetOneOffShopContents
%>
<script language="javascript" src="/offshop/inc/offshopCommon.js"></script>
<script language="javascript">
<!--
	//상품코드 넣기 유효성확인
	function GoItemInfo(){
	var frm = eval("document.frmQ");
		if (frm.sC.value==""){
			alert("상품코드를 먼저 넣어주세요.");
			frm.sC.focus();
		}
		else if(!fnChkNumber(frm.sC.value)){
			alert("유효하지 않은 코드입니다. 다시 입력해주세요");
			frm.sC.value = "";
			frm.sC.focus();
		}
		else{
			window.open("processitem.asp?itemid=" + frm.sC.value, "imageView", "width=1,height=1,status=no,resizable=no,scrollbars=no");
		}

	}

	//문의하기 값 체크
	function jsSubmit(frm, sid){
		if (sid == ""){
			if(!frm.username.value){
				alert("작성자를 입력해주세요");
				frm.username.focus();
				return false;
			}
		}

		if(!frm.sT.value){
			alert("제목을 입력해주세요");
			frm.sT.focus();
			return false;
		}

		if(!frm.tC.value){
			alert("내용을 입력해주세요");
			frm.tC.focus();
			return false;
		}

		if(frm.chkM.checked == true)
		{
			if(!frm.sM.value){
				alert("메일 주소를 입력해주세요");
				frm.sM.focus();
				return false;
			}
		}


//alert(frm.chkC.checked);
		if(frm.chkC.checked == true)
		{
	        if(isNaN(frm.sP1.value) || frm.sP1.value == "")
	        {
	            alert("휴대폰 번호를 바르게 입력하세요.");
	            frm.sP1.value = "";
	            frm.sP1.focus();
	            return false;
	        }
		}

		if(frm.sC.value){
			if(frm.che.value != 'check'){
				alert("상품코드 확인을 해주세요.");
				frm.iyes.focus();
				return false;
			}
		}

		if (sid == ""){
			if(!frm.password.value){
				alert("비밀번호를 입력해주세요");
				frm.password.focus();
				return false;
			}
		}

		frm.action="processqna.asp";
		frm.submit();
	}

	function fnMoveList(){
		location.href="shopqna.asp?iCP=<%=iCurrentPage%>&shopid=<%=shopid%>&menuid=3";
	}
//-->
</script>
</head>
<body>
<div class="wrap fullEvt">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container offshopV18">
		<div id="contentWrap">
			<!-- #include virtual="/offshop/inc/incHeader.asp" -->

			<div class="offshop-conts offshop-inquiry">
				<form name="frmQ" method="post">
				<input type="hidden" name="shopid"  value="<%=shopid%>">
				<input type="hidden" name="userid"  value="<%=cookieuserid%>">
				<input type="hidden" name="menuid" value="<%=menuid%>">
				<input type="hidden" name="che" value="">
				<input type="hidden" name="sMode" value="I">
				<!-- 질문하기 -->
					<div class="board-list">
						<h3>오프라인매장 질문하기</h3>
						<table>
							<colgroup>
								<col width="120" /> <col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th><span class="must">작성자</span></th>
									<td><input type="text" id="username" name="username" value="<%=cookieusername%>" style="width:163px;"></td>
								</tr>
								<tr>
									<th><span class="must">제목</span></th>
									<td><input type="text" name="sT" style="width:843px;"></td>
								</tr>
								<tr>
									<th>상품코드<span class="help">?<img src="http://fiximage.10x10.co.kr/web2018/offshop/txt_help.png" alt=""></span></th>
									<td>
										<input type="text" name="sC" style="width:163px; font-weight:bold;">
										<button class="btnV18 btn-dark-grey submit" onfocus="this.blur();" onClick="GoItemInfo();return false;">입력</button>
										<input type="text" name="sD" readonly class="no-access" style="width:563px;">
									</td>
								</tr>
								<tr>
									<th><span class="must">내용</span></th>
									<td>
										<textarea name="tC" id="tC" cols="30" rows="10" style="width:824px; height:326px;"></textarea>
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<input type="text" name="sM" style="width:320px;" value="<%=cookieuseremail%>" maxlength="64">
										<input type="checkbox" id="recieve-mail" name="chkM" value="Y"><label for="recieve-mail">답변받기</label>
									</td>
								</tr>
								<tr>
									<th>휴대폰</th>
									<td>
										<input type="text" style="width:145px;" name="sP1" id="select">
										<input type="checkbox" id="recieve-sms" name="chkC" value="Y"><label for="recieve-sms">답변받기</label>
									</td>
								</tr>
								<% If cookieuserid<>"" Then %>
								<% Else %>
								<tr>
									<th><span class="must">비밀번호</span></th>
									<td>
										<input type="password" id="password" name="password" style="width:145px;">
									</td>
								</tr>
								<% End If %>
							</tbody>
						</table>

						<div class="btn-group">
							<button class="btnV18 btn-line-red rMar10" onfocus="this.blur();" onClick="fnMoveList();return false;">취소</button>
							<button class="btnV18 btn-red" onfocus="this.blur();" onClick="jsSubmit(this.form,'<%=cookieuserid%>');return false;">확인</button>
						</div>
					</div>
				<!--// 질문하기 -->
				</form>
				<!-- for dev msg 매장별 썸네일 최신 3장-->
				<svg width="100%" height="280" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 1140 540" preserveAspectRatio="xMidYMid slice" class="svgBlur">
					<filter id="svgBlurFilter">
						<feGaussianBlur in="SourceGraphic" stdDeviation="1.6" />
					</filter>
					<% If isArray(arrMainGallery) Then %>
					<image xlink:href="<%=arrMainGallery(0,0)%>" x="0" y="0" filter="url(#svgBlurFilter)" />
					<% End If %>
				</svg>
				<!--// for dev msg 매장별 썸네일 최신 3장-->
			</div>
		</div>
	</div>
</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

</body>
</html>
<% Set  offshopinfo = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->