<%
Call chk_SsnLoginEvalMonthCoupon()  '' in commlib


''1달 지닌경우 쿠폰을 발행하기 위한 include였음..


'####################################################
' Description : 로그인 유효기간 확인 (한달이 넘은 쿠키 > 로그아웃)
' History : 2015-01-13 허진원 생성
'####################################################


' dim bExpLogin:	bExpLogin = false

' if (GetLoginUserID)<>"" then
' 	if isdate(left(request.Cookies("etc")("logindate"),10)) then
' 		if datediff("m",left(request.Cookies("etc")("logindate"),10),now())>0 then
' 			'// 로그인 일자가 한 달이 넘었으면
' 			bExpLogin = true
' 		end if
' 	else
' 		'// 빈 값도 처리
' 		bExpLogin = true
' 	end if
' end if

' ''2018/08/16 검토  :: 
' '' => 로그아웃 처리 할게 아니라.. 쿠폰의 문제라면 쿠폰을 발급하는게 ?
' '' ("etc")("logindate") 대신 ("tinfo")("ssndt") 를 쓰는게 좋을듯...
' '' 월이 바뀌면. Cookies("tinfo")("ssndt") / session("ssnlogindt") 로 체크 하여 쿠폰 프로세스를 태운다.
' '' lastlogin 정보를 업데이트하고, loginlog에도 쌓아준다 (휴면계정 관련) active User 수 관련 있을듯함..

' bExpLogin = false

' '// 로그아웃 처리
' if bExpLogin then
' 	response.Cookies("tinfo").domain = "10x10.co.kr"
' 	response.Cookies("tinfo") = ""
' 	response.Cookies("tinfo").Expires = Date - 1
	
' 	response.Cookies("etc").domain = "10x10.co.kr"
' 	response.Cookies("etc") = ""
' 	response.Cookies("etc").Expires = Date - 1
	
' 	response.Cookies("mybadge").domain = "10x10.co.kr"
' 	response.Cookies("mybadge") = ""
' 	response.Cookies("mybadge").Expires = Date - 1
' end if
%>