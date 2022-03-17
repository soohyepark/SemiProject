/**
 * 게시판 스크립트
 * 2021-12-09(psh)
 */
function brd(){};
brd.view = function(serial){
	$frm = $('#frm_search')[0];
	$frm.serial.value = serial;
	$frm.action = 'board.brd?job=view';
	$frm.submit();
}
brd.page = function(nowPage){
	$frm = $('#frm_search')[0];
	$frm.nowPage.value = nowPage;
	$frm.action = 'board.brd?job=list';
	$frm.submit();
}
/*코드 정리후 설정
brd.submit = function(formId, url){
	$frm = $(formId)[0];
	$frm.action = "board.brd?job="+url;
	$frm.submit();
}
*/

$(function(){
	
	$('#btnSearch').click(function(){
		$frm = $('#frm_search')[0];
		$frm.action = "board.brd?job=list";
		$frm.nowPage.value = 1;
		$frm.submit();
	});
	
	$('#btnInsert').click(function(){
		$frm = $('#frm_search')[0];
		$frm.action = "board.brd?job=insert";
		$frm.submit();
	});
	
	$('#btnSave').click(function(){
		/*
		$frm = $('#frm_board')[0];
		$frm.action = "board.brd?job=insertSave"; 
		$frm.submit();//submit하면 form이 갱신된다. 
		*/
		
		$param = $('#frm_board').serialize();
		$.post('board.brd?job=insertSave', $param, function(flag){
			var $fd = $('#frm_upload')[0];
			$fd.enctype = "multipart/form-data";
			$fd.action = "board.boardUp?job=i"; //i=insert,m=modify,r=repl
			$fd.submit();
		})
		
	});
	
	$('#btnList').click(function(){
		$frm = $('#frm_board')[0];
		$frm.action = "board.brd?job=list";
		$frm.submit();
	});
	
	$('#btnModify').click(function(){
		$frm = $('#frm_board')[0];
		$frm.action = "board.brd?job=modify";
		$frm.submit();
	});
	
	$('#btnModifySave').click(function(){
		$param = $('#frm_board').serialize();
		$.post('board.brd?job=modifySave',$param,function(){
			$frm = $('#frm_upload')[0];
			$frm.enctype = 'multipart/form-data';
			$frm.action = 'board.boardUp?job=m';
			$frm.submit();
		})
		
		//$frm.action = "board.brd?job=modifySave";
		//$frm.submit();
	});
	
	$('#btnDelete').click(function(){
		$frm = $('#frm_board')[0];
		$ic = $('#id_check')[0];
		$ic.style.display="block";
		
		/*
		var pwd = prompt("암호를 입력해주세요.");
		if(pwd != ""){
			$frm = $('#frm_board')[0];
			$frm.pwd.value = pwd;
			$frm.action = "board.brd?job=delete";
			$frm.submit();
		}
		*/
	});
	
	$('#btnDelRun').click(function(){
		$frm = $('#frm_board')[0];
		$ic = $('#id_check')[0];
		$frm.pwd.value = frm_pwd.inputPwd.value;
		$ic.style.display="none";
		
		if(frm_pwd.inputPwd.value.trim() != ''){
			$frm.action = "board.brd?job=delete";
			$frm.submit();
		}
	});
	$('#btnCancel').click(function(){
		$frm = $('#frm_board')[0];
		$ic = $('#id_check')[0];
		$ic.style.display="none";
	});
	
	
	$('#btnRepl').click(function(){
		$frm = $('#frm_board')[0];
		$frm.action = "board.brd?job=repl";
		$frm.submit();
	});
	$('#btnReplSave').click(function(){
		$param = $('#frm_board').serialize();
		$.post('board.brd?job=replSave', $param, function(flag){
			var $fd = $('#frm_upload')[0];
			$fd.enctype = "multipart/form-data";
			$fd.action = "board.boardUp?job=r"; //i=insert,m=modify,r=repl
			$fd.submit();
		})
	});
});

//summernote

var loadInterval = []; //이미지가 서버에 upload 되었는지 체크하는 기능
function summer(){
	var fonts = [
		"맑은 고딕","고딕","돋음","바탕","바탕체","굴림","굴림체","궁서체"
	]
	fonts.sort();
	
	$('#summernote').summernote({
		height : 200,
		fontNames : fonts,
		callbacks : {//이벤트가 발생하면 실행
			onImageUpload : function(files){
				loadInterval.length = files.length;
				$('#frm_board').addClass('spinner');
				for(var i=files.length-1 ; i>=0 ; i--){
					sendFile(i, files[i]);
				}
			},
			onMediaDelete : function(target){
				var file = decodeURI(target[0].src); //파일명이 한글일때 깨져서 들어가서 decode추가함
				$.ajax({
					data : {target : file},
					type : 'POST',
					url : 'delete.summerUp?flag=delete',
					cache : false,
					success : function(msg){}
				})
			}
		}
	});
}
function sendFile(intervalPos, file){
	var form_data = new FormData(); //form tag 생성
	form_data.append('file',file);
	$.ajax({
		data : form_data,
		type : 'POST',
		url : 'upload.summerUp',
		enctype : 'multipart/form-data',
		cache : false,
		contentType : false, //false로 해야 문자열이 아닌 data를 binary형태로 전송한다.
		processData : false,
		success : function(img){
			loadInterval[intervalPos] = setInterval(function(){
				var target = new Image(); //업로드가 될 이미지
				target.onload = function(){ //이미지가 모두 서버에 저장된 상태
					clearInterval(loadInterval[intervalPos]);
					$('#summernote').summernote('editor.insertImage',img);
					$('#frm_board').removeClass('spinner');
				}
				target.src = img;
			}, 1500);
		}
	})
}

//loadCheck.bind(null,intervalPos,img)
/*
function loadCheck(pos,img){
	var target = new Image(); //업로드가 될 이미지
	target.onload = function(){ //이미지가 모두 서버에 저장된 상태
		clearInterval(loadInterval[pos]);
		$('#summernote').summernote('editor.insertImage',img);
		$('#frm_board').removeClass('spinner');
	}
	target.src = img;
}
*/