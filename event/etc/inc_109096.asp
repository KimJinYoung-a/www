<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<%
'####################################################
' Description : 2000 마일리지 이벤트
' History : 2021-01-18 정태훈
'####################################################
%>
<style type="text/css">
.evt109096 {position:relative;}
.evt109096 .topic {position:relative;}
.evt109096 .topic .txt_name {width:100%; position:absolute; left:22px; top:95px; font-size:29px; color:#443e34; font-weight:600;}
.evt109096 .section-01 {position:relative;}
.evt109096 .section-01 .link-area {position:absolute; left:0; top:0; width:100%; height:100%; display:flex;}
.evt109096 .section-01 .link-area a {display:inline-block; width:50%; height:100%;}
</style>
						<div class="evt109096">
							<div class="topic">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/109096/img_tit.jpg" alt="마일리지 2000p 를 지원해 드립니다.">
                                <div class="txt_name"><span><% if GetLoginUserName<>"" then%><%=GetLoginUserName%><% else %>고객<% end if %></span>님께 도착한 마일리지레터</div>
                            </div>
                            <div class="section-01">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/109096/img_sub01.jpg" alt="마일리지 받는 방법,더 알차게 사용하는 꿀팁">
                                <div class="link-area">
                                    <a href="http://www.10x10.co.kr/my10x10/mymain.asp" target="_blank"></a>
                                    <a href="http://www.10x10.co.kr/event/benefit/" target="_blank"></a>
                                </div>
                            </div>
                            <div class="section-02">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/109096/img_sub02.jpg" alt="마일리지는 결제 시 현금처럼 사용하실 수 있습니다.">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/109096/img_sub03.jpg" alt="이벤트 유의사항">
                            </div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->