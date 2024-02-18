function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

//영문, 숫자 혼합 여부 체크 
function fnChkEngNum(value) {
var idcount=0;
		var ls_one_char;
		for (i=0;i<value.length;i++){
			ls_one_char = value.charAt(i);

			if(ls_one_char.search(/[0-9|a-z|A-Z]/) == -1) {
				idcount++;
			}
		}
					  
		if(idcount!=0) {
			return false;
		}
		
	return true;
}

//숫자 체크 
function fnChkNumber(value) {
	var temp = new String(value)
		
	if(temp.search(/\D/) != -1) {
		return false;
	}
		return true;	
}

//Shopinfo : map 팝업
function jsPopmap(sURL){
	var popWin;
	popWin = window.open(sURL,'popW','width=800,height=550,scrollbars=no,resizable=no');
	popWin.focus();
}

