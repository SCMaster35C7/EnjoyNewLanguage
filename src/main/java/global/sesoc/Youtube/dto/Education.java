package global.sesoc.Youtube.dto;

public class Education {
	private int videoNum;
	private String url;
	private String subtitle;
	private String regDate;
	private int hitCount;
	private int recommendation;
	private int decommendation;
	
	public Education() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Education(int videoNum, String url, String subtitle, String regDate, int hitCount, int recommendation,
			int decommendation) {
		super();
		this.videoNum = videoNum;
		this.url = url;
		this.subtitle = subtitle;
		this.regDate = regDate;
		this.hitCount = hitCount;
		this.recommendation = recommendation;
		this.decommendation = decommendation;
	}
	
	public int getVideoNum() {
		return videoNum;
	}
	public String getUrl() {
		return url;
	}
	public String getSubtitle() {
		return subtitle;
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
	public void setUrl(String url) {
		this.url = url;
	}
	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
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
		return "Education [videoNum=" + videoNum + ", url=" + url + ", subtitle=" + subtitle + ", regDate=" + regDate
				+ ", hitCount=" + hitCount + ", recommendation=" + recommendation + ", decommendation=" + decommendation
				+ "]";
	}
}
