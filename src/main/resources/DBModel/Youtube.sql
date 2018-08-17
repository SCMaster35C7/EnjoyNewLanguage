DROP TABLE DubbingReply;		-- 자막요청 게시판 댓글 테이블
DROP TABLE Dubbing;					-- 더빙 게시판 테이블
DROP TABLE InvestigationReply;		-- 자막요청 게시판 댓글 테이블
DROP TABLE InvestigationSubtitle;	-- 요청자막 제공 테이블
DROP TABLE Investigation;			-- 자막요청 게시판 테이블
DROP TABLE WishList;				-- 찜한목록 테이블
DROP TABLE UserStudy;				-- 사용자학습 테이블
DROP TABLE WrongAnswer;				-- 사용자오답 테이블
DROP TABLE EducationVideo;			-- 교육자료 테이블
DROP TABLE Member;					-- 사용자정보 테이블

DROP SEQUENCE DUBBING_REPLY_SEQ;			-- 더빙게시판 댓글 시퀀스
DROP SEQUENCE DUBBING_SEQ;					-- 더빙게시판 시퀀스
DROP SEQUENCE INVESTIGATION_REPLY_SEQ;		-- 자막검증게시판 댓글 시퀀스
DROP SEQUENCE INVESTIGATION_SUBTITLE_SEQ;	-- 요청자막 제공 시퀀스 
DROP SEQUENCE INVESTIGATION_SEQ;			-- 자막요청 시퀀스
DROP SEQUENCE WISH_LIST_SEQ;				-- 찜한목록 시퀀스	
DROP SEQUENCE USER_STUDY_SEQ;				-- 사용자학습용 시퀀스
DROP SEQUENCE WRONG_ANSWER_SEQ;				-- 사용자오답용 시퀀스
DROP SEQUENCE EDUCATION_VIDEO_SEQ;			-- 교육자료용 시퀀스


-- 1. 사용자 정보 테이블
CREATE TABLE Member (
	userid	 		VARCHAR2(50) 	CONSTRAINT user_userid_pk 		PRIMARY KEY,	-- 아이디
	username		VARCHAR2(100) 	CONSTRAINT user_username_nn		NOT NULL,		-- 이름
	userpwd			VARCHAR2(100) 	CONSTRAINT user_userpwd_nn		NOT NULL,		-- 비밀번호
	phone			VARCHAR2(20)	CONSTRAINT user_userphone_nn 	NOT NULL,		-- 전화번호
	gender 			CHAR(1)			CONSTRAINT user_gender_nn		NOT NULL,		-- 성별
	birth			DATE			CONSTRAINT user_birth_nn		NOT NULL,		-- 생일
	joinDate		DATE			DEFAULT SYSDATE,								-- 가입일
	lastAccess		DATE			DEFAULT SYSDATE,								-- 최종접속일
	point			NUMBER			DEFAULT 0,										-- 포인트
	warningCount	NUMBER			DEFAULT 0,										-- 경고수
	admin			NUMBER			DEFAULT 1										-- 관리자 유무 (0-관리자, 1-사용자)
);

-- 2. 교육 자료 테이블(교육용 게시판용)
CREATE TABLE EducationVideo(
	videoNum			NUMBER 			CONSTRAINT educationvideo_videoNum_pk	PRIMARY KEY,	-- 교육용 비디오번호
	url					VARCHAR2(1000)	CONSTRAINT educationvideo_url_nn		NOT NULL,		-- 교육영상 URL
	subtitle			VARCHAR2(1000) 	CONSTRAINT educationvideo_subtitle_nn	NOT NULL,		-- 자막
	regDate				DATE			DEFAULT SYSDATE,										-- 등록일
	hitCount			NUMBER			DEFAULT 0,												-- 조회수
	recommendation		NUMBER			DEFAULT 0,												-- 추천수
	decommendation		NUMBER			DEFAULT 0,												-- 비추천수
	CONSTRAINT EducationVideo UNIQUE(url)
);

CREATE SEQUENCE EDUCATION_VIDEO_SEQ;

-- 3. 사용자 오답 테이블
CREATE TABLE WrongAnswer(
	answernum		NUMBER			CONSTRAINT wronganswer_answernum_pk			PRIMARY KEY,	-- 오답번호
	userid			VARCHAR2(50),																-- 아이디
	startTime		VARCHAR2(10)	CONSTRAINT wronganswer_startTime_nn			NOT NULL,		-- 영상 시작시간
	endTime			VARCHAR2(10)	CONSTRAINT wronganswer_endTime_nn			NOT NULL,		-- 영상 끝시간
	wrongAnswer		VARCHAR2(1000) 	CONSTRAINT wronganswer_wrongSentence_nn 	NOT NULL,		-- 오답 문장
	correctAnswer	VARCHAR2(1000) 	CONSTRAINT wronganswer_correctAnswer_nn 	NOT NULL,		-- 올바른 문장
	url				VARCHAR2(1000),																-- 영상URL
	regDate			DATE		DEFAULT SYSDATE,												-- 등록일
	classification	NUMBER			CONSTRAINT wronganswer_classification_nn	NOT NULL,		-- 구분코드(0-단어, 1-문장)
	CONSTRAINT wronganswer_userid_fk FOREIGN KEY(userid) REFERENCES Member(userid) ON DELETE CASCADE,
	CONSTRAINT wronganswer_url_fk	 FOREIGN KEY(url) REFERENCES EducationVideo(url) ON DELETE CASCADE
);

CREATE SEQUENCE WRONG_ANSWER_SEQ;

-- 4. 사용자 학습 테이블
CREATE TABLE UserStudy(
	studynum		NUMBER			CONSTRAINT userstudy_studynum_pk		PRIMARY KEY,		-- 학습번호
	userid			VARCHAR2(50),																-- 사용자 아이디
	url				VARCHAR2(1000)	CONSTRAINT userstudy_userid_nn			NOT NULL,			-- 영상URL
	progressTime	VARCHAR2(10)	CONSTRAINT userstudy_progressTime_nn	NOT NULL,			-- 학습시간
	lastStudy		DATE			DEFAULT SYSDATE,											-- 최종학습일
	challengeCount	NUMBER			DEFAULT 0,													-- 도전 횟수
	successCount	NUMBER			DEFAULT 0,													-- 성공 횟수
	failureCount	NUMBER			DEFAULT 0,													-- 실패 횟수
	CONSTRAINT userstudy_userid_fk FOREIGN KEY(userid) REFERENCES Member(userid) ON DELETE CASCADE
);

CREATE SEQUENCE USER_STUDY_SEQ;

-- 5. 찜한 목록 테이블
CREATE TABLE WishList(	
	wishnum			NUMBER			CONSTRAINT wishlist_wishnum_pk		PRIMARY KEY,			-- 찜목록 번호
	userid			VARCHAR2(50),																-- 사용자 아이디
	url				VARCHAR2(1000) 	CONSTRAINT wishlist_url_nn			NOT NULL,				-- 영상URL
	title			VARCHAR2(1000) 	CONSTRAINT wishlist_title_nn		NOT NULL,				-- 영상제목
	regDate			DATE			DEFAULT SYSDATE,											-- 등록일
	CONSTRAINT wishlist_userid_fk FOREIGN KEY(userid) REFERENCES Member(userid) ON DELETE CASCADE
);

CREATE SEQUENCE WISH_LIST_SEQ;

-- 6. 자막요청 게시판 테이블
CREATE TABLE Investigation(
	investigationnum	NUMBER			CONSTRAINT investigation_inum_pk 		PRIMARY KEY,	-- 검증 게시글 번호
	url					VARCHAR2(1000)	CONSTRAINT investigation_url_nn			NOT NULL,		-- 자막 요청 영상
	title				VARCHAR2(200)	CONSTRAINT investigation_title_nn		NOT NULL,		-- 게시글 제목
	content				VARCHAR2(2000),															-- 게시글 내용
	userid				VARCHAR2(50)	CONSTRAINT investigation_userid_nn		NOT NULL,		-- 자막 요청자
	regDate				DATE			DEFAULT SYSDATE,										-- 게시글 등록일
	hitCount			NUMBER			DEFAULT 0,												-- 조회수
	recommendation		NUMBER			DEFAULT 0,												-- 추천수
	decommendation		NUMBER			DEFAULT 0												-- 비추천수
);

CREATE SEQUENCE INVESTIGATION_SEQ;

-- 7. 요청 자막 제공 테이블
CREATE TABLE InvestigationSubtitle(
	subtitlenum			NUMBER			CONSTRAINT isubtitle_subtitlenum_pk		PRIMARY KEY,	-- 요청 자막 제공 번호
	subtitleName		VARCHAR2(200)	CONSTRAINT isubtitle_subtitlename_nn	NOT NULL,		-- 자막 이름
	subtitleFile		VARCHAR2(1000)	CONSTRAINT isubtitle_subtitlefile_nn	NOT NULL,		-- 자막 파일이름
	userid				VARCHAR2(50)	CONSTRAINT isubtitle_userid_nn			NOT NULL,		-- 자막 제공자
	investigationnum	NUMBER,																	-- 자막 요청 게시글 번호
	regDate				DATE			DEFAULT SYSDATE,										-- 자막 제공일
	useCount			NUMBER			DEFAULT 0,												-- 사용횟수
	recommendation		NUMBER			DEFAULT 0,												-- 추천수									
	decommendation		NUMBER			DEFAULT 0,												-- 비추천수
	CONSTRAINT isubtitle_investigationnum_fk FOREIGN KEY(investigationnum) 
	REFERENCES Investigation(investigationnum) ON DELETE CASCADE
);

CREATE SEQUENCE INVESTIGATION_SUBTITLE_SEQ;

-- 8. 자막검증 게시판 댓글 테이블
CREATE TABLE InvestigationReply(
	replynum			NUMBER			CONSTRAINT ireply_replynum_nn	NOT NULL,	-- 댓글 번호
	investigationnum	NUMBER,														-- 검증 게시글 번호
	userid				VARCHAR2(50)	CONSTRAINT ireply_userid_nn		NOT NULL,	-- 댓글 등록자
	content				VARCHAR2(2000)	CONSTRAINT ireply_content_nn	NOT NULL,	-- 댓글 내용
	regDate				DATE			DEFAULT SYSDATE,							-- 댓글 등록일
	blackCount			NUMBER			DEFAULT 0,									-- 신고 횟수
	CONSTRAINT ireply_inum_fk FOREIGN KEY(investigationnum) 
	REFERENCES Investigation(investigationnum) ON DELETE CASCADE
);

CREATE SEQUENCE INVESTIGATION_REPLY_SEQ;

-- 9. 더빙 게시판 테이블
CREATE TABLE  Dubbing(
	dubbingnum			NUMBER			CONSTRAINT dubbing_dubbingnum_pk	PRIMARY KEY,	-- 더빙 게시글 번호
	title				VARCHAR2(200)	CONSTRAINT dubbing_title_nn			NOT NULL,		-- 게시글 제목
	content				VARCHAR2(2000),														-- 게시글 내용
	userid				VARCHAR2(50)	CONSTRAINT dubbing_userid_nn		NOT NULL,		-- 더빙한 사용자
	url					VARCHAR2(1000)	CONSTRAINT dubbing_url_nn			NOT NULL,		-- 더빙한 영상
	voiceFile			VARCHAR2(1000)	CONSTRAINT dubbing_voiceFile_nn		NOT NULL,		-- 더빙 음성  파일
	regDate				DATE			DEFAULT SYSDATE,									-- 게시글 등록일
	hitCount			NUMBER			DEFAULT 0,											-- 조회수
	recommendation		NUMBER			DEFAULT 0,											-- 추천수
	decommendation		NUMBER			DEFAULT 0											-- 비추천수
);

CREATE SEQUENCE DUBBING_SEQ;

-- 10. 더빙 게시판 댓글 테이블
CREATE TABLE DubbingReply(
	replynum			NUMBER			CONSTRAINT dubbingreply_replynum_pk	PRIMARY KEY,	-- 댓글 번호
	dubbingnum			NUMBER,																-- 더빙 게시글 번호
	userid				VARCHAR2(50)	CONSTRAINT dubbingreply_userid_nn	NOT NULL,		-- 댓글 등록자
	content				VARCHAR2(2000)	CONSTRAINT dubbingreply_content_nn	NOT NULL,		-- 댓글 내용
	regDate				DATE			DEFAULT SYSDATE,									-- 댓글 등록일
	blackCount			NUMBER			DEFAULT 0,											-- 신고 횟수
	CONSTRAINT dubbingreply_dnum_fk FOREIGN KEY(dubbingnum) 
	REFERENCES Dubbing(dubbingnum) ON DELETE CASCADE
);

CREATE SEQUENCE DUBBING_REPLY_SEQ;