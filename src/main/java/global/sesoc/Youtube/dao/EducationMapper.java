package global.sesoc.Youtube.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import global.sesoc.Youtube.dto.Education;
import global.sesoc.Youtube.dto.TestResult;
import global.sesoc.Youtube.dto.WrongAnswer;

import global.sesoc.Youtube.dto.Dubbing;
import global.sesoc.Youtube.dto.Education;
import global.sesoc.Youtube.dto.Recommendation;

public interface EducationMapper {
	public List<Education> selectEduList(RowBounds bound); 					// 교육영상 목록
	public Education selectOneFromEduVideo(int videoNum); 					// 교육 영상 가져오기
	public int insertEduVideo(Education education); 						// 교육 영상 삽입
	public int getTotalCount(Map<String, Object> map); 						// 교육 영상 개수 추출
	public int updateHitCount(int videoNum); 								// 교육 영상 조회수 증가
	
	public Recommendation selectOneFromRecommendation(Recommendation reco); // 교육 영상 추천 여부 확인
	public int insertRecommendation(Recommendation reco); 					// 교육 영상 추천/비추천 삽입
	public int deleteRecommend(Recommendation reco); 						// 교육 영상 추천/비추천 삭제
	public int updateRecommend(Recommendation reco); 						// 추천/비추천 변경
	public int updateIncreRecommend(Map<String, Object> map); 				// 추천/비추천수 증가
	public int updateDecreRecommend(Map<String, Object> map); 				// 추천/비추천수 감소
	public int deleteAllRecommend(Map<String, Object> map);   
	
	public String selectSubName(int videoNum); 								// 자막파일 이름가져오기
	public String selectSubName2(String url);

	public String checkUserStudyExist(TestResult tr); // userstudy 테이블에 기초자료가 존재하는지 체크
	public int insertUserStudy(TestResult tr); // userstudy 테이블에 기초자료 생성
	public int checkLastTestlevel(TestResult tr); // 가장 높은 시험난이도 체크
	public int updateTestResult(TestResult tr); // 테스트결과 업데이트
	public int insertWrongAnswer(WrongAnswer wa); // 시험결과중 오답리스트 삽입
	public List<WrongAnswer> selectWrongAnswerList(WrongAnswer wa);// 재시험용 문제 리스트 가져오기
	public int deleteWrongAnswer(WrongAnswer wa); // 재시험에서 맞춘 문제는 오답리스트에서 삭제
}
