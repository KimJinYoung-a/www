<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'##################################################
' PageName : /offshop/point/card_shopguide.asp
' Description : 오프라인샾 point1010 가맹점안내
' History : 2009.07.17 강준구 생성
'##################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/offshop/lib/classes/offshopCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/offshop/lib/commonFunction.asp" -->
<!-- #include virtual="/offshop/lib/header.asp" -->

<table width="960" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="170" style="padding-top:41px;" align="center" valign="top"><!-- // 왼쪽 메뉴 // -->
      <!-- #include virtual="/offshop/lib/leftmenu/point1010Left.asp" -->
    </td>
    <td width="790" style="padding-top: 30px;" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="right" width="760" valign="top"><table width="730" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center" valign="top"><table width="730" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td style="padding:28px 0 5px 0; border-bottom:1px solid #e2e2e2;"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub03_tit.gif" width="86" height="20" style="margin-left:10px;"></td>
                    </tr>
                    <tr>
                      <td style="padding:30px 0;" align="center"><table width="700" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><img src="http://fiximage.10x10.co.kr/tenbytenshop/point1010_sub03_img.gif" width="660" border="0" usemap="#Map"></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
          <td width="30" valign="top"><div style="position:absolute; width:55px; height:95px; top:115px; margin-left:10px;"> <img src="http://fiximage.10x10.co.kr/tenbytenshop/object_sticker.gif" width="55" height="95"> </div></td>
        </tr>
      </table></td>
  </tr>
</table>
<map name="Map">
  <area shape="rect" coords="5,313,141,363" href="/offshop/shopinfo.asp?shopid=streetshop011" onFocus="blur()">
  <area shape="rect" coords="191,311,317,362" href="http://ithinkso.co.kr/" target="_blank" onFocus="blur()">
  <area shape="rect" coords="355,313,480,363" href="/offshop/shopinfo.asp?shopid=cafe002" onFocus="blur()">
  <area shape="rect" coords="526,313,644,363" href="/offshop/shopinfo.asp?shopid=streetshop091" onFocus="blur()">
  <area shape="rect" coords="6,420,116,474" href="/offshop/shopinfo.asp?shopid=streetshop011" onFocus="blur()">
  <area shape="rect" coords="129,420,229,473" href="http://ithinkso.co.kr/" target="_blank" onFocus="blur()">
  <area shape="rect" coords="241,421,323,473" href="/offshop/shopinfo.asp?shopid=cafe002" onFocus="blur()">
  <area shape="rect" coords="329,419,426,472" href="/offshop/shopinfo.asp?shopid=streetshop091" onFocus="blur()">
  <area shape="rect" coords="436,419,522,473" href="http://www.thefingers.co.kr/" target="_blank" onFocus="blur()">
  <area shape="rect" coords="535,422,647,474" href="http://www.10x10.co.kr/" target="_blank" onFocus="blur()">
  <area shape="rect" coords="421,481,480,498" href="/offshop/point/point_switch.asp" onFocus="blur()">
</map>
<!-- #include virtual="/offshop/lib/tailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
