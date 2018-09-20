var koMenu={
			1:'영상게시판'
		   ,2:'더빙게시판'
		   ,3:'자막게시판'
		   ,4:'마이페이지'
		   ,5:'환영합니다.'
		   ,6:'회원정보수정'
		   ,7:'성별'
		   ,8:'생일'
		   ,9:'탈퇴하시겠습니까?'
		   ,10:'회원탈퇴 후 한달 이내에 계정을 복구할 수 있습니다.'
		   ,11:'기간 이후에는 회원정보가 영구 삭제됩니다.'
		   ,12:'회원정보관리'
		   ,13:'회원정보수정'
		   ,14:'회원탈퇴'
		   ,15:'인증메일을 다시 보내시겠습니까?'
		   ,16:'계정을 복구하시겠습니까?'
	}
	
	var jpMenu={
			1:'映像掲示板'
		   ,2:'吹き替え掲示板'
		   ,3:'字幕掲示板'
		   ,4:'マイページ'
		   ,5:'歓迎します。'
		   ,6:'会員情報修正'
		   ,7:'性別'
		   ,8:'生年月日'
		   ,9:'本当に脱退しますか。'
		   ,10:'会員脱退後、一ヶ月以内にアカウントを復元することができます。'
		   ,11:'一定期間後、会員情報が永久に削除されます。'
		   ,12:'会員情報管理'
		   ,13:'会員情報修正'
		   ,14:'会員脱退'
		   ,15:'認証メールを送りますか。'
		   ,16:'アカウントを復旧しますか。'
	}
	
	function languageChange(lang){
		if(lang=='kor'){
			sessionStorage.setItem("lngType", 'kor');
			languageChange_Page(lang);
			$('#usernick').attr('placeholder','변경 닉네임 입력');
			$('#currpwd').attr('placeholder','현재 비밀번호 입력');
			$('#newpwd').attr('placeholder','새 비밀번호 입력');
			$('#checkpwd').attr('placeholder','새 비밀번호 확인');
			$('#btnUpdate').attr('value','수정');
			$('#btnCancel').attr('value','취소');
			$('#recoveryEmail').attr('placeholder','이메일 주소를 입력하세요.');
			$('#Ecertification').attr('value','이메일 인증');
			$('[data-langNum]').each(function() {
			    var $this = $(this); 
			    $this.html(koMenu[$this.data('langnum')]); 
			});
		}else{
			sessionStorage.setItem("lngType", 'jp');
			languageChange_Page(lang);
			$('#usernick').attr('placeholder','変更するニックネーム入力');
	        $('#currpwd').attr('placeholder','現在のパスワード入力');
	        $('#newpwd').attr('placeholder','新しいパスワード入力');
	        $('#checkpwd').attr('placeholder','新しいパスワード確認');
			$('#btnUpdate').attr('value','修整');
			$('#btnCancel').attr('value','キャンセル');
			$('#recoveryEmail').attr('placeholder','メールアドレスを入力してください。');
			$('#Ecertification').attr('value','メール認証');	
			$('[data-langNum]').each(function() {
			    var $this = $(this); 
			    $this.html(jpMenu[$this.data('langnum')]); 
			});
		}
	}
	
	function SetLanguage(){
		var lngType = sessionStorage.getItem("lngType");
		if(lngType==null){
			 languageChange('kor');
		}
		else if(lngType=='jp'){
			 languageChange(lngType);
		}else if(lngType=='kor'){
			languageChange(lngType);
		}
	}