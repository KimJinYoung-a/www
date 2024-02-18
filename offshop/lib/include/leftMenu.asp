<%
'##################################################
' PageName : /offshop/lib/include/leftMenu.asp
' Description : 오프라인숍 왼쪽 메뉴
' History : 2006.12.4 정윤정 생성
'			2008.12.18 한용민 수정 (부천점 제외)
'			2009.06.26 허진원 수정 (its코엑스점 제외)
'##################################################
%>
<script language="JavaScript" type="text/javascript" SRC="/offshop/lib/js/offshopCommon.js"></script>
<table width="244" border="0" cellpadding="0" cellspacing="0" height="500" bgcolor="B0C200" background="http://fiximage.10x10.co.kr/offshop/images/menu_bg.gif">
	<tr> 
    	<td valign="top" height="83"><a href="/offshop/index.asp"><img src="http://fiximage.10x10.co.kr/offshop/images/menu_main.gif" width="245" height="104" border="0"></a></td>
    </tr>
    <tr> 
    	<td valign="top">
        	<table width="245" border="0" cellpadding="0" cellspacing="0">
	        	<tr> 
	            	<td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2"></td>
	          	</tr>
	          	<!---- 대학로점---->
	          	<tr> 
	            	<td height="25"><a href="/offshop/shop/shopinfo.asp?shopid=streetshop011" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image35','','http://fiximage.10x10.co.kr/offshop/images/menu01_roll.gif',1)"><img name="Image35" border="0" src="http://fiximage.10x10.co.kr/offshop/images/menu01<%IF shopid="streetshop011" THEN %>_roll<%END IF%>.gif" width="245" height="25"></a></td>
	          	</tr>
	          	<!---- /대학로점---->
	            <tr> 
	            	<td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2"></td>
	          	</tr>
	          		<!---- 인천점---->
	          	<tr> 
	            	<td height="25"><a href="/offshop/shop/shopinfo.asp?shopid=streetshop012" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image43','','http://fiximage.10x10.co.kr/offshop/images/menu_incheon_roll.gif',1)"><img name="Image43" border="0" src="http://fiximage.10x10.co.kr/offshop/images/menu_incheon<%IF shopid="streetshop012" THEN %>_roll<%END IF%>.gif" width="245" height="25"></a></td>
	          	</tr>
	          	<!---- /인천점---->
	          <!----	<tr> 
	            	<td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2"></td>
	          	</tr>
	          	 미아점
	          	<tr> 
	            	<td height="25"><a href="/offshop/shop/shopinfo.asp?shopid=streetshop003" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image36','','http://fiximage.10x10.co.kr/offshop/images/menu_mia_roll.gif',1)"><img name="Image36" border="0" src="http://fiximage.10x10.co.kr/offshop/images/menu_mia<%IF shopid="streetshop003" THEN %>_roll<%END IF%>.gif" width="245" height="25"></a></td>
	          	</tr>
	          /미아점---->
	          	<tr> 
	            	<td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2"></td>
	          	</tr>
	          	<!---- 일산점---->
	          	<tr> 
	            	<td height="25"><a href="/offshop/shop/shopinfo.asp?shopid=streetshop803" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image37','','http://fiximage.10x10.co.kr/offshop/images/menu_ilsan_roll.gif',1)"><img name="Image37" border="0" src="http://fiximage.10x10.co.kr/offshop/images/menu_ilsan<%IF shopid="streetshop803" THEN %>_roll<%END IF%>.gif" width="245" height="25"></a></td>
	          	</tr>
	          	<!---- /일산점---->
	          		<!--<tr> 
	            	<td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2"></td>
	          	</tr>
	          	<!---- 부천점---->
	          <tr>
	            	<!--<td height="25"><a href="/offshop/shop/shopinfo.asp?shopid=streetshop013" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image38','','http://fiximage.10x10.co.kr/offshop/images/menu_bucheon_roll.gif',1)"><img name="Image38" border="0" src="http://fiximage.10x10.co.kr/offshop/images/menu_bucheon<%IF shopid="streetshop812" THEN %>_roll<%END IF%>.gif" width="245" height="25"></a></td>-->
	          	<!--</tr>-->
	          	<!---- /부천점---->
	          	<!--<tr> 
	            	<td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2"></td>
	          	</tr>
	          	<!---- 대구점---->
	          	<!----<tr> 
	            	<td height="25"><a href="/offshop/shop/shopinfo.asp?shopid=streetshop805" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image39','','http://fiximage.10x10.co.kr/offshop/images/menu_daegu_roll.gif',1)"><img name="Image39" border="0" src="http://fiximage.10x10.co.kr/offshop/images/menu_daegu<%IF shopid="streetshop805" THEN %>_roll<%END IF%>.gif" width="245" height="25"></a></td>
	          	</tr>---->
	          	<!---- /대구점---->
	          	<tr> 
	            	<td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2"></td>
	          	</tr>
	          	<!---- 진주점---->
	          	<tr> 
	            	<td height="25"><a href="/offshop/shop/shopinfo.asp?shopid=streetshop807" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image40','','http://fiximage.10x10.co.kr/offshop/images/menu_jinju_roll.gif',1)"><img name="Image40" border="0" src="http://fiximage.10x10.co.kr/offshop/images/menu_jinju<%IF shopid="streetshop807" THEN %>_roll<%END IF%>.gif" width="245" height="25"></a></td>
	          	</tr>
	          	<!---- /진주점---->
	          	<tr> 
	            	<td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2"></td>
	          	</tr>
	          	<!---- 창원점---->
	          	<tr> 
	            	<td height="25"><a href="/offshop/shop/shopinfo.asp?shopid=streetshop801" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image41','','http://fiximage.10x10.co.kr/offshop/images/menu_changwon_roll.gif',1)"><img name="Image41" border="0" src="http://fiximage.10x10.co.kr/offshop/images/menu_changwon<%IF shopid="streetshop801" THEN %>_roll<%END IF%>.gif" width="245" height="25"></a></td>
	          	</tr>
	          	<!---- /창원점---->
	          	<tr> 
	            	<td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2"></td>
	          	</tr>
	          	<!---- 구미점---->
	          	<tr> 
	            	<td height="25"><a href="/offshop/shop/shopinfo.asp?shopid=streetshop808" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image42','','http://fiximage.10x10.co.kr/offshop/images/menu_gumi_roll.gif',1)"><img name="Image42" border="0" src="http://fiximage.10x10.co.kr/offshop/images/menu_gumi<%IF shopid="streetshop808" THEN %>_roll<%END IF%>.gif" width="245" height="25"></a></td>
	          	</tr>
	          	<!---- /구미점---->
	          	<tr> 
	            	<td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2"></td>
	          	</tr>
        	</table>
      	</td>
	</tr>
	<!--ithinkso-->	     
    <tr>
      <td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_ithinkso2.gif" width="245" height="49" /></td>
    </tr>
    <!---- 변경되는부분 아이띵소홍대점---->
    <tr>
      <td><a href="/offshop/shop/shopinfo.asp?shopid=streetshop874"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image44','','http://fiximage.10x10.co.kr/offshop/images/menu_ithinksohong_roll.GIF',1)"><img name="Image44" src="http://fiximage.10x10.co.kr/offshop/images/menu_ithinkso_hong.gif" width="245" height="25" border="0"/></a></td>
    </tr>
    <tr>
      <td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2" /></td>
    </tr>
    <!---- 변경되는부분 아이띵소코엑스점---->
    <!--tr>
      <td><a href="/offshop/shop/shopinfo.asp?shopid=streetshop876"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image45','','http://fiximage.10x10.co.kr/offshop/images/menu_ithinkso_coex_roll.gif',1)""><img name="Image45" src="http://fiximage.10x10.co.kr/offshop/images/menu_ithinkso_coex.gif" width="245" height="25" border="0"/></a></td>
    </tr-->
    <tr>
      <td><img src="http://fiximage.10x10.co.kr/offshop/images/menu_line.gif" width="245" height="2" /></td>
    </tr>
    <!--취화선-->
    <tr> 
    	<td height="88"><a href="/offshop/shop/shopinfo.asp?shopid=cafe002"><img src="http://fiximage.10x10.co.kr/offshop/images/menu_bar.gif" width="245" height="100" border="0"></a></td>
    </tr>
</table>
