<%
'###########################################################
' Description : 컬러트랜드 클래스
' Hieditor : 2012.04.03 한용민 생성
'###########################################################

class ccolortrend_item
	public fctcode
	public fcolorcode
	public fisusing
	public fstate
	public fmainimage
	public fmainimagelink
	public ftextimage
	public fstartdate
	public flastupdate
	public fregdate
	public flastadminid
	public fcolorName
	public fColorIcon
	public fstatename
	public Fidx
	public Fitemid
	public forderno
	public Fitemname
	public FImageSmall
	public Fsellyn
	public Flimityn
	public Flimitno
	public Flimitsold
	public fsortNo
	public FImageList
	public FImageIcon1
	public fuserid
	public FImageIcon2
	public Fviewno
	public FNmainimg
	public Fcolortitle
	public FExist
	public Ftotregcnt
	public FPreCTcode
	public FNextCTcode
	public FImageMap
	public FEvalCnt
	public FfavCount
	
	Private Sub Class_Initialize()
	End Sub
	Private Sub Class_Terminate()
	End Sub
end class

class ccolortrend_list
	Public FItemList()
	public foneitem
	Public FResultCount
	Public FTotalCount
	Public FScrollCount
	public FPageCount
	Public FCurrPage
	Public FPageSize
	public FTotalPage
	public frectctcode
	public frectcolorcode
	public frectstate
	public frectisusing
	public frectitemid
	public frectitemname
	public frectexists
	public FRectSortMethod	
	public frectmode
	public frectuserid
	public fcolorcode
	
	Private Sub Class_Initialize()
		FCurrPage =1
		FPageSize = 50
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
		
		frectexists = ""
	End Sub
	Private Sub Class_Terminate()
	End Sub

	'// 상품 이미지 폴더 반환(컬러코드 유무에 따라 일반/컬러칩 구분)
	Function getItemImageUrl()
		IF application("Svr_Info")	= "Dev" THEN
			if frectcolorcode="" or frectcolorcode="0" then
				getItemImageUrl = "http://webimage.10x10.co.kr/image"
			else
				getItemImageUrl = "http://webimage.10x10.co.kr/color"
			end if
		Else
			if frectcolorcode="" or frectcolorcode="0" then
				getItemImageUrl = "http://webimage.10x10.co.kr/image"
			else
				getItemImageUrl = "http://webimage.10x10.co.kr/color"
			end if
		End If
	end function

	'//colortrend/index.asp
	Public Function GetColoritemlist()	
        dim strSQL, i
        
        strSQL = "exec db_item.dbo.sp_ten_coloritemcnt '"&frectcolorcode&"'"
		
		'response.write strSQL & "<Br>"
		rsget.Open strSQL, dbget
            FTotalCount = rsget("cnt")
        rsget.Close

        if FTotalCount < 1 then exit Function
        
        strSQL = "exec db_item.dbo.sp_ten_coloritemlist '"&frectcolorcode&"','"&FRectSortMethod&"',"&CStr(FPageSize*FCurrPage)&""
			
		'response.write strSQL & "<Br>"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open strSQL, dbget, 1

	    FtotalPage = CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
        
        if (FResultCount<1) then FResultCount=0
        
		redim preserve FItemList(FResultCount)

        if not rsget.EOF then
            i = 0
            rsget.absolutepage = FCurrPage
            do until (rsget.eof)
                set FItemList(i) = new ccolortrend_item

	            FItemList(i).fcolorcode = rsget("colorcode")
	            FItemList(i).fitemid = rsget("itemid")
	            FItemList(i).forderno = rsget("orderno")
	            FItemList(i).fisusing = rsget("isusing")
				FItemList(i).FImageList 	= getItemImageUrl & "/list/" & GetImageSubFolderByItemid(FItemList(i).FItemid) & "/" & rsget("listimage")
				FItemList(i).FImageIcon1 	= getItemImageUrl & "/icon1/" & GetImageSubFolderByItemid(FItemList(i).FItemid) & "/" & rsget("icon1image")
				FItemList(i).FImageIcon2 	= getItemImageUrl & "/icon2/" & GetImageSubFolderByItemid(FItemList(i).FItemid) & "/" & rsget("icon2image")
				FItemList(i).FEvalCnt = rsget("evalcnt")
				FItemList(i).FfavCount = rsget("favcount")
				
        		rsget.MoveNext
        		i = i + 1
            loop
        end if
        rsget.close
	end Function
	
	'//colortrend/index.asp
	Public Function GetColortrendlist()	
        dim strSQL, i
        
        strSQL = "exec db_item.dbo.sp_ten_colortrendcnt '"&frectcolorcode&"'"
		'response.write strSQL & "<Br>"
		rsget.Open strSQL, dbget
            FTotalCount = rsget("cnt")
        rsget.Close
        
        if FTotalCount < 1 then exit Function
        
        strSQL = "exec db_item.dbo.sp_ten_colortrendlist '" & frectcolorcode & "', '" & CStr(FPageSize*FCurrPage) & "', '" & frectuserid & "'"	
		'response.write strSQL & "<Br>"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open strSQL, dbget, 1

	    FtotalPage = CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
        
        if (FResultCount<1) then FResultCount=0
        
		redim preserve FItemList(FResultCount)

        if not rsget.EOF then
            i = 0
            rsget.absolutepage = FCurrPage
            do until (rsget.eof)
                set FItemList(i) = new ccolortrend_item

	            FItemList(i).fctcode = rsget("ctcode")
	            FItemList(i).fcolorcode = rsget("colorcode")
	            FItemList(i).fstate = rsget("state")
	            FItemList(i).fmainimage = rsget("mainimage")
	            FItemList(i).fmainimagelink = db2html(rsget("mainimagelink"))
	            FItemList(i).ftextimage = rsget("textimage")
	            FItemList(i).fstartdate = rsget("startdate")
	            FItemList(i).Fviewno = rsget("viewno")
	            FItemList(i).FNmainimg = rsget("Nmainimg")
	            FItemList(i).FImageMap = db2html(rsget("mainimagelinknew"))
	            FItemList(i).Fcolortitle = db2html(rsget("colortitle"))
	            FItemList(i).Ftotregcnt = rsget("totalcnt")
	            If rsget("exist") <> "" Then
	            	FItemList(i).FExist = "Y"
	            Else
	        		FItemList(i).FExist = "N"
	        	End IF
    			
        		rsget.MoveNext
        		i = i + 1
            loop
        end if
        rsget.close
	end Function
	
	
	Public Function GetColorTrendDetail()
        dim strSQL, i

		strSQL = "exec db_item.dbo.sp_Ten_ColorTrend_Detail '" & frectctcode & "', '" & frectuserid & "'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open strSQL, dbget, 1

        FTotalCount = rsget.RecordCount

        if not rsget.EOF then
            set FOneItem = new ccolortrend_item

            FOneItem.fctcode = rsget("ctcode")
            FOneItem.fcolorcode = rsget("colorcode")
            FOneItem.Fviewno = rsget("viewno")
            FOneItem.FNmainimg = rsget("Nmainimg")
            FOneItem.Fcolortitle = db2html(rsget("colortitle"))
            FOneItem.FImageMap = db2html(rsget("mainimagelinknew"))
            FOneItem.Ftotregcnt = rsget("totalcnt")
            FOneItem.FPreCTcode = CHKIIF(isNull(rsget("prectcode"))=True,"",rsget("prectcode"))
            FOneItem.FNextCTcode = CHKIIF(isNull(rsget("nextctcode"))=True,"",rsget("nextctcode"))
            If rsget("exist") <> "" Then
            	FOneItem.FExist = "Y"
            Else
        		FOneItem.FExist = "N"
        	End IF

        end if
        rsget.close
	end Function
	
	
	'//colortrend/index.asp
	Public Function GetColorthisweek()
        dim strSQL, i

		strSQL = "exec db_item.dbo.sp_ten_colorthisweek"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open strSQL, dbget, 1

        FTotalCount = rsget.RecordCount

        if not rsget.EOF then
            set FOneItem = new ccolortrend_item

            FOneItem.fctcode = rsget("ctcode")
            FOneItem.fcolorcode = rsget("colorcode")

        end if
        rsget.close
	end Function
	
	'//colortrend/index.asp
	Public Function GetColorchips()	
        dim strSQL, i
        
        strSQL =" EXECUTE db_item.dbo.sp_ten_colorchips '"&fcolorcode&"'"
			
		'response.write strSQL
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open strSQL, dbget, 1

		FTotalCount = rsget.RecordCount
		FResultCount = rsget.RecordCount

		redim preserve FItemList(FResultCount)

        if not rsget.EOF then
            i = 0
            rsget.absolutepage = FCurrPage
            do until (rsget.eof)
                set FItemList(i) = new ccolortrend_item
    
                FItemList(i).FcolorCode	= rsget("colorCode")
                FItemList(i).FcolorName	= rsget("colorName")
                FItemList(i).FcolorIcon	= webImgUrl & "/color/colorchip/" & rsget("colorIcon")
                FItemList(i).FsortNo	= rsget("sortNo")
                FItemList(i).FisUsing	= rsget("isUsing")
    			
    			'//넘겨받은 컬러 코드가 존재하는 컬러인지 체크
    			if frectcolorcode = cstr(rsget("colorCode")) then
    				frectexists = "Y"
    			end if
    			
        		rsget.MoveNext
        		i = i + 1
            loop
        end if
        rsget.close
	end Function

	'//colortrend/index.asp
	Public Function GetColorchipsmyfavorite()	
        dim strSQL, i
        
        strSQL =" EXECUTE db_item.dbo.sp_ten_colorchips_myfavorite '"&userid&"'"
			
		'response.write strSQL
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open strSQL, dbget, 1

		FTotalCount = rsget.RecordCount
		FResultCount = rsget.RecordCount

		redim preserve FItemList(FResultCount)

        if not rsget.EOF then
            i = 0
            rsget.absolutepage = FCurrPage
            do until (rsget.eof)
                set FItemList(i) = new ccolortrend_item
    
                FItemList(i).FcolorCode	= rsget("colorCode")
                FItemList(i).FcolorName	= rsget("colorName")
                FItemList(i).FcolorIcon	= webImgUrl & "/color/colorchip/" & rsget("colorIcon")
                FItemList(i).FsortNo	= rsget("sortNo")
                FItemList(i).FisUsing	= rsget("isUsing")
				FItemList(i).fuserid	= rsget("userid")
    			
        		rsget.MoveNext
        		i = i + 1
            loop
        end if
        rsget.close
	end Function
	
	public Function HasPreScroll()
		HasPreScroll = StartScrollPage > 1
	end Function
	public Function HasNextScroll()
		HasNextScroll = FTotalPage > StartScrollPage + FScrollCount -1
	end Function
	public Function StartScrollPage()
		StartScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	end Function
end class

'/my10x10/popMyFavoritecolor.asp
function myfavoritecoloradd(getEncLoginUserID,colorcode,mode)
	dim sqlStr
	
	if getEncLoginUserID = "" or colorcode = "" or mode = "" then exit function
		
	if mode = "add" then
		sqlStr = "if exists(" + vbcrlf
		sqlStr = sqlStr & "		select top 1 * " + vbcrlf
		sqlStr = sqlStr & "		from db_item.dbo.tbl_colorfavorite" + vbcrlf
		sqlStr = sqlStr & "		where colorcode = "&colorcode&"" + vbcrlf
		sqlStr = sqlStr & "		and userid = '"&userid&"'" + vbcrlf
		sqlStr = sqlStr & "	)" + vbcrlf
		sqlStr = sqlStr & "		update db_item.dbo.tbl_colorfavorite" + vbcrlf
		sqlStr = sqlStr & "		set regdate = getdate(), isusing='Y' " + vbcrlf
		sqlStr = sqlStr & "		where colorcode = "&colorcode&"" + vbcrlf
		sqlStr = sqlStr & "		and userid = '"&userid&"'" + vbcrlf
		sqlStr = sqlStr & "	else" + vbcrlf
		sqlStr = sqlStr & "		insert into db_item.dbo.tbl_colorfavorite (colorcode ,userid ,isusing ,regdate) values (" + vbcrlf
		sqlStr = sqlStr & "		"&colorcode&",'"&userid&"','Y',getdate())"
		
		'response.write sqlStr &"<Br>"
		dbget.execute sqlStr
	end if		
end function


Function fnColorTrendColorName(cd)
	Dim vName
	SELECT CASE cd
		CASE "23" : vName = "wine"
		CASE "1" : vName = "red"
		CASE "2" : vName = "orange"
		CASE "10" : vName = "brown"
		CASE "21" : vName = "camel"
		CASE "3" : vName = "yellow"
		CASE "4" : vName = "beige"
		CASE "24" : vName = "ivory"
		CASE "19" : vName = "khaki"
		CASE "5" : vName = "green"
		CASE "16" : vName = "mint"
		CASE "6" : vName = "skyblue"
		CASE "7" : vName = "blue"
		CASE "20" : vName = "navy"
		CASE "8" : vName = "violet"
		CASE "18" : vName = "lilac"
		CASE "17" : vName = "babypink"
		CASE "9" : vName = "pink"
		CASE "11" : vName = "white"
		CASE "12" : vName = "grey"
		CASE "22" : vName = "charcoal"
		CASE "13" : vName = "black"
		CASE "14" : vName = "silver"
		CASE "15" : vName = "gold"
		CASE "25" : vName = "check"
		CASE "26" : vName = "stripe"
		CASE "27" : vName = "dot"
		CASE "28" : vName = "flower"
		CASE "29" : vName = "drawing"
		CASE "30" : vName = "animal"
		CASE "31" : vName = "geometric"
		CASE Else vName = "all"
	END SELECT
	fnColorTrendColorName = vName
End Function
%>