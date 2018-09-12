package global.sesoc.Youtube.dto;

import java.util.ArrayList;
import java.util.List;

public class SubtitlesList {
	private List<ArrayList<String>> fulltext; // 2차원 배열로 가공한 전체 택스트
	private List<ArrayList<String>> quiz;     // 2차원 배열로 가공한 퀴즈
	private ArrayList<Double> playtime;       // 문장별 재생시간(계산용)
	private ArrayList<String> playtimeView;   // 문장별 재생시간(시각용)
	private ArrayList<String> correct;        // 퀴즈의 정답 리스트
	private ArrayList<String> quizIndex;      // 각 퀴즈의 2차원배열에서의 인덱스 값

	public SubtitlesList() {
		super();
	}

	public List<ArrayList<String>> getFulltext() {
		return fulltext;
	}

	public void setFulltext(List<ArrayList<String>> fulltext) {
		this.fulltext = fulltext;
	}

	public List<ArrayList<String>> getQuiz() {
		return quiz;
	}

	public void setQuiz(List<ArrayList<String>> quiz) {
		this.quiz = quiz;
	}

	public ArrayList<String> getCorrect() {
		return correct;
	}

	public void setCorrect(ArrayList<String> correct) {
		this.correct = correct;
	}

	public ArrayList<Double> getPlaytime() {
		return playtime;
	}

	public void setPlaytime(ArrayList<Double> playtime) {
		this.playtime = playtime;
	}

	public ArrayList<String> getPlaytimeView() {
		return playtimeView;
	}

	public void setPlaytimeView(ArrayList<String> playtimeView) {
		this.playtimeView = playtimeView;
	}

	public ArrayList<String> getQuizIndex() {
		return quizIndex;
	}

	public void setQuizIndex(ArrayList<String> quizIndex) {
		this.quizIndex = quizIndex;
	}
}
