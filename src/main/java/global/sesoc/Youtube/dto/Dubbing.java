package global.sesoc.Youtube.dto;

public class Dubbing {
	private int dubbingnum;
	private String title;
	private String usernick;
	private String content;
	private String url;
	private String voiceFile;
	private int hitcount;
	private String regdate;
	private int recommendation;
	private int decommendation;
	
	
	public Dubbing() {
		// TODO Auto-generated constructor stub
	}


	public Dubbing(int dubbingnum, String title, String usernick, String content, String url, String voiceFile,
			int hitcount, String regdate, int recommendation, int decommendation) {
		super();
		this.dubbingnum = dubbingnum;
		this.title = title;
		this.usernick = usernick;
		this.content = content;
		this.url = url;
		this.voiceFile = voiceFile;
		this.hitcount = hitcount;
		this.regdate = regdate;
		this.recommendation = recommendation;
		this.decommendation = decommendation;
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


	public int getHitcount() {
		return hitcount;
	}


	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
	}


	public String getRegdate() {
		return regdate;
	}


	public void setRegdate(String regdate) {
		this.regdate = regdate;
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
		return "Dubbing [dubbingnum=" + dubbingnum + ", title=" + title + ", usernick=" + usernick + ", content="
				+ content + ", url=" + url + ", voiceFile=" + voiceFile + ", hitcount=" + hitcount + ", regdate="
				+ regdate + ", recommendation=" + recommendation + ", decommendation=" + decommendation + "]";
	}

	
	
}
