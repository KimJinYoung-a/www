<!-- #include virtual="/lib/util/commlib.asp" -->
<%
'' PopUp 비회원로그인 / 회원 로그인 체크
if ((Not IsUserLoginOK) and (Not IsGuestLoginOK)) then        
        '// 2009.04.15  정윤정 수정. post data 값 추가
	dim checklogin_backpath
  	dim strBackPath, strGetData, strPostData	
   		strBackPath 	= request.ServerVariables("URL")
   		strGetData  	= request.ServerVariables("QUERY_STRING")
   		strPostData 	= fnMakePostData 'post data를 get string 형태로 변경
   	       
	 checklogin_backpath = "backpath="+ server.URLEncode(strBackPath) + "&strGD=" +  server.URLEncode(strGetData) + "&strPD="+  server.URLEncode(strPostData)  +"&isopenerreload=on" 

        IF application("Svr_Info")="Dev" THEN
        	response.redirect wwwUrl&"/login/poploginpage.asp?vType=G&" + checklogin_backpath
        else
        	response.redirect wwwUrl&"/login/poploginpage.asp?vType=G&" + checklogin_backpath
        end if
        response.end
end if

%> 