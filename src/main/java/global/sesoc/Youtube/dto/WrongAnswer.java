package global.sesoc.Youtube.dto;

public class WrongAnswer {

	int answernum;
	String useremail;
	String wrongIndex;
	String correctAnswer;
	String url;
	String regdate;
	int classification;
	
	

	public WrongAnswer() {
		
	}

	public int getAnswernum() {
		return answernum;
	}

	public void setAnswernum(int answernum) {
		this.answernum = answernum;
	}

	public String getUseremail() {
		return useremail;
	}

	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}

	public String getWrongIndex() {
		return wrongIndex;
	}

	public void setWrongIndex(String wrongIndex) {
		this.wrongIndex = wrongIndex;
	}

	public String getCorrectAnswer() {
		return correctAnswer;
	}

	public void setCorrectAnswer(String correctAnswer) {
		this.correctAnswer = correctAnswer;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getClassification() {
		return classification;
	}

	public void setClassification(int classification) {
		this.classification = classification;
	}

	@Override
	public String toString() {
		return "WrongAnswer [answernum=" + answernum + ", useremail=" + useremail + ", wrongIndex=" + wrongIndex
				+ ", correctAnswer=" + correctAnswer + ", url=" + url + ", regdate=" + regdate + ", classification="
				+ classification + "]";
	}

	
	

}
