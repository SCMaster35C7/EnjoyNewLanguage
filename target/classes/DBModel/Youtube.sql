DROP TABLE DubbingReply;			-- 자막요청 게시판 댓글 테이블
DROP TABLE DubbingRecomend;			-- 더빙 게시판 추천 테이블
DROP TABLE Dubbing;					-- 더빙 게시판 테이블
DROP TABLE InvestigationReply;		-- 자막요청 게시판 댓글 테이블
DROP TABLE SubtitleRecomend;		-- 요청자막 추천 테이블
DROP TABLE InvestigationSubtitle;	-- 요청자막 제공 테이블
DROP TABLE InvestigationRecomend;	-- 자막요청 게시판 추천 테이블
DROP TABLE Investigation;			-- 자막요청 게시판 테이블
DROP TABLE WishList;				-- 찜한목록 테이블
DROP TABLE UserStudy;				-- 사용자학습 테이블
DROP TABLE WrongAnswer;				-- 사용자오답 테이블
DROP TABLE EduVideoRecomend;		-- 교육자료 추천 테이블
DROP TABLE EducationVideo;			-- 교육자료 테이블
DROP TABLE Member;					-- 사용자정보 테이블

DROP SEQUENCE DUBBING_REPLY_SEQ;			-- 더빙게시판 댓글 시퀀스
DROP SEQUENCE DUBBING_RECOMEND_SEQ;			-- 더빙게시판 추천 시퀀스
DROP SEQUENCE DUBBING_SEQ;					-- 더빙게시판 시퀀스
DROP SEQUENCE INVESTIGATION_REPLY_SEQ;		-- 자막검증게시판 댓글 시퀀스
DROP SEQUENCE SUBTITLE_RECOMEND_SEQ;		-- 요청자막 추천 시퀀스
DROP SEQUENCE INVESTIGATION_SUBTITLE_SEQ;	-- 요청자막 제공 시퀀스 
DROP SEQUENCE INVESTIGATION_RECOMEND_SEQ;	-- 자막요청 추천 시퀀스
DROP SEQUENCE INVESTIGATION_SEQ;			-- 자막요청 시퀀스
DROP SEQUENCE WISH_LIST_SEQ;				-- 찜한목록 시퀀스	
DROP SEQUENCE USER_STUDY_SEQ;				-- 사용자학습용 시퀀스
DROP SEQUENCE WRONG_ANSWER_SEQ;				-- 사용자오답용 시퀀스
DROP SEQUENCE EDUCATION_VIDEO_RECOMEND_SEQ;	-- 교육자료 추천 시퀀스
DROP SEQUENCE EDUCATION_VIDEO_SEQ;			-- 교육자료용 시퀀스

CREATE TABLE Member (
   useremail     VARCHAR2(100)  CONSTRAINT user_useremail_pk  PRIMARY KEY,   	-- 이메일(아이디)
   usernick      VARCHAR2(100)  CONSTRAINT user_usernick_nn   NOT NULL UNIQUE,  -- 이름
   userpwd       VARCHAR2(100)  CONSTRAINT user_userpwd_nn    NOT NULL,      	-- 비밀번호
   gender        CHAR(1)        CONSTRAINT user_gender_nn     NOT NULL,      	-- 성별
   birth         DATE         	CONSTRAINT user_birth_nn      NOT NULL,      	-- 생일
   joinDate      DATE         	DEFAULT SYSDATE,                        		-- 가입일
   lastAccess    DATE         	DEFAULT SYSDATE,                       		 	-- 최종접속일
   point         NUMBER         DEFAULT 0,                             		 	-- 포인트
   warningCount  NUMBER         DEFAULT 0,                              		-- 경고수
   admin         NUMBER         DEFAULT 1,                           			-- 관리자 유무 	(0-관리자, 1-사용자)
   status        NUMBER 		DEFAULT 0                  						-- 인증상태 	(0-waiting, 1-complete)
);
-- 2. 교육 자료 테이블(교육용 게시판용)
CREATE TABLE EducationVideo(
	videoNum			NUMBER 			CONSTRAINT eduvideo_videoNum_pk		PRIMARY KEY,	-- 교육용 비디오번호
	title				VARCHAR2(100)	CONSTRAINT eduvideo_title_nn		NOT NULL,		-- 교육영상 제목
	url					VARCHAR2(1000)	CONSTRAINT eduvideo_url_nn			NOT NULL,		-- 교육영상 URL
	originalFile		VARCHAR2(1000) 	CONSTRAINT eduvideo_originalfile_nn	NOT NULL,		-- 파일 원본 이름
	savedFile			VARCHAR2(1000) 	CONSTRAINT eduvideo_savedfile_nn	NOT NULL,		-- 저장된 파일 이름
	regDate				DATE			DEFAULT SYSDATE,									-- 등록일
	hitCount			NUMBER			DEFAULT 0,											-- 조회수
	recommendation		NUMBER			DEFAULT 0,											-- 추천수
	decommendation		NUMBER			DEFAULT 0,											-- 비추천수
	CONSTRAINT eduvideo_url_uq UNIQUE(url)
);

CREATE SEQUENCE EDUCATION_VIDEO_SEQ;

--3. 교육 영상 추천 테이블
CREATE TABLE EduVideoRecomend (
	recommendNum	NUMBER 	CONSTRAINT edurecomend_recommendNum_pk		PRIMARY KEY,
	recommendation	NUMBER	CONSTRAINT edurecomend_recommendation_NN	NOT NULL,
	useremail		VARCHAR2(100),
	videoNum		NUMBER,
	recommendDate	Date DEFAULT SYSDATE,
	CONSTRAINT edurecomend_useremail_fk FOREIGN KEY(useremail) 	REFERENCES Member(useremail) ON DELETE CASCADE,
	CONSTRAINT edurecomend_videonum_fk 	FOREIGN KEY(videoNum) 	REFERENCES EducationVideo(videoNum)  ON DELETE CASCADE
);

CREATE SEQUENCE EDUCATION_VIDEO_RECOMEND_SEQ;

-- 4. 사용자 오답 테이블
CREATE TABLE WrongAnswer(
	answernum		NUMBER			CONSTRAINT wronganswer_answernum_pk			PRIMARY KEY,	-- 오답번호
	useremail		VARCHAR2(50),																-- 아이디
	wrongIndex      VARCHAR2(50),
	correctAnswer	VARCHAR2(1000) 	CONSTRAINT wronganswer_correctAnswer_nn 	NOT NULL,		-- 올바른 문장
	url				VARCHAR2(1000),																-- 영상URL
	regDate			DATE			DEFAULT SYSDATE,											-- 등록일
	classification	NUMBER			CONSTRAINT wronganswer_classification_nn	NOT NULL,		-- 구분코드(0-단어, 1-문장)
	CONSTRAINT wronganswer_useremail_fk FOREIGN KEY(useremail) REFERENCES Member(useremail) ON DELETE CASCADE,
	CONSTRAINT wronganswer_url_fk	FOREIGN KEY(url) REFERENCES EducationVideo(url) ON DELETE CASCADE
);

CREATE SEQUENCE WRONG_ANSWER_SEQ;

-- 5. 사용자 학습 테이블
CREATE TABLE UserStudy(
	studynum		NUMBER			CONSTRAINT userstudy_studynum_pk		PRIMARY KEY,		-- 학습번호
	useremail		VARCHAR2(50),																-- 사용자 아이디
	url				VARCHAR2(1000)	CONSTRAINT userstudy_useremail_nn		NOT NULL,			-- 영상URL
	lastStudy		DATE			DEFAULT SYSDATE,
        testlevel       NUMBER                											-- 최종학습일
	challengeCount	NUMBER			DEFAULT 0,													-- 도전 횟수
	successCount	NUMBER			DEFAULT 0,													-- 성공 횟수
	failureCount	NUMBER			DEFAULT 0,													-- 실패 횟수
	CONSTRAINT userstudy_useremail_fk FOREIGN KEY(useremail) REFERENCES Member(useremail) ON DELETE CASCADE
);

CREATE SEQUENCE USER_STUDY_SEQ;

-- 6. 찜한 목록 테이블
CREATE TABLE WishList(	
	wishnum			NUMBER			CONSTRAINT wishlist_wishnum_pk		PRIMARY KEY,			-- 찜목록 번호
	useremail			VARCHAR2(50),																-- 사용자 아이디
	url				VARCHAR2(1000) 	CONSTRAINT wishlist_url_nn			NOT NULL,				-- 영상URL
	title			VARCHAR2(1000) 	CONSTRAINT wishlist_title_nn		NOT NULL,				-- 영상제목
	regDate			DATE			DEFAULT SYSDATE,											-- 등록일
	CONSTRAINT wishlist_useremail_fk FOREIGN KEY(useremail) REFERENCES Member(useremail) ON DELETE CASCADE
);

CREATE SEQUENCE WISH_LIST_SEQ;

-- 7. 자막요청 게시판 테이블
CREATE TABLE Investigation(
	investigationnum	NUMBER			CONSTRAINT investigation_inum_pk 		PRIMARY KEY,	-- 검증 게시글 번호
	url					VARCHAR2(1000)	CONSTRAINT investigation_url_nn			NOT NULL,		-- 자막 요청 영상
	title				VARCHAR2(200)	CONSTRAINT investigation_title_nn		NOT NULL,		-- 게시글 제목
	content				VARCHAR2(2000),															-- 게시글 내용
	useremail			VARCHAR2(50)	CONSTRAINT investigation_useremail_nn	NOT NULL,		-- 자막 요청자
	regDate				DATE			DEFAULT SYSDATE,										-- 게시글 등록일
	hitCount			NUMBER			DEFAULT 0,												-- 조회수
	recommendation		NUMBER			DEFAULT 0,												-- 추천수
	decommendation		NUMBER			DEFAULT 0												-- 비추천수
);

CREATE SEQUENCE INVESTIGATION_SEQ;

-- 8. 자막 요청 게시판 추천용
CREATE TABLE InvestigationRecomend (
	recommendNum		NUMBER 	CONSTRAINT invrecomend_recommendNum_pk		PRIMARY KEY,	-- 추천 번호
	recommendation		NUMBER	CONSTRAINT invrecomend_recommendation_nn	NOT NULL,		-- 추천/비추천 (0-비추천, 1-추천)
	useremail			VARCHAR2(100),														-- 이메일(아이디)
	investigationnum	NUMBER,																-- 자막 게시글 번호
	recommendDate		Date 	DEFAULT SYSDATE,											-- 추천일
	CONSTRAINT invrecomend_useremail_fk FOREIGN KEY(useremail) REFERENCES Member(useremail) ON DELETE CASCADE,
	CONSTRAINT invrecomend_invnum_fk  FOREIGN KEY(investigationnum) REFERENCES Investigation(investigationnum)  ON DELETE CASCADE
);

CREATE SEQUENCE INVESTIGATION_RECOMEND_SEQ;

-- 9. 요청 자막 제공 테이블
CREATE TABLE InvestigationSubtitle(
	subtitlenum			NUMBER			CONSTRAINT isubtitle_subtitlenum_pk		PRIMARY KEY,	-- 요청 자막 제공 번호
	subtitleName		VARCHAR2(200)	CONSTRAINT isubtitle_subtitlename_nn	NOT NULL,		-- 자막 이름
	originalFile		VARCHAR2(1000)	CONSTRAINT isubtitle_originalfile_nn	NOT NULL,		-- 자막 원본 이름
	savedFile			VARCHAR2(1000)	CONSTRAINT isubtitle_savedFile_nn		NOT NULL,		-- 저장된 파일 이름
	useremail			VARCHAR2(50)	CONSTRAINT isubtitle_useremail_nn		NOT NULL,		-- 자막 제공자
	investigationnum	NUMBER,																	-- 자막 요청 게시글 번호
	regDate				DATE			DEFAULT SYSDATE,										-- 자막 제공일
	useCount			NUMBER			DEFAULT 0,												-- 사용횟수
	recommendation		NUMBER			DEFAULT 0,												-- 추천수									
	decommendation		NUMBER			DEFAULT 0,												-- 비추천수
	CONSTRAINT isubtitle_investigationnum_fk FOREIGN KEY(investigationnum) 
	REFERENCES Investigation(investigationnum) ON DELETE CASCADE
);

CREATE SEQUENCE INVESTIGATION_SUBTITLE_SEQ;

--10. 요청 자막 추천 테이블
CREATE TABLE SubtitleRecomend (
	recommendNum		NUMBER 	CONSTRAINT subrecomend_recommendNum_pk		PRIMARY KEY,	-- 추천 번호
	recommendation		NUMBER	CONSTRAINT subrecomend_recommendation_nn	NOT NULL,		-- 추천/비추천 (0-비추천, 1-추천)
	useremail			VARCHAR2(100),														-- 이메일(아이디)
	subtitlenum			NUMBER,																-- 자막 게시글 번호
	recommendDate		Date 	DEFAULT SYSDATE,											-- 추천일
	CONSTRAINT subrecomend_useremail_fk FOREIGN KEY(useremail) REFERENCES Member(useremail) ON DELETE CASCADE,
	CONSTRAINT subrecomend_subtitlenum_fk  FOREIGN KEY(subtitlenum) REFERENCES InvestigationSubtitle(subtitlenum)  ON DELETE CASCADE
);

CREATE SEQUENCE SUBTITLE_RECOMEND_SEQ;

-- 11. 자막검증 게시판 댓글 테이블
CREATE TABLE InvestigationReply(
	replynum			NUMBER			CONSTRAINT ireply_replynum_nn	NOT NULL,	-- 댓글 번호
	investigationnum	NUMBER,														-- 검증 게시글 번호
	useremail			VARCHAR2(50)	CONSTRAINT ireply_useremail_nn	NOT NULL,	-- 댓글 등록자
	content				VARCHAR2(2000)	CONSTRAINT ireply_content_nn	NOT NULL,	-- 댓글 내용
	regDate				DATE			DEFAULT SYSDATE,							-- 댓글 등록일
	blackCount			NUMBER			DEFAULT 0,									-- 신고 횟수
	CONSTRAINT ireply_inum_fk FOREIGN KEY(investigationnum) 
	REFERENCES Investigation(investigationnum) ON DELETE CASCADE
);

CREATE SEQUENCE INVESTIGATION_REPLY_SEQ;

-- 12. 더빙 게시판 테이블
CREATE TABLE  Dubbing(
	dubbingnum			NUMBER			CONSTRAINT dubbing_dubbingnum_pk	PRIMARY KEY,	-- 더빙 게시글 번호
	title				VARCHAR2(200)	CONSTRAINT dubbing_title_nn			NOT NULL,		-- 게시글 제목
	content				VARCHAR2(2000),														-- 게시글 내용
	useremail			VARCHAR2(50)	CONSTRAINT dubbing_useremail_nn		NOT NULL,		-- 더빙한 사용자
	url					VARCHAR2(1000)	CONSTRAINT dubbing_url_nn			NOT NULL,		-- 더빙한 영상
	voiceFile			VARCHAR2(1000)	CONSTRAINT dubbing_voiceFile_nn		NOT NULL,		-- 더빙 음성  파일
	regDate				DATE			DEFAULT SYSDATE,									-- 게시글 등록일
	hitCount			NUMBER			DEFAULT 0,											-- 조회수
	recommendation		NUMBER			DEFAULT 0,											-- 추천수
	decommendation		NUMBER			DEFAULT 0											-- 비추천수
);

CREATE SEQUENCE DUBBING_SEQ;

--13. 더빙 게시판 추천 테이블
CREATE TABLE DubbingRecomend (
	recommendNum		NUMBER 	CONSTRAINT dubrecomend_recommendNum_pk		PRIMARY KEY,	-- 추천 번호
	recommendation		NUMBER	CONSTRAINT dubrecomend_recommendation_nn	NOT NULL,		-- 추천/비추천 (0-비추천, 1-추천)
	useremail			VARCHAR2(100),														-- 이메일(아이디)
	dubbingnum			NUMBER,																-- 자막 게시글 번호
	recommendDate		Date 	DEFAULT SYSDATE,											-- 추천일
	CONSTRAINT dubrecomend_useremail_fk FOREIGN KEY(useremail) REFERENCES Member(useremail) ON DELETE CASCADE,
	CONSTRAINT dubrecomend_dubbingnum_fk  FOREIGN KEY(dubbingnum) REFERENCES Dubbing(dubbingnum)  ON DELETE CASCADE
);

CREATE SEQUENCE DUBBING_RECOMEND_SEQ;

-- 14. 더빙 게시판 댓글 테이블
CREATE TABLE DubbingReply(
	replynum			NUMBER			CONSTRAINT dubbingreply_replynum_pk		PRIMARY KEY,	-- 댓글 번호
	dubbingnum			NUMBER,																	-- 더빙 게시글 번호
	useremail			VARCHAR2(50)	CONSTRAINT dubbingreply_useremail_nn	NOT NULL,		-- 댓글 등록자
	content				VARCHAR2(2000)	CONSTRAINT dubbingreply_content_nn		NOT NULL,		-- 댓글 내용
	regDate				DATE			DEFAULT SYSDATE,										-- 댓글 등록일
	blackCount			NUMBER			DEFAULT 0,												-- 신고 횟수
	CONSTRAINT dubbingreply_dnum_fk FOREIGN KEY(dubbingnum) 
	REFERENCES Dubbing(dubbingnum) ON DELETE CASCADE
);

CREATE SEQUENCE DUBBING_REPLY_SEQ;