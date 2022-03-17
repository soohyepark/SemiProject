/**
 * 회원관리에서 사용하는 자바 스크립트
 * 2021.12.08-->4군데 바꿈 
 */
function member(){
	let url = 'index.jsp?sub=./memberMybatis/';
	let frm = document.frm_member;
	let photo = document.getElementById("photo");
	let btnPrev = document.getElementById("btnPrev");
	let btnNext = document.getElementById("btnNext");
	let btnPwd = document.getElementById("btnPwd");
	let btnCancel = document.getElementById("btnCancel");
	let btnDelRun = document.getElementById("btnDelRun");
	let ic = document.getElementById("id_check");
	//let pc = document.getElementById("pwd_check");
	
	if(btnPwd){
		btnPwd.onclick=function(){
			frm.pwd.value=frm_pwd.inputPwd.value;
			ic.style.display="none";
			
			if(frm_pwd.inputPwd.value.trim() != ''){
				frm.enctype='multipart/form-data';
				frm.action = 'upload.upm?flag=m';//modify에서 호출됨
				frm.submit();
			}
		}
	}
	if(btnCancel){
		btnCancel.onclick=function(){
			ic.style.display="none";
		}
	}
	if(frm.btnUpdate){
		frm.btnUpdate.onclick = function(){
			//required의 input type은 submit이어야 함
			frm.btnUpdate.type='submit';
			//암호입력받는창 띄움
			if(frm.irum.value!="" && frm.phone.value!="" && frm.address2.value!=""){
				frm.btnUpdate.type='button';
				ic.style.display='block';
			}
		}
	}
	
	if(frm.btnIdCheck){ //아이디 중복체크
		frm.btnIdCheck.onclick = function(){
			window.open('./memberMybatis/id_check.jsp','','width=400,height=180');
		}
	}
	/*
	if(frm.pwd&&frm.pwd2){
		frm.pwd2.onchange = function(){
			if(frm.pwd.value==frm.pwd2.value){
				pc.innerHTML = "암호일치";
				pc.style.color = "#00f";
			}else{
				pc.innerHTML = "암호불일치";
				pc.style.color = "#f00";
			}
		}
	}
	*/
	
	if(frm.btnZip){ //우편번호 검색
		frm.btnZip.onclick = function(){ //onclick : click이라고 하는 이벤트가 실행됐을때
			new daum.Postcode({ //맵구조 key : value
				oncomplete : function(data){
					frm.zip.value=data.zonecode;
					frm.address.value=data.address;
				}
			}).open();
		}
	}
	
	
	if(frm.btnSave){ //저장
		frm.btnSave.onclick = function(){
			//아이디 입력 체크
			if(frm.pwd.value!=frm.pwd2.value){
				alert("암호를 확인하세요.");
				frm.pwd.focus();
				return;
			}
			//readonly항목은 required가 적용이 안되기 때문에 따로 처리
			if(frm.mid.value == ''){
				alert('아이디 중복체크를 먼저해주세요');
				return;
			}
			if(frm.zip.value == ''){
				alert('우편번호 검색을 먼저해주세요');
				return;
			}
			
			frm.enctype='multipart/form-data';
			frm.action = 'upload.upm?flag=i';
			//required의 input type은 submit이어야 함
			frm.btnSave.type='submit';
			frm.btnSave.click();
		}
	}
	if(frm.btnList){ //목록
		frm.btnList.onclick = function(){
			frm.action = url + 'list.jsp';
			frm.submit();
		}
	}
	if(frm.btnModify){ //수정
		frm.btnModify.onclick = function(){
			frm.action = url + 'modify.jsp';
			frm.submit();
		}
	}
	
	
	if(frm.btnDelete){ //삭제
		frm.btnDelete.onclick = function(){
			ic.style.display='block';
		}
	}
	if(btnDelRun){
		btnDelRun.onclick=function(){
			frm.pwd.value=frm_pwd.inputPwd.value;
			ic.style.display="none";
			
			if(frm_pwd.inputPwd.value.trim() != ''){
				frm.action = url + 'delete_result.jsp';
				frm.submit();
			}
		}
	}
	
	//조회
	if(frm.btnInsert){ //입력
		frm.btnInsert.onclick = function(){
			frm.action = url + 'insert.jsp';
			frm.submit();
		}
	}
	if(frm.btnFind){ //검색
		frm.btnFind.onclick = function(){
			frm.action = url + 'list.jsp';
			frm.nowPage.value = 1;
			frm.submit();
		}
	}
	if(btnPrev){
		btnPrev.onclick = function(nowPage){
			frm.action = url + 'list.jsp';
			frm.nowPage.value = nowPage;
			frm.submit();
		}
	}
	if(btnNext){
		btnNext.onclick = function(nowPage){
			frm.action = url + 'list.jsp';
			frm.nowPage.value = nowPage;
			frm.submit();
		}
	}
	
	if(photo){
		photo.onclick = function(){
			frm.btnPhoto.click(); //클릭해라
		}
	}
	if(frm.btnPhoto){
		frm.btnPhoto.onchange = function(ev){
			let file = ev.srcElement; //이벤트가 발생한 태그
			let url = file.files[0];
				
			let reader = new FileReader();
			reader.readAsDataURL(url);
					
			reader.onload = function(ev2){
				let img = new Image();
				img.src = ev2.target.result;
				photo.src = img.src;
			}
		}
	}

	
}

member.view = function(mid){
	let frm = document.frm_member;
	let url = 'index.jsp?sub=./memberMybatis/';
	frm.action = url + 'view.jsp';
	frm.mid.value = mid;
	frm.submit();
}

member.move = function(nowPage){
	let frm = document.frm_member;
	let url = 'index.jsp?sub=./memberMybatis/';
	frm.action = url + 'list.jsp';
	frm.nowPage.value = nowPage;
	frm.submit();
}
