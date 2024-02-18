<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2013.09.16 허진원 2013리뉴얼
'	Description : 이벤트 당첨 배송지 입력 팝업
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 당첨 배송지 입력"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/login/checkpoplogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/cscenter/eventsbeasongcls.asp" -->
<%
dim id, userid
id = requestCheckVar(request("id"),10)
userid = getEncLoginUserID


dim ibeasong
set ibeasong = new CEventsBeasong
ibeasong.FRectUserID = userid
ibeasong.FRectId = id
ibeasong.GetOneWinnerItem

if ibeasong.FResultCount<1 then
	response.write "<script>alert('검색된 내역이 없습니다.');</script>"
	response.write "<script>window.close();</script>"
	response.end
end if

dim i

dim hpArr,hp1,hp2,hp3
dim phoneArr,phone1,phone2,phone3

if IsNULL(ibeasong.FOneItem.Freqphone) then ibeasong.FOneItem.Freqphone=""
if IsNULL(ibeasong.FOneItem.Freqhp) then ibeasong.FOneItem.Freqhp=""
if IsNULL(ibeasong.FOneItem.Freqzipcode) then ibeasong.FOneItem.Freqzipcode=""

phoneArr = split(ibeasong.FOneItem.Freqphone,"-")
hpArr = split(ibeasong.FOneItem.Freqhp,"-")

if UBound(hpArr)>=0 then hp1 = hpArr(0)
if UBound(hpArr)>=1 then hp2 = hpArr(1)
if UBound(hpArr)>=2 then hp3 = hpArr(2)

if UBound(phoneArr)>=0 then phone1 = phoneArr(0)
if UBound(phoneArr)>=1 then phone2 = phoneArr(1)
if UBound(phoneArr)>=2 then phone3 = phoneArr(2)

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
function gotowrite(){
    if(document.infoform.reqname.value == ""){
		alert("받으시는 분의 이름을 입력해주세요.");
	    document.infoform.reqname.focus();
	}

	else if(document.infoform.reqphone1.value == "" || document.infoform.reqphone2.value == "" || document.infoform.reqphone3.value == ""){
		alert("받으시는 분의 전화번호를 입력해주세요.");
	    document.infoform.reqphone1.focus();
	}

	else if(document.infoform.reqhp1.value == "" || document.infoform.reqhp2.value == "" || document.infoform.reqhp3.value == ""){
		alert("받으시는 분의 핸드폰 번호를 입력해주세요.");
	    document.infoform.reqhp1.focus();
	}

	else if(document.infoform.txZip.value == ""){
		alert("받으시는 분의 주소를 입력해주세요.");
		 document.infoform.txAddr2.focus();
	}

	/*
	else if(document.infoform.txAddr2.value == ""){
		alert("받으시는 분의 나머지주소를 입력해주세요.");
	    document.infoform.txAddr2.focus();
	}
	*/

    else{
    	if (confirm('입력 내용이 정확합니까?')){
    		document.infoform.submit();
    	}
    }

}
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_event_delivery.gif" alt="이벤트 당첨 배송지 안내" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<form name="infoform" method="post" action="/my10x10/myeventmasteredit_process.asp">
				<input type="hidden" name="id" value="<%= id %>">
				<input type="hidden" name="ePC" value="<%=ibeasong.FOneItem.FPCode%>">
				<div class="mySection">
					<fieldset>
						<legend>이벤트 당첨 배송지 정보 입력 폼</legend>
						<div class="delivery">
							<h2>배송지 정보</h2>
						</div>
						<table class="baseTable rowTable docForm">
						<caption>이벤트 당첨 배송지</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">이벤트명</th>
							<td><strong><%= ibeasong.FOneItem.Fgubunname %></strong></td>
						</tr>
						<tr>
							<th scope="row">당첨상품</th>
							<td><%= ibeasong.FOneItem.FPrizeTitle %></td>
						</tr>
						<tr>
							<th scope="row">당첨자 성함</th>
							<td><%= ibeasong.FOneItem.Fusername %>
								<input type="hidden" name="username" value="<%= ibeasong.FOneItem.Fusername %>" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="receiveName">수령인 성함</label></th>
							<td><input type="text" name="reqname" id="receiveName" maxlength="16" value="<%= ibeasong.FOneItem.Freqname %>" class="txtInp" style="width:198px;" /></td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td>
								<input type="text" name="reqphone1" title="지역번호 선택" maxlength="3" value="<%= phone1 %>" class="txtInp" style="width:40px;">
								<span class="symbol">-</span>
								<input type="text" name="reqphone2" title="전화번호 앞자리 입력" maxlength="4" value="<%= phone2 %>" class="txtInp" style="width:48px;" />
								<span class="symbol">-</span>
								<input type="text" name="reqphone3" title="전화번호 뒷자리 입력" maxlength="4" value="<%= phone3 %>" class="txtInp" style="width:48px;" />
							</td>
						</tr>
						<tr>
							<th scope="row">휴대전화번호</th>
							<td>
								<input type="text" name="reqhp1" title="휴대전화 앞자리 선택" maxlength="3" value="<%= hp1 %>" class="txtInp" style="width:40px;">
								<span class="symbol">-</span>
								<input type="text" name="reqhp2" title="휴대전화 가운데자리 입력" maxlength="4" value="<%= hp2 %>" class="txtInp" style="width:48px;" />
								<span class="symbol">-</span>
								<input type="text" name="reqhp3" title="휴대전화 뒷자리 입력" maxlength="4" value="<%= hp3 %>" class="txtInp" style="width:48px;" />
							</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td>
								<div>
									<input type="text" name="txZip" value="<%=ibeasong.FOneItem.Freqzipcode%>" readonly title="우편번호" class="txtInp focusOn" style="width:60px;" />
									<a href="" class="btn btnS2 btnGry2 rMar05" onclick="TnFindZipNew('infoform');return false;"><span class="fn">우편번호찾기</span></a>
								</div>
								<div class="tPad07">
									<input type="text" name="txAddr1" id="txAddr1" title="기본주소" class="txtRead" value="<%= ibeasong.FOneItem.Freqaddress1 %>" style="width:235px;padding:5px 10px;" readonly />
								</div>
								<div class="tPad07">
									<input type="text" name="txAddr2" id="txAddr2" title="상세주소" class="txtInp" value="<%= ibeasong.FOneItem.Freqaddress2 %>" maxlength="80" style="width:390px;" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="etcmsg">기타사항</label></th>
							<td>
								<textarea name="reqetc" id="etcmsg" cols="60" rows="5" style="width:400px; height:58px;"><%= ibeasong.FOneItem.Freqetc %></textarea>
							</td>
						</tr>
						</tbody>
						</table>

						<div class="btnArea ct tPad20">
							<input type="button" class="btn btnS1 btnRed btnW100" value="등록" onclick="gotowrite()" />
							<input type="button" class="btn btnS1 btnGry btnW100" value="취소" onclick="window.close()" />
						</div>
					</fieldset>
				</div>
				</form>
				<!-- //content -->
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>
<% set ibeasong = Nothing %>

<!-- #include virtual="/lib/db/dbclose.asp" -->