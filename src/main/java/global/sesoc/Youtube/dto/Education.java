package global.sesoc.Youtube.dto;

public class Education {
	private int videoNum;
	private String title;
	private String url;
	private String originalfile;
	private String savedfile;
	private String regDate;
	private int hitCount;
	private int recommendation;
	private int decommendation;
	
	public Education() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Education(int videoNum, String title, String url, String originalfile, String savedfile, String regDate,
			int hitCount, int recommendation, int decommendation) {
		super();
		this.videoNum = videoNum;
		this.title = title;
		this.url = url;
		this.originalfile = originalfile;
		this.savedfile = savedfile;
		this.regDate = regDate;
		this.hitCount = hitCount;
		this.recommendation = recommendation;
		this.decommendation = decommendation;
	}
	
	public int getVideoNum() {
		return videoNum;
	}
	public String getTitle() {
		return title;
	}
	public String getUrl() {
		return url;
	}
	public String getOriginalfile() {
		return originalfile;
	}
	public String getSavedfile() {
		return savedfile;
	}
	public String getRegDate() {
		return regDate;
	}
	public int getHitCount() {
		return hitCount;
	}
	public int getRecommendation() {
		return recommendation;
	}
	public int getDecommendation() {
		return decommendation;
	}
	
	public void setVideoNum(int videoNum) {
		this.videoNum = videoNum;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public void setOriginalfile(String originalfile) {
		this.originalfile = originalfile;
	}
	public void setSavedfile(String savedfile) {
		this.savedfile = savedfile;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public void setRecommendation(int recommendation) {
		this.recommendation = recommendation;
	}
	public void setDecommendation(int decommendation) {
		this.decommendation = decommendation;
	}
	
	@Override
	public String toString() {
		return "Education [videoNum=" + videoNum + ", title=" + title + ", url=" + url + ", originalfile="
				+ originalfile + ", savedfile=" + savedfile + ", regDate=" + regDate + ", hitCount=" + hitCount
				+ ", recommendation=" + recommendation + ", decommendation=" + decommendation + "]";
	}
}
