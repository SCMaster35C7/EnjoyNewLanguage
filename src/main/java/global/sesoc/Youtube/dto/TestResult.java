package global.sesoc.Youtube.dto;

public class TestResult {

	private int studynum;
	private String useremail;
	private String url;
	private String laststudy;
	private int challengecount;
	private int successcount;
	private int failcount;
	private int testlevel;

	public TestResult() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getStudynum() {
		return studynum;
	}

	public void setStudynum(int studynum) {
		this.studynum = studynum;
	}

	public String getUseremail() {
		return useremail;
	}

	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getLaststudy() {
		return laststudy;
	}

	public void setLaststudy(String laststudy) {
		this.laststudy = laststudy;
	}

	public int getChallengecount() {
		return challengecount;
	}

	public void setChallengecount(int challengecount) {
		this.challengecount = challengecount;
	}

	public int getSuccesscount() {
		return successcount;
	}

	public void setSuccesscount(int successcount) {
		this.successcount = successcount;
	}

	public int getFailcount() {
		return failcount;
	}

	public void setFailcount(int failcount) {
		this.failcount = failcount;
	}

	public int getTestlevel() {
		return testlevel;
	}

	public void setTestlevel(int testlevel) {
		this.testlevel = testlevel;
	}

	@Override
	public String toString() {
		return "TestResult [studynum=" + studynum + ", useremail=" + useremail + ", url=" + url + ", laststudy="
				+ laststudy + ", challengecount=" + challengecount + ", successCount=" + successCount
				+ ", failureCount=" + failureCount + ", testlevel=" + testlevel + "]";
	}

}
