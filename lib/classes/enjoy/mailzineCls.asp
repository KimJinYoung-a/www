<%

class CMailzineMasterSubItem

	public Fidx
	public Fregdate
	public Fcode1
	public Fcode2
	Public FTitle
	public Fsecretgubun
	public FfixedHTML

	Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub

end class

class CMailzineMaster
'########################################
'실제등록상품 데이터
'########################################
	public FItemList()
	public FTotalCount
	public FResultCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FScrollCount
	public FPageCount
	Public RoundUP
	Public FRegdate
	Public FImg1
	Public FImg2
	Public FImg3
	Public FImg4
	Public FImgMap1
	Public FImgMap2
	Public FImgMap3
	Public FImgMap4
	Public FTitle
	Public FIdx
	Public FNextIdx
	Public FPreIdx
	public Fsecretgubun
	public FfixedHTML
	Public Icode1
	Public Icode2

	Private Sub Class_Initialize()
		FCurrPage =1
		FPageSize = 10
		FResultCount = 0
		FScrollCount = 5
		FTotalCount =0
	End Sub

	Private Sub Class_Terminate()

	End Sub

	public sub MailzineIdx()
		dim sqlStr,i,code
		sqlStr = "exec db_sitemaster.dbo.sp_Ten_Mailzine_GetIdx "
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
			FIdx = rsget("idx")
			code = split(rsget("regdate"),".")
			Icode1 = code(0)
			Icode2 = code(1) + code(2)
		rsget.Close
	End Sub

	public sub MailzineView()
		dim sqlStr,i,code
		sqlStr = "exec db_sitemaster.dbo.sp_Ten_Mailzine_View '" & FIdx & "' "
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
		If rsget.Eof Then
			Response.Write "<script>alert('잘못된 경로입니다.');top.location.href='/shoppingtoday/shoppingchance_mailzine.asp';</script>"
			dbget.close()
			Response.End
		Else
			FRegdate	= rsget("regdate")
			FImg1		= rsget("img1")
			FImg2		= rsget("img2")
			FImg3		= rsget("img3")
			FImg4		= rsget("img4")
			FImgMap1	= rsget("imgmap1")
			FImgMap2	= rsget("imgmap2")
			FImgMap3	= rsget("imgmap3")
			FImgMap4	= rsget("imgmap4")
			FTitle		= rsget("title")
			FPreIdx		= rsget("preidx")
			FNextIdx	= rsget("nextidx")
			Fsecretgubun = rsget("secretgubun")
			FfixedHTML 	= rsget("fixedHTML")
		End If
		rsget.Close
	End Sub


	public sub MailzineList()
		dim sqlStr,i,code


		'###########################################################################
		'상품 총 갯수 구하기
		'###########################################################################

		sqlStr = "exec db_sitemaster.dbo.sp_Ten_Mailzine_GetListCnt "
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
		FTotalCount = rsget("cnt")
		rsget.Close

		'###########################################################################
		'상품 데이터
		'###########################################################################
		If int(FCurrPage) > int(FTotalCount/7)+1 Then
			response.write "<script language='javascript'>top.location.href = '/shoppingtoday/shoppingchance_mailzine.asp';</script>"
			exit sub
		End IF


 		sqlStr = "exec db_sitemaster.dbo.sp_Ten_Mailzine_GetList '" & FPageSize * FCurrPage & "'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		if (FCurrPage * FPageSize < FTotalCount) then
			FResultCount = FPageSize
		else
			FResultCount = FTotalCount - FPageSize*(FCurrPage-1)
		end if

		FTotalPage = (FTotalCount\FPageSize)
		if (FTotalPage<>FTotalCount/FPageSize) then FTotalPage = FTotalPage +1

		if (FTotalCount mod FPageSize) = 0 then
			 RoundUP = FTotalCount/FPageSize
		else
			 RoundUP = int(FTotalCount/FPageSize)+1
		end if

		redim preserve FItemList(FResultCount)

		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
		do until rsget.EOF
				set FItemList(i) = new CMailzineMasterSubItem
				FItemList(i).Fidx = rsget("idx")
			    FItemList(i).Fregdate = rsget("regdate")
                code = split(FItemList(i).Fregdate,".")
				FItemList(i).Fcode1 = code(0)
				FItemList(i).Fcode2 = code(1) + code(2)
				FItemList(i).FTitle = db2html(rsget("title"))
				FItemList(i).Fsecretgubun = rsget("secretgubun")
				rsget.movenext
				i=i+1
			loop
		end if
		rsget.Close
	end sub

	public Function HasPreScroll()
		HasPreScroll = StarScrollPage > 1
	end Function

	public Function HasNextScroll()
		HasNextScroll = FTotalPage > StarScrollPage + FScrollCount -1
	end Function

	public Function StarScrollPage()
		StarScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	end Function

end Class


class CMailzineDetail

  public Fimgmap

'########################################
'실제등록상품 데이터
'########################################

	Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub

	public sub MailzineDetail(byval idx)

		dim sqlStr

		'###########################################################################
		'상품 데이터
		'###########################################################################

		sqlStr = "select imgmap1" + vbcrlf
		sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_mailzine" + vbcrlf
		sqlStr = sqlStr & " where idx = " + idx

		rsget.Open sqlStr,dbget

		if  not rsget.EOF  then
			Fimgmap = db2html(rsget("imgmap1"))
		end if

		rsget.Close
	end sub
end Class
%>
