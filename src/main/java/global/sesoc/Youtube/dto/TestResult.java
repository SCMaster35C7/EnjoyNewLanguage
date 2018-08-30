package global.sesoc.Youtube.dto;

public class TestResult {
	private int studynum;
	private String useremail;
	private String url;
	private String laststudy;
	private int challengecount;
	private int successCount;
	private int failureCount;
	private int testlevel;
	
	public TestResult() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public TestResult(int studynum, String useremail, String url, String laststudy, int challengecount,
			int successCount, int failureCount, int testlevel) {
		super();
		this.studynum = studynum;
		this.useremail = useremail;
		this.url = url;
		this.laststudy = laststudy;
		this.challengecount = challengecount;
		this.successCount = successCount;
		this.failureCount = failureCount;
		this.testlevel = testlevel;
	}
	
	public int getStudynum() {
		return studynum;
	}
	public String getUseremail() {
		return useremail;
	}
	public String getUrl() {
		return url;
	}
	public String getLaststudy() {
		return laststudy;
	}
	public int getChallengecount() {
		return challengecount;
	}
	public int getSuccessCount() {
		return successCount;
	}
		return failureCount;
	}
	public int getTestlevel() {
		return testlevel;
	}
	
	public void setStudynum(int studynum) {
		this.studynum = studynum;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public void setLaststudy(String laststudy) {
		this.laststudy = laststudy;
	}
	public void setChallengecount(int challengecount) {
		this.challengecount = challengecount;
	}
	public void setSuccessCount(int successCount) {
		this.successCount = successCount;
	}
	public void setFailureCount(int failureCount) {
		this.failureCount = failureCount;
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
