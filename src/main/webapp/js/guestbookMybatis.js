/**
 * 방명록
 * 작성자 : 2021.12.06(psh)
 */
function guestbook(){
	//화살표함수 표현식,람다식(자바)
	let frm = document.frm_guestbook;
	let btnlist = document.getElementById('btnlist');
	let btnModifyCancel = document.getElementById('btnModifyCancel');
	let btnModify = document.getElementById("btnModify");
	let btnDelete = document.getElementById("btnDelete");
	let btnDeleteCancel = document.getElementById("btnDeleteCancel");
	
	if(btnModify != null){
		btnModify.onclick = function(){
			frm_modify.action = "index.jsp?sub=./guestbookMybatis/modify_result.jsp";
			frm_modify.submit();
		}
	}
	
	if(btnModifyCancel != null){
		btnModifyCancel.onclick = function(){
			var frm = document.getElementById("modify_box");
			frm.style.display='none';
		}
	}
	if(frm != null){
		frm.onsubmit = function(){
			if(frm.doc.value==''){
				alert('내용을 입력하세요...');
				return false;
			}
		}
	}
	if(btnlist != null){
		btnlist.onclick = function(){
			location.href = 'index.jsp?sub=./guestbookMybatis/list.jsp';
		}
	}
	if(frm.btnInsert){
		frm.btnInsert.onclick = function(){
			frm.action = 'index.jsp?sub=./guestbookMybatis/register.jsp';
			frm.submit();
		}
	}	
	
}
function modifyFunc(doc,num){
	var frm = document.getElementById("modify_box");
	frm.style.display='block';
	frm_modify.doc.value = doc;
	frm_modify.num.value = num;
		
}
function deleteFunc(num){
	//var frm = document.getElementById("delete_box");
	//frm.style.display='block';
	
}

function delChoice(){
	var checkbox = document.getElementsByName("del");
	var delValue = "";
	var url = "";
	
	for(var v of checkbox){
		if(v.checked == true){
			delValue += v.value +",";
		}
	}
	delValue = delValue.substr(0, delValue.length-1);
	
	url = "index.jsp?sub=./guestbookMybatis/delete_result.jsp&delValue=" + delValue;
	location.href=url;
	
}

guestbook.page = function(nowPage){
	let frm = document.frm_guestbook;
	let url = 'index.jsp?sub=./guestbookMybatis/';
	url += 'list.jsp';
	frm.nowPage.value = nowPage;
	frm.action = url;
	frm.submit();
}

