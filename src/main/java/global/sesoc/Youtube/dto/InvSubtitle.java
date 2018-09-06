package global.sesoc.Youtube.dto;

public class InvSubtitle {
	private int subtitleNum;
	private String subtitleName;
	private String originalFile;
	private String savedFile;
	private String useremail;
	private int investigationNum;
	private String regDate;
	private int useCount;
	private int recommendation;
	private int decommendation;
	
	public InvSubtitle() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public InvSubtitle(int subtitleNum, String subtitleName, String originalFile, String savedFile,
			String useremail, int investigationNum, String regDate, int useCount, int recommendation,
			int decommendation) {
		super();
		this.subtitleNum = subtitleNum;
		this.subtitleName = subtitleName;
		this.originalFile = originalFile;
		this.savedFile = savedFile;
		this.useremail = useremail;
		this.investigationNum = investigationNum;
		this.regDate = regDate;
		this.useCount = useCount;
		this.recommendation = recommendation;
		this.decommendation = decommendation;
	}
	
	public int getSubtitleNum() {
		return subtitleNum;
	}
	public String getSubtitleName() {
		return subtitleName;
	}
	public String getOriginalFile() {
		return originalFile;
	}
	public String getSavedFile() {
		return savedFile;
	}
	public String getUseremail() {
		return useremail;
	}
	public int getInvestigationNum() {
		return investigationNum;
	}
	public String getRegDate() {
		return regDate;
	}
	public int getUseCount() {
		return useCount;
	}
	public int getRecommendation() {
		return recommendation;
	}
	public int getDecommendation() {
		return decommendation;
	}
	
	public void setSubtitleNum(int subtitleNum) {
		this.subtitleNum = subtitleNum;
	}
	public void setSubtitleName(String subtitleName) {
		this.subtitleName = subtitleName;
	}
	public void setOriginalFile(String originalFile) {
		this.originalFile = originalFile;
	}
	public void setSavedFile(String savedFile) {
		this.savedFile = savedFile;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public void setInvestigationNum(int investigationNum) {
		this.investigationNum = investigationNum;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public void setUseCount(int useCount) {
		this.useCount = useCount;
	}
	public void setRecommendation(int recommendation) {
		this.recommendation = recommendation;
	}
	public void setDecommendation(int decommendation) {
		this.decommendation = decommendation;
	}
	
	@Override
	public String toString() {
		return "InvestigationSubtitle [subtitleNum=" + subtitleNum + ", subtitleName=" + subtitleName + ", originalFile="
				+ originalFile + ", savedFile=" + savedFile + ", useremail=" + useremail + ", investigationNum="
				+ investigationNum + ", regDate=" + regDate + ", useCount=" + useCount + ", recommendation="
				+ recommendation + ", decommendation=" + decommendation + "]";
	}
}
