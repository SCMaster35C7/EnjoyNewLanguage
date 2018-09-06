package global.sesoc.Youtube.dto;

public class Video {
	private int videoNum; 
	private String title;
	private String url;
	private int  challengecount;
	
	public Video() {	}

	public Video(int videoNum, String title, String url, int challengecount) {
		super();
		this.videoNum = videoNum;
		this.title = title;
		this.url = url;
		this.challengecount = challengecount;
	}

	public int getVideoNum() {
		return videoNum;
	}

	public void setVideoNum(int videoNum) {
		this.videoNum = videoNum;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getChallengecount() {
		return challengecount;
	}

	public void setChallengecount(int challengecount) {
		this.challengecount = challengecount;
	} 

	@Override
	public String toString() {
		return "Video [videoNum=" + videoNum + ", title=" + title + ", url=" + url + ", challengecount="
				+ challengecount + "]";
	}
}
