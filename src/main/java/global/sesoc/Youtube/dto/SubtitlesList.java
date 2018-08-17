package global.sesoc.Youtube.dto;

import java.util.ArrayList;
import java.util.List;

public class SubtitlesList {

	List<ArrayList<String>> fulltext;
	List<ArrayList<String>> quiz;
	ArrayList<Integer> playtime;
	ArrayList<String> correct;

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

	public ArrayList<Integer> getPlaytime() {
		return playtime;
	}

	public void setPlaytime(ArrayList<Integer> playtime) {
		this.playtime = playtime;
	}

}
