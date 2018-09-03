package global.sesoc.Youtube.dto;

public class Dubbing {

	private int dubbingnum;
	private String title;
	private String usernick;
	private String useremail;
	private String content;
	private String url;
	private String voiceFile;
	private int hitcount;
	private String regdate;
	private int recommendation;
	private int decommendation;
	
	public Dubbing() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Dubbing(int dubbingnum, String title, String usernick, String useremail, String content, String url,
			String voiceFile, int hitcount, String regdate, int recommendation, int decommendation) {
		super();
		this.dubbingnum = dubbingnum;
		this.title = title;
		this.usernick = usernick;
		this.useremail = useremail;
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

	public String getTitle() {
		return title;
	}

	public String getUsernick() {
		return usernick;
	}

	public String getUseremail() {
		return useremail;
	}

	public String getContent() {
		return content;
	}

	public String getUrl() {
		return url;
	}

	public String getVoiceFile() {
		return voiceFile;
	}

	public int getHitcount() {
		return hitcount;
	}

	public String getRegdate() {
		return regdate;
	}

	public int getRecommendation() {
		return recommendation;
	}

	public int getDecommendation() {
		return decommendation;
	}

	public void setDubbingnum(int dubbingnum) {
		this.dubbingnum = dubbingnum;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}

	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public void setVoiceFile(String voiceFile) {
		this.voiceFile = voiceFile;
	}

	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public void setRecommendation(int recommendation) {
		this.recommendation = recommendation;
	}

	public void setDecommendation(int decommendation) {
		this.decommendation = decommendation;
	}

	@Override
	public String toString() {
		return "Dubbing [dubbingnum=" + dubbingnum + ", title=" + title + ", usernick=" + usernick + ", useremail="
				+ useremail + ", content=" + content + ", url=" + url + ", voiceFile=" + voiceFile + ", hitcount="
				+ hitcount + ", regdate=" + regdate + ", recommendation=" + recommendation + ", decommendation="
				+ decommendation + "]";
	}
}
