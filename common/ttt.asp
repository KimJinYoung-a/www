<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<% 
dim BASELNK : BASELNK="/apps/appCom/wish/web2014"
dim IsShow_OLDPROTOCOL : IsShow_OLDPROTOCOL= FALSE
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="format-detection" content="telephone=no" />
<title><%= "타이틀" %></title>
<link rel="stylesheet" type="text/css" href="/lib/css/default.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/common.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/content.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/mytenten.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/commonV15.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/productV15.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/mytentenV15.css" />
<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript" src="/lib/js/swiper-2.1.min.js"></script>
<script type="text/javascript" src="/lib/js/common.js"></script>
<script type="text/javascript" src="/lib/js/tenbytencommon.js?v=1.0"></script>
<script type="text/javascript" src="/lib/js/keyMovePage.js"></script>

</head>

<body style="font-size:12px;">
    <div style="padding:20px;">
        <ul style="line-height: 150%;">
            <li>현재 <b>운영 서버</b>입니다.(<%=application("Svr_Info")%>) <input type="button" value="Go TEST Srv." onClick="document.location.href='http://testm.10x10.co.kr/apps/appcom/wish/web2014/pagelist.asp';"></li>
            <li align="right"><input type="button" value="Reload" onClick="document.location.reload();"></li>
            <br>
            
             <li>
                <ul>
                    <li><%=request.serverVariables("REMOTE_ADDR")%> / <%= now() %>
                   
                    <li>
                    </ul>
            </li>
            
        </ul>
    </div>
</body>
</html>