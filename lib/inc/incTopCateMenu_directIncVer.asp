			<script>
			$(function() {
				//GNB Control
				$('.gnbV15 li').mouseover(function() {
					$('.gnbV15 li').removeClass('on');
					$(this).addClass('on');
					$('.gnbSubWrapV15').show().unbind('mouseover').unbind('mouseleave')
						.mouseover(function() {$(this).show();})
						.mouseleave(function() {$(this).hide();});
					$('.gnbSubV15').hide();
					var subGnbId = $(this).attr('name');
					
					//추가
					if (eval("vCtHtml"+subGnbId.substring(3,6))!=""){
					   $(".gnbSubWrapV15").append(eval("vCtHtml"+subGnbId.substring(3,6)));
					   eval("vCtHtml"+subGnbId.substring(3,6)+"=''");
					}
					
					$("div[class|='gnbSubV15'][id|='"+ subGnbId +"']").show().unbind('mouseover').unbind('mouseleave')
						.mouseover(function() {
							$(this).show();
							$('.gnbV15 li[name="'+subGnbId+'"]').addClass('on');
						})
						.mouseleave(function() {
							$(this).hide();
							$('.gnbV15 li').removeClass('on');
						});
				});
			
				$('.gnbV15 li').mouseleave(function() {
					$(this).removeClass('on');
					$('.gnbSubWrapV15').hide();
				});
			
				$('.deptUnitTopV15 li').mouseover(function() {
					$(this).addClass('current');
					if ($(this).children('.subGroupWrapV15').length > 0){
						$(this).children('.subGroupWrapV15').show();
						$('.gnbBnrV15').children('span').show();
					} else {
						$(this).children('.subGroupWrapV15').hide();
						$('.gnbBnrV15').children('span').hide();
					}
				});
				
				$('.deptUnitTopV15 li').mouseleave(function() {
					$(this).removeClass('current');
					$(this).children('.subGroupWrapV15').hide();
					$('.gnbBnrV15').children('span').hide();
				});
			});
			</script>

			<div class="gnbV15">
				<ul>
					<li name="gnb101" onClick="top.location.href='/shopping/category_list.asp?disp=101';"><p>디자인문구</p></li>
					<li name="gnb102" onClick="top.location.href='/shopping/category_list.asp?disp=102';"><p>디지털/핸드폰</p></li>
					<li name="gnb103" onClick="top.location.href='/shopping/category_list.asp?disp=103';"><p>캠핑/트래블</p></li>
					<li name="gnb104" onClick="top.location.href='/shopping/category_list.asp?disp=104';"><p>토이</p></li>
					<li name="gnb121" onClick="top.location.href='/shopping/category_list.asp?disp=121';"><p>가구/조명</p></li>
					<li name="gnb122" onClick="top.location.href='/shopping/category_list.asp?disp=122';"><p>데코/플라워</p></li>
					<li name="gnb120" onClick="top.location.href='/shopping/category_list.asp?disp=120';"><p>패브릭/수납</p></li>
					<li name="gnb112" onClick="top.location.href='/shopping/category_list.asp?disp=112';"><p>키친</p></li>
					<li name="gnb119" onClick="top.location.href='/shopping/category_list.asp?disp=119';"><p>푸드</p></li>
					<li name="gnb117" onClick="top.location.href='/shopping/category_list.asp?disp=117';"><p>패션의류</p></li>
					<li name="gnb116" onClick="top.location.href='/shopping/category_list.asp?disp=116';"><p>가방/슈즈/주얼리</p></li>
					<li name="gnb118" onClick="top.location.href='/shopping/category_list.asp?disp=118';"><p>뷰티</p></li>
					<li name="gnb115" onClick="top.location.href='/shopping/category_list.asp?disp=115';"><p>베이비/키즈</p></li>
					<li name="gnb110" onClick="top.location.href='/shopping/category_list.asp?disp=110';"><p>Cat&amp;Dog</p></li>
				</ul>
				<div class="gnbSubWrapV15">
				<script type="text/javascript" src="/chtml/dispcate/html/cate_menu_all_T.js?v=1.0"></script>

<% if (FALSE) then %>
<%
On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new101.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=101';""><strong>디자인문구</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new102.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=102';""><strong>디지털/핸드폰</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new103.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=103';""><strong>캠핑/트래블</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new104.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=104';""><strong>토이</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new121.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=121';""><strong>가구/조명</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new122.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=122';""><strong>데코/플라워</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new120.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=120';""><strong>패브릭/수납</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new112.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=112';""><strong>키친</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new119.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=119';""><strong>푸드</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new117.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=117';""><strong>패션의류</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new116.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=116';""><strong>가방/슈즈/주얼리</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new118.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=118';""><strong>뷰티</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new115.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=115';""><strong>베이비/키즈</strong></p></li>" END IF
On Error Goto 0

On Error Resume Next
server.Execute "/chtml/dispcate/html/cate_menu_new110.html"
If (ERR) Then Response.Write "<li><p onClick=""top.location.href='/shopping/category_list.asp?disp=110';""><strong>Cat &amp; Dog</strong></p></li>" END IF
On Error Goto 0
%>
<% end if %>
				</div>
			</div>