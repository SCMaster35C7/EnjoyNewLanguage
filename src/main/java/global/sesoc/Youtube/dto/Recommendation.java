package global.sesoc.Youtube.dto;

public class Recommendation {
	private String tableName;
	private String idCode;
	private String useremail;
	private int identificationnum;
	private int recommendtable;
	private int recommendation;
	private String regDate;
	 
	public Recommendation() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Recommendation(String tableName, String idCode, String useremail, int identificationnum, int recommendtable,
			int recommendation, String regDate) {
		super();
		this.tableName = tableName;
		this.idCode = idCode;
		this.useremail = useremail;
		this.identificationnum = identificationnum;
		this.recommendtable = recommendtable;
		this.recommendation = recommendation;
		this.regDate = regDate;
	}
	
	public String getTableName() {
		return tableName;
	}
	public String getIdCode() {
		return idCode;
	}
	public String getUseremail() {
		return useremail;
	}
	public int getIdentificationnum() {
		return identificationnum;
	}
	public int getRecommendtable() {
		return recommendtable;
	}
	public int getRecommendation() {
		return recommendation;
	}
	public String getRegDate() {
		return regDate;
	}
	
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public void setIdCode(String idCode) {
		this.idCode = idCode;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public void setIdentificationnum(int identificationnum) {
		this.identificationnum = identificationnum;
	}
	public void setRecommendtable(int recommendtable) {
		this.recommendtable = recommendtable;
	}
	public void setRecommendation(int recommendation) {
		this.recommendation = recommendation;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "Recommendation [tableName=" + tableName + ", idCode=" + idCode + ", useremail=" + useremail
				+ ", identificationnum=" + identificationnum + ", recommendtable=" + recommendtable
				+ ", recommendation=" + recommendation + ", regDate=" + regDate + "]";
	}
}
