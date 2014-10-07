	//javascript去空格函数 
	function LTrim(str){ //去掉字符串 的头空格
		var i;
		for(i=0;i<str.length; i++) {
			if(str.charAt(i)!=" ") break;
		}
		str = str.substring(i,str.length);
		return str;
	}
	function RTrim(str){
		var i;
		for(i=str.length-1;i>=0;i--){
			if(str.charAt(i)!=" "&&str.charAt(i)!=" ") break;
		}
		str = str.substring(0,i+1);
		return str;
	}
	function Trim(str){
	
		return LTrim(RTrim(str));
	
	}
	//判断是否为空 进行提示
	function check() {
	//alert("asdf");
		if(Trim(document.form2.title.value) == "") {
			alert("请输入标题!");
			return false;
		}
		if(Trim(document.form2.author.value) == "") {
			alert("请输入作者名!");
			return false;
		}
		if(Trim(document.form2.ti.value) == "") {
			alert("请输入内容!");
			return false;
		}
		return true;
	}
