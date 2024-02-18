<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'==========================================================================
'	Description: 나의 기념일 조회화면, 이영진
'	History: 2009.04.16
'==========================================================================
	Response.Expires = -1440
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/clsMyAnniversary.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 나의 기념일 알림"		'페이지 타이틀 (필수)
Dim i
i=1

Dim obj	: Set obj = new clsMyAnniversary

obj.CurrPage	= 0
obj.FrontGetList

%>

<!-- #include virtual="/lib/inc/head.asp" -->
<script language='javascript'>

<!--

//오늘하루 이창을 열지 않음
function go(where){
window.opener.location.href=where
window.close()
}
function setCookie( name, value, expiredays )
{
	<%
	response.Cookies("pop").domain = "10x10.co.kr"
	response.cookies("popclose")("today") = "N"
	%>
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
function closeWin()
{
	//if ( document.forms[0].Notice.checked )
	setCookie( "Notice", "no" , 1);
	self.close();
}



// 알리지 않음
function noAlertAnniversary(obj)
{

	var f = document.frmWrite;
	//var idx = getValue(f.idx);
	f.idx.value= obj;
	var idx = f.idx.value;
	if (idx)
	{
		f.submit();
	}

}

window.onload = function(){
	resizeTo(460,580);
}
//-->
</script>


	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
	<!-- 2013.09.26 -->
	<script type="text/javascript">
		$(function() {
			var itemSize = $(".anniversaryList ul li").length;

			$(".anniversaryList ul li").hide();
			$(".anniversaryList ul li:first").show();

			$(".anniversaryList .prevBtn").click(function(){
				$(".anniversaryList ul li:last").prependTo(".anniversaryList ul");
				$(".anniversaryList ul li").hide().eq(0).show();
			});

			$(".anniversaryList .nextBtn").click(function(){
				$(".anniversaryList ul li:first").appendTo(".anniversaryList ul");
				$(".anniversaryList ul li").hide().eq(0).show();
			});

			if ( itemSize > 1 ) {
				$('.prevBtn').show();
				$('.nextBtn').show();
			} else {
				$('.prevBtn').hide();
				$('.nextBtn').hide();
			}
		});
	</script>
	<!-- //2013.09.26 -->
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_anniversary_popup.gif" alt="나의 기념일" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<form name="frmWrite" method="post" action="popAnniversaryProc.asp">
				<input type="hidden" name="mode" value="ALERT">
				<input type="hidden" name="idx" value="" >
				<div class="certCont">
					<div class="anniversaryFinish">
						<!-- 2013.09.26 -->
						<p class="count"><strong>기념일 <em class="crRed"><%= UBound(obj.Items) %>개</em>의 알림이 있습니다.</strong></p>
						<div class="anniversaryList">
							<ul>
							<% For i = 1 To UBound(obj.Items) %>
								<li>
									<p class="result">
										<strong><span class="crRed"><%=obj.Items(i).title%></span>(가)이
										<% If obj.Items(i).getDecimalDay = 0 Then %>
									 	 <span class="crRed">오늘</span>입니다.<br />
									 	<% Else %>
									 	 <span class="crRed"><%= obj.Items(i).getDecimalDay %></span>일 남았습니다.<br />
									 	<% End If %>
											행복한 시간을 준비하세요.
										</strong>
									</p>
									<p class="remember"><strong>잊지마세요!</strong> <%= obj.Items(i).memo %></p>
									<button type="button" onclick="noAlertAnniversary(<%=obj.Items(i).idx%>);" class="btnClear">알림종료</button>
								</li>
							<% Next %>
							</ul>
							<% If UBound(obj.Items) <> 1 Then %>
							<button type="button" class="prevBtn">이전</button>
							<button type="button" class="nextBtn">다음</button>
							<% End If %>
						</div>
						<!-- //2013.09.26 -->
					</div>
				</div>
				</form>
				<!-- //content -->
			</div>
		</div>
		<div class="popFooter">
			<p class="today"><input type="checkbox" name="Notice" value="열지않음" onclick="closeWin();" id="todayNotopen" class="check" /> <label for="todayNotopen">오늘하루 이 창을 열지 않음</label></p>
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>
<%
Set obj = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->