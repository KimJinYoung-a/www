/*
	## 숫자 스피너 출력 플러그인
	## 2012.03.29; 허진원 생성
	-----------------------------
	* 사용법
		<input type="text" id="num" />
		<script type="text/javascript">
		$("#num").numSpinner({min:1,max:10,step:1,value:1});
		</script>
	* 변수
		- min : 입력 최소값
		- max : 입력 최대값
		- step : 증감 단위
		- value : 기본값
*/
(function($) {
	$.fn.numSpinner = function(opts) {
		return this.each(function() {
			// 변수할당
			var defaults = {min:1, max:10, step:1, value:0};
			var options = $.extend({}, defaults, opts);
			if(options.value<options.min) options.value=options.min;
			if(options.value>options.max) options.value=options.max;

			//지정된 폼 치환
			var p = $(this).parent()
			p.empty();
			var sItem = '<div class="spinner">';
				sItem += '<input type="text" name="' + this.id + '" maxlength="4" pattern="[0-9]*" value="' + options.value + '" />';
				sItem += '	<div class="buttons">';
				sItem += '		<div class="up"></div>';
				sItem += '		<div class="down"></div>';
				sItem += '	</div><span class="lPad05">ea</span>';
				sItem += '</div>';
			p.html(sItem);
			$.btnClick(p,options);
		});
	};

	//업/다운클릭 이벤트
	$.btnClick = function(fp,opt) {
		$(fp).find('.spinner .buttons .up').each(function() {
			$(this).css('cursor', 'pointer');
			var fno = $(this).parent().parent().find("input");
			fno.OnlyNumeric(opt);
			$(this).click(function() {
				if(fno.val()=="") fno.val(opt.min-opt.step);
				if(fno.val()<opt.max) fno.val(parseInt(fno.val())+opt.step);
				if(fno.val()>opt.max) fno.val(opt.max);
			});
		});

		$(fp).find('.spinner .buttons .down').each(function() {
			$(this).css('cursor', 'pointer');
			var fno = $(this).parent().parent().find("input");
			fno.OnlyNumeric(opt);
			$(this).click(function() {
				if(fno.val()=="") fno.val(opt.min);
				if(fno.val()>opt.min) fno.val(parseInt(fno.val())-opt.step);
				if(fno.val()<opt.min) fno.val(opt.min);
			});
		});
	};

	//숫자만 가능하게(점, 콤마 불가)
	$.fn.OnlyNumeric = function(opt) {
		this.css("ime-mode", "disabled");
		var az = "abcdefghijklmnopqrstuvwxyz";
		az += az.toUpperCase();
		var p = $.extend({ nchars: az }, p); 
		p = $.extend({ ichars: "!@#$%^&*()+=[]\\\';,/{}|\":<>?~`.-_ ", nchars: "", allow: "" }, p);
		return this.each( function() {
		
			s = p.allow.split('');
			for ( i=0;i<s.length;i++) if (p.ichars.indexOf(s[i]) != -1) s[i] = "\\" + s[i];
			p.allow = s.join('|');
			var reg = new RegExp(p.allow,'gi');
			var ch = p.ichars + p.nchars;
			ch = ch.replace(reg,'');

			// 공백/최소/대값 확인
			$(this).keyup( function (e) {
				if($(this).val()=="") $(this).val(opt.min);
				if($(this).val()<opt.min) $(this).val(opt.min);
				if($(this).val()>opt.max) $(this).val(opt.max);
			});
		
			$(this).keypress( function (e) {
				if (!e.charCode) k = String.fromCharCode(e.which);
				else k = String.fromCharCode(e.charCode);
				if (ch.indexOf(k) != -1) e.preventDefault();
				if (e.ctrlKey&&k=='v') e.preventDefault();
			});

			$(this).bind('contextmenu',function () {return false});
		});
	};

})(jQuery);
