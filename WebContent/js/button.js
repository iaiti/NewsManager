var i = 1;
function check_file(){
	var strFileName=form1.FileName.value;
	if (strFileName==null||strFileName==""){
   		alert("请选择要上传的文件");
    	return false;
   		var s = "file"+i;
   		var str=form1.s.value;
   	if(str!=null||str!=""){
   		return true;
   }
}
	return true;
}

// javascript 动态添加 input type="file"
	
function addFile(dvID, inputNamePrefix){
		var dv = document.getElementById(dvID);
		var file = document.createElement("input");
		file.type = "file";
		file.id = file.name = inputNamePrefix + i;
		dv.appendChild(file);
		var btn = document.createElement("input");
		btn.type = "button";
		btn.id = btn.name = "btn" + i;
		btn.value = "删除" ;
	
		btn.onclick = function() {
			var b = document.getElementById(btn.id);
			dv.removeChild(b.nextSibling); //remove <BR>
			dv.removeChild(b.previousSibling); //file
			dv.removeChild(b); //btn
		}
	
		dv.appendChild(btn);
	
		dv.appendChild(document.createElement("BR"));
	
		i++;
}

