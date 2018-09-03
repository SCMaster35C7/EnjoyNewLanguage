package global.sesoc.Youtube.dto;

public class Investigation {
	private int investigationnum;
	private String url;
	private String title;
	private String content;
	private String useremail;
	private String regdate;
	private int hitcount;
	private int recommendation;
	private int decommendation;
	
	public Investigation() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Investigation(int investigationnum, String url, String title, String content, String useremail,
			String regdate, int hitcount, int recommendation, int decommendation) {
		super();
		this.investigationnum = investigationnum;
		this.url = url;
		this.title = title;
		this.content = content;
		this.useremail = useremail;
		this.regdate = regdate;
		this.hitcount = hitcount;
		this.recommendation = recommendation;
		this.decommendation = decommendation;
	}
	
	public int getInvestigationnum() {
		return investigationnum;
	}
	public String getUrl() {
		return url;
	}
	public String getTitle() {
		return title;
	}
	public String getContent() {
		return content;
	}
	public String getUseremail() {
		return useremail;
	}
	public String getRegdate() {
		return regdate;
	}
	public int getHitcount() {
		return hitcount;
	}
	public int getRecommendation() {
		return recommendation;
	}
	public int getDecommendation() {
		return decommendation;
	}
	
	public void setInvestigationnum(int investigationnum) {
		this.investigationnum = investigationnum;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
	}
	public void setRecommendation(int recommendation) {
		this.recommendation = recommendation;
	}
	public void setDecommendation(int decommendation) {
		this.decommendation = decommendation;
	}
	
	@Override
	public String toString() {
		return "Investigation [investigationnum=" + investigationnum + ", url=" + url + ", title=" + title
				+ ", content=" + content + ", useremail=" + useremail + ", regdate=" + regdate + ", hitcount="
				+ hitcount + ", recommendation=" + recommendation + ", decommendation=" + decommendation + "]";
	}
}
