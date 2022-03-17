/**
 * 생산관리에 관한 스크립트
 * 2021.11.17
 */
function Product(){
	let frm = document.frm_product;
	let url = "index.jsp?sub=./product/";
	
	
	if(frm.btnFind != null){
		frm.btnFind.onclick = function(){
			var code = frm.code.value;
			var partsWin = window.open('./product/parts_Info.jsp?code='+code, 
																 'partsWin', 'width=430, height=400, left=500, top=160');
		}
	}
	
	if(frm.btnInsert !=null){
		frm.btnInsert.onclick = function(){
			url += "insert.jsp";
			frm.action = url;
			frm.submit();
		}
	}
	if(frm.btnList !=null){
		frm.btnList.onclick = function(){
			url += "list.jsp";
			frm.action = url;
			frm.submit();
		}
	}
	if(frm.btnSave !=null){
		frm.btnSave.onclick = function(){
			url += "insert_result.jsp";
			frm.action = url;
			frm.submit();
			}
	}
	if(frm.btnSearch !=null){
		frm.btnSearch.onclick = function(){
			frm.nowPage.value = '1';
			url +="list.jsp";
			frm.action = url;
			frm.submit();
			}
	}
	if(frm.btnModify != null){
		frm.btnModify.onclick = function(){
			url += "modify.jsp";
			frm.action = url;
			frm.submit();		
		}
	}
	if(frm.btnDelete != null){
		frm.btnDelete.onclick = function(){
			let yn = confirm("정말 삭제하시겠습니까?");
			if(yn==false) return;
			
			url += "delete_result.jsp";
			frm.action = url;
			frm.submit();		
		}
	}
	if(frm.btnUpdate != null){
		frm.btnUpdate.onclick = function(){
			url += "modify_result.jsp";
			frm.action = url;
			frm.submit();
		}
	}
	
}
Product.view = function(serial){
	let frm = document.frm_product;
	let url = "index.jsp?sub=./product/";
	url += "view.jsp";
	frm.serial.value = serial;
	frm.action = url;
	frm.submit();
}

Product.page = function(nowPage){
	let frm = document.frm_product;
	let url = "index.jsp?sub=./product/";
	url += "list.jsp";
	frm.nowPage.value = nowPage;
	frm.action = url;
	frm.submit();
}

function Parts(){
	let frmParts = document.frm_parts;
	if(frmParts.btnFindParts != null){
		frmParts.btnFindParts.onclick = function(){
			frmParts.action='parts_Info.jsp';
			frmParts.submit();
		}
	}
	
	if(frmParts.parts){
		frmParts.parts.ondblclick = function(){
			let p = frmParts.parts.selectedIndex;
			let v = frmParts.parts[p].text;
			console.log(v);
			let array = v.split(/\[|\]/);
			console.log(array[0]);
			console.log(array[1]);
			console.log(array[2]);
			window.opener.frm_product.code.value = array[0].trim();
			window.opener.frm_product.codeName.value = array[1].trim();
			window.opener.frm_product.price.value = array[2].trim();
			self.close();
		}
	}
}
