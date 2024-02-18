<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<%
'#############################################################################
' SNS �̺�Ʈ 
' 2015-02-05 FB SNS
'#############################################################################
	Dim eCode
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  20911
	Else
		eCode   =  59411
	End If
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" type="text/css" href="/lib/css/default.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/common.css?v=1.0" />
<link rel="stylesheet" type="text/css" href="/lib/css/content.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/mytenten.css" />
<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js"></script>
<div id="fb-root"></div>
<script>
	window.fbAsyncInit = function() {
//		�Ź���	
		FB.init({
			appId      : '791158574254369',
			cookie     : true,  // enable cookies to allow the server to access 
			xfbml      : true,  // parse social plugins on this page
			version    : 'v2.1' // use version 2.1
		});

		// Additional initialization code here
		FB.getLoginStatus(function(response) {
			if (response.status === 'connected') {
				// facebook ȸ�� ���� ��ȸ
				getinfo();
			} else if (response.status === 'not_authorized') {
				// facebook ȸ�� ���� ��ȸ
				getinfo();
			} else {
				// facebook ȸ�� ���� ��ȸ
				getinfo();
			}
		});

		// facebook height auto resize
		FB.Canvas.setAutoGrow();
	};

	function getinfo() {
		//����� ���� �޾ƿ��ÿ�
		FB.api('me/',
		function(response) {
			 fbuid = response.id;
			 fbname = response.name;
			 fbemail = response.email;
			 fbuphoto = "https://graph.facebook.com/"+response.id+"/picture";
			 }
		);
	}

	//Load the SDK Asynchronously
	(function(d){  
		var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];  
		if (d.getElementById(id)) {return;}  
		js = d.createElement('script'); js.id = id; js.async = true;  
		js.src = "//connect.facebook.net/ko_KR/sdk.js";
		ref.parentNode.insertBefore(js, ref);  
	}(document));
</script>
<script>
	function tenten_sns() // ���ƿ� Ȯ��
	{
		//���ƿ� ��� ���� 
		FB.login(function(response) {
			if (response.status == "connected"){
					$("#eventopen").css("display","none");
					$("#cmtopen").css("display","");
					$("#commentarea").css("display","block");
			}else{
				alert("�̺�Ʈ ������ ���� ������ �㰡�� �ּ���.");
			}
		});
//		FB.api('/me/likes/181120081908512',function(response) {
//			if( response.data ) {
//				if( response.data != '' ){
//					$("#eventopen").css("display","none");
//					$("#cmtopen").css("display","");
//					$("#commentarea").css("display","block");
////					var pheight = document.body.clientHeight ;
////					parent.setFrame(parseInt(pheight));
//				}else{
//					getinfo();
//					alert("�̺�Ʈ�� �����Ͻ÷��� ���ƿ� ��ư�� ���� �ּ���.");
//					return false;
//				}
//			} else {
//				
//			}
//		});
	}
	
	// Permissions that are needed for the app
	var permsNeeded = ["public_profile","email","user_likes"];

	// Function that checks needed user permissions
	var checkPermissions = function()
	{
		FB.getLoginStatus(function(response) {
			if (response.status === 'connected') {
				// facebook ȸ�� ���� ��ȸ
				FB.api('/me/permissions', function(response){
//					console.log(JSON.stringify(response));
//					alert(JSON.stringify(response));
					//var permsArray = response.data[0];
					var permsArray = response;
					var permsToPrompt = [];
					for (var i in permsNeeded)
					{
//					console.log(permsArray.data[i].status);
						if (permsArray.data[i].status == "declined" )
						{
							permsToPrompt.push(permsNeeded[i]);
						}
					}
//					console.log(permsToPrompt);
//					console.log(permsToPrompt.length);
					if (permsToPrompt.length > 0)
					{
						//console.log('Need to re-prompt user for permissions: ' +  permsToPrompt.join(','));
						promptForPerms(permsToPrompt);
					}
					else
					{
						//console.log('No need to prompt for any permissions');
						tenten_sns();
					}
				});
			} else if (response.status === 'not_authorized') {
				promptForPerms(permsNeeded);
			} else {
				promptForPerms(permsNeeded);
			}
		});
	};

	// Function that checks needed user permissions
	var checkPermissions2 = function()
	{
		FB.api('/me/permissions', function(response)
		{
			//var permsArray = response.data[0];
			var permsArray = response;
			var permsToPrompt = [];
			for (var i in permsNeeded)
			{
				if (permsArray.data[i].status == "declined" )
				{
					permsToPrompt.push(permsNeeded[i]);
				}
			}
			if (permsToPrompt.length > 0)
			{
				getinfo();
				//console.log('Check2 Need to re-prompt user for permissions: ' +  permsToPrompt.join(','));
				alert("�̺�Ʈ ������ ���� ������ �㰡�� �ּ���.");
			}
			else
			{
				//console.log('Check2 No need to prompt for any permissions');
				tenten_sns();
			}
		});
	};

	//Re-prompt user for missing permissions
	var promptForPerms = function(perms)
	{
		FB.login(function(response) {
			if (response.status == "connected"){
				checkPermissions2();
			}else{
				alert("�̺�Ʈ ������ ���� ������ �㰡�� �ּ���.");
			}
		},{
			scope: perms.join(','),
			auth_type: 'rerequest'
		});
	};

	function eventGo()
	{
		//checkPermissions();
		tenten_sns();
		return;
	}


</script>
<script>
	function jsSubmitComment(frm){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

	   if(!(frm.spoint[0].checked||frm.spoint[1].checked||frm.spoint[2].checked)){
	    alert("��ǰ�� �������ּ���");
	    return false;
	   }

	   if(!frm.txtcomm.value||frm.txtcomm.value=="�ٹ����� SNS���� �ٶ�� ��, ������ �޽����� �����ּ���!"){
	    alert("������ �޽����� �����ּ���");
	    document.frmcom.txtcomm.value="";
	    frm.txtcomm.focus();
	    return false;
	   }
	   	if(GetByteLength(frm.txtcomm.value)>200){
			alert('�ִ� �ѱ� 100�� ���� �Է� �����մϴ�.');
	    frm.txtcomm.focus();
	    return false;
		}

	   frm.action = "/event/lib/comment_process.asp";
	   return true;
	}

	function jsChklogin11(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.txtcomm.value =="�ٹ����� SNS���� �ٶ�� ��, ������ �޽����� �����ּ���!"){
				document.frmcom.txtcomm.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChkUnblur()
	{

		if(document.frmcom.txtcomm.value ==""){
			document.frmcom.txtcomm.value="�ٹ����� SNS���� �ٶ�� ��, ������ �޽����� �����ּ���!";
		}
	}

	function Limit(obj)
	{
	   var maxLength = parseInt(obj.getAttribute("maxlength"));
	   if ( obj.value.length > maxLength ) {
		alert("���ڼ��� �ִ� 100�� �Դϴ�.");
		obj.value = obj.value.substring(0,maxLength); //100�� ���� ƨ���
		}
	}
</script>
<style type="text/css">
	.evt42900 {width:960px;}
	.evt42900 img {vertical-align:top; display:inline;}
	.evt42900 .snsView {background:url(http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_bg1.jpg) left top no-repeat; width:100%; height:520px; position:relative;}
	.evt42900 .snsView p {position:absolute;}
	.evt42900 .snsView .twFollow {left:289px; top:336px;}
	.evt42900 .snsView .faLike {left:550px; top:345px;}
	.evt42900 .snsView .evtBtn {left:50%; bottom:0; margin-left:-123px;}
	.evt42900 .giftSelect {background:url(http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_bg2.jpg) left top repeat-y; padding:30px 0 45px 0;}
	.evt42900 .giftSelect ul {overflow:hidden; _zoom:1; width:645px; margin:0 auto;}
	.evt42900 .giftSelect ul li {float:left; padding:0 5px; text-align:center;}
	.evt42900 .giftSelect ul li p {padding:3px 0;}
	.evt42900 .cmtInput {overflow:hidden; _zoom:1; width:745px; margin:30px auto; background:#fff; border:5px solid #6d9aee;}
	.evt42900 .cmtInput p { background:#fff;}
	.evt42900 .cmtInput p.ftLt {width:618px; height:101px; text-align:right;}
	.evt42900 .cmtInput p textarea {border:1px solid #fff; font-size:12px; color:#888; padding:5px 0;}
	.evt42900 .snsBtn {padding-top:12px;text-align:center;}
	.evt42900 .snsBtn img {margin:0 8px;}
	input[type=image] {vertical-align:top;}
</style>
</head>
<div class="evt42900">
	<div class="start" id="eventopen">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_head1.jpg" alt="�ٹ������� SNS�� Ÿ��!" /></p>
		<div class="snsView">
			<p class="twFollow"><a href="http://www.twitter.com/your10x10" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_follow.png" alt="�ȷο�" /></a></p>
			<p class="faLike">
				<iframe src="//www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2Fyour10x10&amp;send=false&amp;layout=button_count&amp;width=100&amp;show_faces=false&amp;font&amp;colorscheme=light&amp;action=like&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:100px; height:21px;" allowTransparency="true"></iframe>
			</p>
			<p class="evtBtn"><a href="javascript:eventGo();"><img src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_btn1.png" alt="�̺�Ʈ �����ϱ�"/></a></p>
		</div>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_btm1.jpg" alt="�ٹ����� ���� ���̽����� ���� �Ǿ��ּž� �̺�Ʈ ������ �����մϴ�. :)" /></p>
	</div>
	<div class="evtCmt" id="cmtopen" style="display:none;">
		<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="iCTot" value="">
		<input type="hidden" name="mode" value="add">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_head2.jpg" alt="�ٹ������� SNS�� Ÿ��!" /></p>
		<div class="giftSelect">
			<ul>
				<li>
					<p><label for="gift1"><img src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_gift1.png" alt="��Ʈ����Ŀ �ѷ�" /></label></p>
					<p><input type="radio" id="gift1" name="spoint" value="1"/></p>
				</li>
				<li>
					<p><label for="gift2"><img src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_gift2.png" alt="����Ʈ�� ���̽�" /></label></p>
					<p><input type="radio" id="gift2" name="spoint" value="2"/></p>
				</li>
				<li>
					<p><label for="gift3"><img src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_gift3.png" alt="���̸�����ũ �̾���" /></label></p>
					<p><input type="radio" id="gift3" name="spoint" value="3"/></p>
				</li>
			</ul>
			<div class="cmtInput">
				<p class="ftLt"><textarea style="width:98%; height:89px;" name="txtcomm" maxlength="100" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onblur="jsChkUnblur()" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');return Limit(this);" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%>  value="�ٹ����� SNS���� �ٶ�� ��, ������ �޽����� �����ּ���!" autocomplete="off">�ٹ����� SNS���� �ٶ�� ��, ������ �޽����� �����ּ���!</textarea></p>
				<p class="ftRt"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_btn2.jpg" alt="�̺�Ʈ �����ϱ�" width="127" height="101"/></p>
			</div>
			<p class="snsBtn">
				<a href="http://www.twitter.com/your10x10" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_twitter.png" alt="twitter" /></a>
				<a href="http://www.facebook.com/your10x10" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_facebook.png" alt="Facebook" /></a>
			</p>
		</div>
		</form>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2013/42900/42900_btm2.jpg" alt="1���� ID�� �ߺ������ �����ϳ�, 1���� ��÷ ��ȸ�� �־����ϴ�." /></p>
	</div>
	<div id="commentarea">
		<iframe id="evt_cmt" src="/event/lib/iframe_comment.asp?eventid=<%=eCode%>" width="100%" height="100" class="autoheight"  frameborder="0" scrolling="no"></iframe>
	</div>
</div>
<script type="text/javascript" src="/lib/js/jquery.iframe-auto-height.js"></script>
</body>
</html>