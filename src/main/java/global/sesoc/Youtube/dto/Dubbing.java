package global.sesoc.Youtube.dto;

public class Dubbing {

	private int dubbingnum;
	private String title;
	private String content;
	private String useremail;
	private String usernick;
	private String url;
	private String voiceFile;
	private String regdate;
	private int hitcount;
	private int recommendation;
	private int decommendation;

	public Dubbing() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getDubbingnum() {
		return dubbingnum;
	}

	public void setDubbingnum(int dubbingnum) {
		this.dubbingnum = dubbingnum;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	
	
	

	public String getUsernick() {
		return usernick;
	}

	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public String getVoiceFile() {
		return voiceFile;
	}

	public void setVoiceFile(String voiceFile) {
		this.voiceFile = voiceFile;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getHitcount() {
		return hitcount;
	}

	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
	}

	public int getRecommendation() {
		return recommendation;
	}

	public void setRecommendation(int recommendation) {
		this.recommendation = recommendation;
	}

	public int getDecommendation() {
		return decommendation;
	}

	public void setDecommendation(int decommendation) {
		this.decommendation = decommendation;
	}

	@Override
	public String toString() {
		return "Dubbing [dubbingnum=" + dubbingnum + ", title=" + title + ", useremail=" + useremail + ", url=" + url
				+ ", voiceFile=" + voiceFile + ", regdate=" + regdate + ", hitcount=" + hitcount + ", recommendation="
				+ recommendation + ", decommendation=" + decommendation + "]";
	}

}
