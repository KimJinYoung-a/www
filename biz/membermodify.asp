<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" 
'#######################################################
'	History	: 2021.06.14 이전도 생성
'	Description : Biz회원 회원정보 수정 페이지
'#######################################################
%>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/biz/classes/memberinfocls.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
    strPageTitle = "텐바이텐 10X10 : 개인정보수정" '페이지 타이틀 (필수)

    Dim userid : userid = getEncLoginUserID '// /my10x10/inc/inc_myBadgeBox.asp에서 사용

    Dim BizUserInfo, phoneIndex, emailIndex
    Set BizUserInfo = new CBizUserInfo
    BizUserInfo.FUserID = userid
    BizUserInfo.FUserPassword = requestCheckVar(request.Form("userpass"),32)

    '// 비밀번호 한번 더 체크
    'BizUserInfo.ReCheckPassword

    '// 세션 체크 후에는 세션 삭제(새로고침 하면 다시 confirmuser 페이지로 이동함)
    Session("InfoConfirmFlag") = ""

    '// 세션이 유지되어 있고 쿠키가 있어도 confirm을 통해서 넘어오지 않았다면 다시 confirm 페이지로 넘긴다.
    ' If InStr(lcase(request.ServerVariables("HTTP_REFERER")),"10x10.co.kr")<1 Then
    '     Response.Redirect SSLUrl & "/my10x10/userinfo/confirmuser.asp"
    '     Response.End
    ' End If

    BizUserInfo.CheckAndInsertBizUserInfo
    '// 유저 정보 조회
    BizUserInfo.GetBizUserData

    '// 현재 유저 정보 존재하는지 여부
    If BizUserInfo.FUserID = "" Then
        Response.Write "<script>alert('정보를 가져올 수 없습니다.');</script>"
        Response.End
    End If

    If Application("Svr_Info") = "staging" Then
        SSLUrl = "https://stgwww.10x10.co.kr"
    End If

%>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
    <div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
		<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
                <!-- content -->
                <div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_info_modify.gif" alt="개인정보 수정" /></h3>
						<ul class="list">
							<li>고객님의 주소와 연락처 등 개인정보를 수정하실 수 있습니다.</li>
							<li>휴대전화번호와 이메일은 한번 더 확인하시어, 주문하신 상품에 대한 배송 안내와 다양한 이벤트정보를 제공해 드리는 SMS, 메일서비스 혜택을 받으시기 바랍니다.</li>
						</ul>
					</div>

                    <div class="mySection">
						<h4>나의 정보관리</h4>
						<fieldset>
                            <form name="frminfo" method="post" action="<%=SSLUrl%>/biz/membermodify_process.asp" style="margin:0px;">
                                
                                <input type="hidden" name="mode" value="infomodi">
                                <input type="hidden" name="isEmailChk" value="<%= chkIIF(BizUserInfo.FIsEmailChk="Y", "Y", "N") %>">
						        <input type="hidden" name="isMobileChk" value="<%= chkIIF(BizUserInfo.FIsMobileChk="Y", "Y", "N") %>">

                                <legend>나의 정보 수정</legend>
                                <table class="baseTable rowTable docForm myInfoForm">
                                    <caption>나의 정보 수정</caption>
                                    <colgroup>
                                        <col width="140" /> <col width="" /> <col width="130" />
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th scope="row">
                                                <span class="essential"><img src="http://fiximage.10x10.co.kr/web2013/common/blt_check_red.gif" alt="필수 입력정보" /></span>
                                                <label for="memName">성명</label>
                                            </th>
                                            <td colspan="2"><input type="text" name="username" value="<%= BizUserInfo.FUserName %>" id="memName" class="txtInp" maxlength="30" style="width:178px;" /></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">주소</th>
                                            <td colspan="2">
                                                <div>
                                                    <input type="text" name="txZip" value="<%= BizUserInfo.FZipCode %>" readonly title="우편번호" class="txtInp focusOn" style="width:60px;" />
                                                    <a href="javascript:TnFindZipNew('frminfo');" onfocus="this.blur()" class="btn btnS1 btnGry2 rMar05"><span class="fn">우편번호찾기</span></a>
                                                </div>
                                                <div class="tPad07">
                                                    <input type="text" name="txAddr1" value="<%= BizUserInfo.FAddress1 %>" readonly title="기본주소" class="txtInp focusOn" style="width:390px;" />
                                                </div>
                                                <div class="tPad07">
                                                    <input type="text"  name="txAddr2" value="<%= BizUserInfo.FAddress2 %>"  maxlength="80" title="상세주소" class="txtInp focusOn" style="width:390px;" />
                                                </div>
                                                <p class="cr6aa7cc tPad13 fs11">주소(기본배송시)는 구입하신 상품이나 이벤트 경품 등의 배송시 사용됩니다.</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row">전화번호</th>
                                            <td colspan="2">
                                                <select name="userphone1" title="지역번호 선택" class="select focusOn" style="width:78px;">
                                                    <% For phoneIndex = 0 To UBound(BizUserInfo.FPhoneAreaCodeArr) %>
                                                        <option value="<%= BizUserInfo.FPhoneAreaCodeArr(phoneIndex) %>" 
                                                            <% If SplitValue(BizUserInfo.FUserPhone, "-", 0) = BizUserInfo.FPhoneAreaCodeArr(phoneIndex) Then Response.Write "Selected" %>>
                                                            <%= BizUserInfo.FPhoneAreaCodeArr(phoneIndex) %>
                                                        </option>
                                                    <% Next %>
                                                </select>
                                                <span class="symbol">-</span>
                                                <input type="text" name="userphone2"  value="<%= SplitValue(BizUserInfo.FUserPhone,"-",1) %>" onkeyup="TnTabNumber('userphone2','userphone3',4);"  maxlength="4" title="전화번호 앞자리 입력" class="txtInp focusOn" style="width:68px;" />
                                                <span class="symbol">-</span>
                                                <input type="text" name="userphone3" value="<%= SplitValue(BizUserInfo.FUserPhone,"-",2) %>" maxlength="4" title="전화번호 뒷자리 입력" value="1234" class="txtInp focusOn" style="width:68px;" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th rowspan="3" scope="row">
                                                <span class="essential"><img src="http://fiximage.10x10.co.kr/web2013/common/blt_check_red.gif" alt="필수 입력정보" /></span>
                                                본인인증
                                            </th>
                                            <td colspan="2">
                                                <p><em class="crRed">본인확인을 위해 정확한 휴대폰 번호를 입력해주세요. (입력된 이메일, 휴대폰 번호는 아이디 찾기, 비밀번호 재발급시 이용됩니다)</em></p>
                                                <p class="cr6aa7cc">이메일, 휴대전화 수정은 [사용자 인증하기]를 통해서만 수정할 수 있습니다.</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lineColor">
                                                <span class="rPad15 bulletDot">이메일</span>
                                                <input type="text" name="txEmail1" value="<%=BizUserInfo.FPreUserMail%>" onkeyup="chkChangeAuth(this.form,'E');" maxlength="32" title="이메일 아이디 입력" class="txtInp focusOn" style="width:118px;" />
                                                <input type="hidden" name="orgUsermail" value="<%= BizUserInfo.FUserMail %>">
                                                <input type="hidden" name="usermail" value="<%= BizUserInfo.FUserMail %>">
                                                <span class="symbol">@</span>
                                                <input type="text" name="selfemail" onkeyup="chkChangeAuth(this.form,'E');" maxlength="80"  value="<%= BizUserInfo.FUserMailSite %>" title="이메일 직접 입력" class="txtInp" style="width:118px;" />
                                                <select name="txEmail2" onchange="NewEmailChecker();chkChangeAuth(this.form,'E');" title="이메일 서비스 선택" class="select offInput emailSelect" style="width:102px;">
                                                    <option value="etc">직접입력</option>
                                                    <% For emailIndex = 0 To UBound(BizUserInfo.FEmailSiteArr) %>
                                                        <option value="<%= BizUserInfo.FEmailSiteArr(emailIndex) %>">
                                                            <%= BizUserInfo.FEmailSiteArr(emailIndex) %>
                                                        </option>
                                                    <% Next %>
                                                </select>
                                            </td>
                                            <td class="ct">
                                                <a href="javascript:sendCnfEmail(document.frminfo);" class="btn btnS2 btnRed"><span class="fn">사용자 인증하기</span></a>
                                                <div class="tPad05 fs11"><strong id="lyrMailAuthMsg" class="<%= chkIIF(BizUserInfo.FIsEmailChk="Y", "crRed", "cr777") %>">상태 : <%= chkIIF(BizUserInfo.FIsEmailChk="Y","인증완료","인증대기") %></strong></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lineColor">
                                                <span class="rPad05 bulletDot">휴대전화</span>
                                                <input type="hidden" name="orgUsercell" value="<%= BizUserInfo.FUserCell %>">
                                                <select name="usercell1" title="휴대전화 앞자리 선택" class="select focusOn" style="width:78px;">
                                                    <option value="010" <% if SplitValue(BizUserInfo.FUserCell,"-",0) = "010" Then response.write "Selected" %>>010</option>
                                                    <option value="011" <% if SplitValue(BizUserInfo.FUserCell,"-",0) = "011" Then response.write "Selected" %>>011</option>
                                                    <option value="016" <% if SplitValue(BizUserInfo.FUserCell,"-",0) = "016" Then response.write "Selected" %>>016</option>
                                                    <option value="017" <% if SplitValue(BizUserInfo.FUserCell,"-",0) = "017" Then response.write "Selected" %>>017</option>
                                                    <option value="018" <% if SplitValue(BizUserInfo.FUserCell,"-",0) = "018" Then response.write "Selected" %>>018</option>
                                                    <option value="019" <% if SplitValue(BizUserInfo.FUserCell,"-",0) = "019" Then response.write "Selected" %>>019</option>
                                                </select>
                                                <span class="symbol">-</span>
                                                <input type="text" name="usercell2" value="<%= SplitValue(BizUserInfo.FUserCell, "-", 1) %>" onkeyup="TnTabNumber('usercell2','usercell3',4);chkChangeAuth(this.form,'P');" maxlength="4" title="휴대전화 가운데자리 입력" class="txtInp focusOn" style="width:68px;" />
                                                <span class="symbol">-</span>
                                                <input type="text" name="usercell3" value="<%= SplitValue(BizUserInfo.FUserCell, "-", 2) %>" onkeyup="chkChangeAuth(this.form,'P');" maxlength="4" title="휴대전화 뒷자리 입력" value="1234" class="txtInp focusOn" style="width:68px;" />
                                            </td>
                                            <td class="ct">
                                                <a href="javascript:sendCnfSMS(document.frminfo);" class="btn btnS2 btnRed"><span class="fn">사용자 인증하기</span></a>
                                                <div class="tPad05 fs11"><strong id="lyrPhoneAuthMsg" class="<%=chkIIF(BizUserInfo.FIsMobileChk="Y","crRed","")%>">상태 : <%=chkIIF(BizUserInfo.FIsMobileChk="Y","인증완료","인증대기")%></strong></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>
                                                <span class="essential"><img src="http://fiximage.10x10.co.kr/web2013/common/blt_check_red.gif" alt="필수 입력정보" /></span>
                                                이메일/SMS<br />수신여부
                                            </th>
                                            <td colspan="2">
                                                <ul class="sendInfo">
                                                    <li>
                                                        <span class="ftLt" style="width:275px;">텐바이텐의 다양한 정보를 받아보시겠습니까?</span>
                                                        <dl>
                                                            <dt>이메일</dt>
                                                            <dd>
                                                                <input type="radio" name="email_10x10" value="Y" <%= ChkIIF(BizUserInfo.FEmailOk="Y","checked","") %> class="radio" id="tenMailY" />
                                                                <label for="tenMailY"><span class="rMar05">예</span></label>
                                                                <input type="radio" name="email_10x10" value="N" <%= ChkIIF(BizUserInfo.FEmailOk="N","checked","") %> class="radio" id="tenMailN" />
                                                                <label for="tenMailN"><span>아니오</span></label>
                                                            </dd>
                                                        </dl>
                                                        <span class="ftLt lPad15">|</span>
                                                        <dl>
                                                            <dt>SMS</dt>
                                                            <dd>
                                                                <input type="radio" name="smsok" value="Y" <%= ChkIIF(BizUserInfo.FSmsOk="Y","checked","") %> class="radio" id="tenSmsY" />
                                                                <label for="tenSmsY"><span class="rMar05">예</span></label>
                                                                <input type="radio" name="smsok" value="N" <%= ChkIIF(BizUserInfo.FSmsOk="Y","","checked") %> class="radio" id="tenSmsN" />
                                                                <label for="tenSmsN"><span>아니오</span></label>
                                                            </dd>
                                                        </dl>
                                                    </li>
                                                </ul>
                                                <p class="tPad13 lMar10 cr6aa7cc lsM1">텐바이텐 이메일/SMS 수신 동의를 하시면 다양한 할인혜택과 이벤트/신상품 등의 정보를 빠르게 만나실 수 있습니다. <br /><strong>단, 주문 및 배송관련 정보는 수신동의와 상관없이 자동 발송됩니다.</strong></p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row">
                                                <span class="essential"><img src="http://fiximage.10x10.co.kr/web2013/common/blt_check_red.gif" alt="필수 입력정보" /></span>
                                                <label for="pwConfirm">비밀번호 확인</label>
                                            </th>
                                            <td colspan="2">
                                                <input type="password" name="oldpass" maxlength="32" onKeyPress="if (event.keyCode == 13) ChangeMyInfo(frminfo);" id="pwConfirm" class="txtInp" style="width:178px;" />
                                                <em class="lPad05 cr6aa7cc">정보를 수정 하시려면 기존 비밀번호를 입력하시기 바랍니다.</em>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="btnArea ct tPad30">
                                    <input type="button" onclick="ChangeMyInfo(document.frminfo)" class="btn btnS1 btnRed btnW160 fs12" value="나의정보 수정" />
                                </div>
                            </form>
						</fieldset>

                        <h4>비밀번호 수정</h4>
                        <form name="frmpass" method="post" action="<%=SSLUrl%>/biz/membermodify_process.asp" style="margin:0px;">
                            
                            <input type="hidden" name="mode" value="passmodi">

                            <fieldset>
                                <legend>비밀번호 수정</legend>
                                <table class="baseTable rowTable docForm myInfoForm">
                                    <caption>비밀번호 수정</caption>
                                    <colgroup>
                                        <col width="140" /> <col width="" />
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th scope="row">
                                                <label for="oldPw">기존 비밀번호</label>
                                            </th>
                                            <td><input type="password" name="oldpass" maxlength="32" onKeyPress="if (event.keyCode == 13) ChangeMyPass(frmpass);" id="oldPw" class="txtInp" style="width:178px;" /></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">
                                                <label for="newPw">새 비밀번호</label>
                                            </th>
                                            <td>
                                                <input type="password" name="newpass1" maxlength="32" onKeyPress="if (event.keyCode == 13) ChangeMyPass(frmpass);" id="newPw" class="txtInp" style="width:178px;" />
                                                <em class="lPad05 cr6aa7cc">비밀번호는 공백없는 8~16자의 영문/숫자 등 두 가지 이상의 조합으로 입력해주세요.</em>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row">
                                                <label for="newPwConfirm">새 비밀번호 확인</label>
                                            </th>
                                            <td>
                                                <input type="password" name="newpass2" maxlength="32" onKeyPress="if (event.keyCode == 13) ChangeMyPass(frmpass);" id="newPwConfirm" class="txtInp" style="width:178px;" />
                                                <em class="lPad05 cr6aa7cc">비밀번호 확인을 위해 한 번 더 입력해 주시기 바랍니다.</em>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="borderBtm">
                                                <p class="bulletDot"><strong >주의하세요!</strong><br />
                                                아이디와 같은 비밀번호나 주민등록번호, 생일, 학번, 전화번호 등 개인정보와 관련된 숫자나 연속된 숫자, 통일 반복된 숫자 등<br />
                                                다른 사람이 쉽게 알아 낼 수 있는 비밀번호는 사용하지 않도록 주의하여 주시기 바랍니다.
                                                </p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="btnArea ct tPad30">
                                    <input type="button" onclick="ChangeMyPass(document.frmpass)" class="btn btnS1 btnRed btnW160 fs12" value="비밀번호 수정" />
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
                <!-- //content -->

                <div id="popResult">
                    <!-- 이메일 승인 팝업 -->
                    <div id="certMailLyr" class="window certLyr" style="display:none;position:absolute;z-index:10;text-align:center;width:496px;height:406px;">
                        <div class="popTop pngFix">
                            <div class="pngFix"></div>
                            <div class="popContWrap pngFix">
                                <div class="popCont pngFix">
                                    <div class="popHead">
                                        <h2><img src="http://fiximage.10x10.co.kr/web2013/member/tit_pop_mail.gif" alt="이메일 인증하기" /></h2>
                                        <p class="lyrClose"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_pop_close.gif" id="mailClose" alt="닫기" /></p>
                                    </div>
                                    <div class="popBody ct">
                                        <div class="certCont">
                                            <p class="result"><strong><span id="confirmEmail" class="crRed"></span>로<br />인증메일을 발송하였습니다.</strong></p>
                                            <div>
                                                <p class="cmt crRed">인증 이메일을 12시간 안에 확인해주세요.</p>
                                                <p class="help lt">가입승인 시간 내에 승인을 하지 않으시면 인증이 취소됩니다.<br />인증메일이 도착하지 않았을 경우 팝업창을 닫고 '사용자 인증하기' 버튼을<br /> 클릭하시면 다시 메일을 받으실 수 있습니다.</p>
                                            </div>
                                            <div class="btnArea ct tMar20">
                                                <span id="mailComfirm" class="btn btnS1 btnRed btnW80 fs12">확인</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id ="popPhoneResult">
                    <!-- 휴대폰 승인 팝업 -->
                    <div id="certPhoneLyr" class="window certLyr" style="display:none;position:absolute;z-index:10;text-align:center;width:505px;height:456px;">
                        <div class="popTop pngFix">
                            <div class="pngFix"></div>
                            <div class="popContWrap pngFix">
                                <form name="cnfSMSForm" action="" onsubmit="return false;">
                                <div class="popCont pngFix">
                                    <div class="popHead">
                                        <h2><img src="http://fiximage.10x10.co.kr/web2013/member/tit_pop_phone.gif" alt="휴대폰 인증하기" /></h2>
                                        <p class="lyrClose"><img id="phoneClose" src="http://fiximage.10x10.co.kr/web2013/common/btn_pop_close.gif" alt="닫기" /></p>
                                    </div>
                                    <div class="popBody ct">
                                        <div class="certCont">
                                            <p class="result"><strong><span id="confirmPhone" class="crRed"></span>로<br />휴대폰 인증번호를 발송하였습니다.</strong></p>
                                            <p class="certNum">
                                                <label for="certNum"><strong>인증번호</strong></label>
                                                <span class="lMar10"><input type="text" name="crtfyNo" maxlength="6" class="txtInp offInput" id="certNum" /></span>
                                                <a href="javascript:fnConfirmSMS();" class="btn btnS1 btnGry">인증번호 확인</a>
                                            </p>
                                            <p id="smsRstMsg" class="cmt cr6aa7cc"><strong>인증번호를 입력해주세요.</strong></p>
                                            <p class="help">인증번호가 도착하지 않으면 스팸문자함 또는 차단설정을 확인해주세요.</p>
                                            <div class="btnArea ct tMar20">
                                                <a href="javascript:fnConfirmSMS();" class="btn btnS1 btnRed btnW80 fs12">확인</a>
                                                <span id="phoneCancel" class="btn btnS1 btnGry2 btnW80 fs12">취소</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    // 나의정보 수정
    function ChangeMyInfo(frm) {
        if (frm.username.value.length<2){
            alert('이름을 입력해 주세요.');
            frm.username.focus();
            return;
        }
        if (GetByteLength(frm.txAddr2.value)>80){
            alert('나머지 주소가 너무 깁니다. 80byte이내로 작성해주세요.\n※한글 1글자는 2byte입니다.');
            frm.txAddr2.focus();
            return;
        }
        var cellNumber = frm.usercell1.value+"-"+frm.usercell2.value+"-"+frm.usercell3.value;
        if (frm.isEmailChk.value=="N" && (frm.isMobileChk.value=="N" || frm.orgUsercell.value!=cellNumber)) {
            if (frm.orgUsercell.value != cellNumber) {
                alert('휴대전화 번호를 수정중이십니다.\n\n이메일 또는 휴대전화 중 하나는 반드시 인증을 받으셔야 합니다.\n(비밀번호 분실시 본인인증에 사용됩니다.)');
            } else {
                alert('이메일 또는 휴대전화 중 하나는 반드시 인증을 받으셔야 합니다.\n(비밀번호 분실시 본인인증에 사용됩니다.)');
            }

            return;
        }

        if ( confirm('정보를 수정 하시겠습니까?') ){
            frm.usermail.value = frm.txEmail1.value + '@' + (frm.txEmail2.value === 'etc' ? frm.selfemail.value : frm.txEmail2.value);
            frm.submit();
        }
    }

    // 자릿수 채워졌을 때 focus 이동
    function TnTabNumber(thisform, target, num) {
        if ( eval("document.frminfo." + thisform + ".value.length") == num ) {
            eval("document.frminfo." + target + ".focus()");
        }
    }

    // 인증값 변경 확인
    function chkChangeAuth(frm, dv) {
        switch(dv) {
            case "E" : // 이메일
                if(frm.isEmailChk.value=="Y") {
                    var email;
                    if( frm.txEmail2.value == "etc"){
                        email = frm.txEmail1.value + '@' + frm.selfemail.value;
                    }else{
                        email = frm.txEmail1.value + frm.txEmail2.value;
                    }

                    if(frm.orgUsermail.value!=email) {
                        $("#lyrMailAuthMsg").attr("class","cr777");
                        $("#lyrMailAuthMsg").html("상태 : 인증대기");
                    } else {
                        $("#lyrMailAuthMsg").attr("class","crRed");
                        $("#lyrMailAuthMsg").html("상태 : 인증완료");
                    }
                }
                break;
            case "P" : // 휴대전화
                if(frm.isMobileChk.value=="Y") {
                    var cellphone;
                    cellphone = frm.usercell1.value+"-"+frm.usercell2.value+"-"+frm.usercell3.value;
                    if(frm.orgUsercell.value!=cellphone) {
                        $("#lyrPhoneAuthMsg").attr("class","cr777");
                        $("#lyrPhoneAuthMsg").html("상태 : 인증대기");
                    } else {
                        $("#lyrPhoneAuthMsg").attr("class","crRed");
                        $("#lyrPhoneAuthMsg").html("상태 : 인증완료");
                    }
                }
                break;
        }
    }

    // 이메일 사이트 직접 입력 선택 시 직접입력 input 노출
    // 반대는 숨김
    function NewEmailChecker() {
        var frm = document.frminfo;
        if( frm.txEmail2.value == "etc")  {
            frm.selfemail.style.display = '';
            frm.selfemail.focus();
        } else {
            frm.selfemail.style.display = 'none';
        }
    }

    // 본인인증 이메일 발송
    function sendCnfEmail(frm) {
        if( confirm("입력하신 이메일로 인증을 받으시겠습니까?\n\n※인증메일에서 링크를 클릭하시면 인증이 완료되며 이메일정보가 수정됩니다.") ) {
            $.ajax({
                type: "POST",
                url: "/biz/ajax/sendModifyEmail.asp",
                data: {
                    preUserMail : frm.txEmail1.value,
                    userMailSite : frm.txEmail2.value === 'etc' ? frm.selfemail.value : frm.txEmail2.value
                },
                dataType: "json",
                async: false,
                success : function(data) {
                    if( data.response === '0000' ) {
                        $('#confirmEmail').text(data.email);
                        $('#certMailLyr').fadeIn().css({
                            left: ($(window).width() - $('#certMailLyr').outerWidth())/2,
                            top: ($(window).height() - $('#certMailLyr').outerHeight())/3 + $(window).scrollTop()
                        });
                        $('#mailClose').click(function(){
                            $('#certMailLyr').fadeOut()
                        });
                        $('#mailComfirm').click(function(){
                            $('#certMailLyr').fadeOut()
                        });
                    } else {
                        console.log(data);
                        alert(data.faildesc);
                    }
                },
                error : function(e) {
                    alert('처리 중 오류가 발생했습니다');
                }
            });
        }
    }

    // 본인인증 휴대폰SMS 발송
    function sendCnfSMS(frm) {
        if( confirm("입력하신 휴대폰 번호로 인증을 받으시겠습니까?\n\n※전송된 인증번호를 입력창에 넣으시면 인증이 완료되며 휴대폰정보가 수정됩니다.") ) {
            $.ajax({
                type: "POST",
                url: "/biz/ajax/sendModifySMS.asp",
                data: {
                    cell1 : frm.usercell1.value,
                    cell2 : frm.usercell2.value,
                    cell3 : frm.usercell3.value
                },
                dataType: "json",
                async: false,
                success : function(data) {
                    if( data.response === '0000' ) {
                        $('#confirmPhone').text(data.cell);
                        $('#certPhoneLyr').fadeIn().css({
                            left: ($(window).width() - $('#certPhoneLyr').outerWidth())/2,
                            top: (($(window).height() - $('#certPhoneLyr').outerHeight())/3) + $(window).scrollTop()
                        });

                        $('#phoneClose').click(function(){
                            $('#certPhoneLyr').fadeOut()
                        });
                        $('#phoneCancel').click(function(){
                            $('#certPhoneLyr').fadeOut()
                        });
                    } else {
                        console.log(data);
                        alert(data.faildesc);
                    }
                },
                error : function(e) {
                    alert('처리 중 오류가 발생했습니다');
                }
            });
        }
    }

    // 휴대폰 인증 처리
    function fnConfirmSMS() {
        var frm = document.cnfSMSForm;
        if(frm.crtfyNo.value.length<6) {
            alert("휴대폰으로 받으신 인증번호를 정확히 입력해주세요.");
            frm.crtfyNo.focus();
            return;
        }

        var rstStr = $.ajax({
            type: "POST",
            url: "/biz/ajax/checkConfirmSMS.asp",
            data: {key: frm.crtfyNo.value},
            dataType: "json",
            async: false,
            success : function(data) {
                console.log(data);
                if( data.response === '0000' ) {
                    $("#smsRstMsg").attr("class","cmt cr6aa7cc");
                    $("#smsRstMsg").html("인증이 완료되었습니다.")
                    //페이지 새로고침
                    location.reload();
                } else {
                    $("#smsRstMsg").attr("class","cmt crRed");
                    $("#smsRstMsg").html(data.faildesc)
                }
            },
            error : function(e) {
                alert('처리 중 오류가 발생했습니다');
            }
        });

    }

    // 비밀번호 수정
    function ChangeMyPass(frm){
        if (frm.oldpass.value.length<1){
            alert('기존 패스워드를 입력하세요.');
            frm.oldpass.focus();
            return;
        }

        if (jsChkBlank(frm.newpass1.value)){
            alert('새로운 패스워드를 입력하세요.');
            frm.newpass1.focus();
            return;
        }

        if (frm.newpass1.value.length<8){
            alert('새로운 패스워드는 8자 이상으로 입력하세요.');
            frm.newpass1.focus();
            return;
        }

        if (frm.newpass1.value=='<%=userid%>'){
            alert('아이디와 동일한 패스워드는 사용하실 수 없습니다.');
            frm.newpass1.focus();
            return;
        }

        if (!fnChkComplexPassword(frm.newpass1.value)) {
            alert('새로운 패스워드는 영문/숫자 등 두가지 이상의 조합으로 입력하세요.');
            frm.newpass1.focus();
            return;
        }

        if (frm.newpass1.value!=frm.newpass2.value){
            alert('새로운 패스워드가 일치하지 않습니다.');
            frm.newpass1.focus();
            return;
        }

        if(frm.newpass1.value.indexOf("'") > 0){
            alert("새로운 비밀번호는 특수문자(')를 포함 하실 수 없습니다.");
            frm.newpass1.focus();
            return;
        }

        var ret = confirm('패스워드를 수정하시겠습니까?');

        if(ret){
            frm.submit();
        }
    }
</script>
</body>
</html>
<%
    Set BizUserInfo = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->