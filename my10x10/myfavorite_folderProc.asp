<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'#######################################################
'	History	:  2010.04.09 한용민 수정
'	Description : 위시리스트 관리
'#######################################################
%>
<!-- #include virtual="/login/checkPopLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<%

dim i, sqlStr , viewisusing , userid, bagarray, mode, itemid
dim foldername,fidx,backurl , arrList, intLoop,stype , myfavorite, intResult, vOpenerChk
	userid  		= getEncLoginUserID
	stype    		= requestCheckvar(request("hidM"),1)
	viewisusing    	= requestCheckvar(request("viewisusing"),1)
	foldername  	= requestCheckvar(request("sFN"),20)
	fidx			= requestCheckvar(request("fidx"),9)
	backurl		= requestCheckvar(request("backurl"),100)	
	bagarray	= Trim(requestCheckvar(request("bagarray"),1024))
	mode    	= requestCheckvar(request("mode"),16)
	itemid  	= requestCheckvar(request("itemid"),9)
	vOpenerChk	= requestCheckvar(request("op"),1)
%>
<!-- #include virtual="/my10x10/event/include_samename_folder_check.asp" -->
<%
SELECT CASE stype
	CASE "I"	'폴더추가
		set myfavorite = new CMyFavorite	
			myfavorite.FRectUserID = userid
			myfavorite.FFolderName = foldername
			myfavorite.fviewisusing = viewisusing
			intResult = myfavorite.fnSetFolder
		set myfavorite = nothing		
		
		IF intResult > 0  THEN
	%>
		<script type="text/javascript">
		
			<%if Cstr(backurl) ="Popmyfavorite_folder.asp" then%>
			<% if vOpenerChk = "1" then %>
				location.href="mywishlist.asp";
			<% else %>
				opener.location.href="mywishlist.asp";
			<% end if %>
			<%end if%>
			location.href ="<%=backurl%>?fidx=<%=intResult%>&bagarray=<%=bagarray%>&mode=<%=mode%>&itemid=<%=itemid%>&op=<%=vOpenerChk%>";

		</script>
<%	
		dbget.Close :response.end
		ELSEIF 	intResult =-1 THEN
			Alert_return("폴더는 10개까지만 등록가능합니다.")	
		dbget.Close :response.end
		ELSE
			Alert_return("데이터처리에 문제가 발생했습니다.")	
		dbget.Close :response.end
		END IF	
	
	CASE "U" 	'폴더수정	
		set myfavorite = new CMyFavorite	
			myfavorite.FFolderIdx      	= fidx
			myfavorite.FFolderName		= foldername
			myfavorite.fviewisusing = viewisusing
			intResult = myfavorite.fnSetFolderUpdate
		set myfavorite = nothing			
		
		IF intResult = 1 THEN
%>
		<script type="text/javascript">

			<% if vOpenerChk = "1" then %>
				location.href="mywishlist.asp";
			<% else %>
				opener.location.href="mywishlist.asp";
			<% end if %>
			location.href ="<%=backurl%>?fidx=<%=fidx%>";

		</script>
<%		
		dbget.Close :response.end		
		ELSE
			Alert_return("데이터처리에 문제가 발생했습니다.")	
		dbget.Close :response.end
		END IF	
	
	CASE "D"		'폴더삭제		
		set myfavorite = new CMyFavorite	
			myfavorite.FFolderIdx      	= fidx
			myfavorite.FRectUserID      	= userid			
			intResult = myfavorite.fnSetFolderDelete
		set myfavorite = nothing			
		
		IF intResult = 1 THEN
%>
		<script type="text/javascript">

			<% if vOpenerChk = "1" then %>
				location.href="mywishlist.asp";
			<% else %>
				opener.location.href="mywishlist.asp";
			<% end if %>
			
			location.href ="<%=backurl%>";

		</script>
<%		
		dbget.Close :response.end		
		ELSE
			Alert_return("데이터처리에 문제가 발생했습니다.")	
		dbget.Close :response.end
		END IF

	CASE "S"	'Sorting 저장 2016-06-17 이종화
		Dim sIdx ,sSortno 
		for i=1 to request.form("chkidx").count
			sIdx = request.form("chkidx")(i)
			sSortNo = request.form("sort"&sIdx)
			if sSortNo="" then sSortNo="0"

			sqlStr = sqlStr & "Update db_my10x10.[dbo].[tbl_myfavorite_folder] Set "
			sqlStr = sqlStr & " sortno='" & sSortNo & "'"
			sqlStr = sqlStr & " Where fidx='" & sIdx & "' and userid= '"& userid &"';" & vbCrLf
			'response.write sSortNo&"<br>"&sIdx&"<br>"&userid&"<p>"
		Next
		'response.write sqlStr
		'response.End
	
		IF sqlStr<>"" Then
			dbget.Execute sqlStr
%>
		<script>
		<!--
			<%if Cstr(backurl) ="popmyfavorite_folder.asp" then%>
				alert('순서가 저장 되었습니다.');
				opener.location.reload();
				location.href="popmyfavorite_folder.asp";
			<%else%>
				window.close();
			<%end if%>
		//-->
		</script>
<%		
			dbget.Close :response.end		
		ELSE
			Alert_return("데이터처리에 문제가 발생했습니다.")	
			dbget.Close :response.end
		END IF		

	CASE ELSE
		Alert_return("데이터처리에 문제가 발생했습니다.")	
	dbget.Close :response.end
END SELECT
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->