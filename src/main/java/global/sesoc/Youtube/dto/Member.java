package global.sesoc.Youtube.dto;

public class Member {
	private String userid;
	private String useremail;
	private String userpwd;
	private char gender;
	private String birth;
	private String joinDate;
	private String lastAccess;
	private int point;
	private int waringCount;
	private int admin;
	private int statis;
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Member(String userid, String useremail, String userpwd, char gender, String birth, String joinDate,
			String lastAccess, int point, int waringCount, int admin, int statis) {
		super();
		this.userid = userid;
		this.useremail = useremail;
		this.userpwd = userpwd;
		this.gender = gender;
		this.birth = birth;
		this.joinDate = joinDate;
		this.lastAccess = lastAccess;
		this.point = point;
		this.waringCount = waringCount;
		this.admin = admin;
		this.statis = statis;
	}
	public String getUserid() {
		return userid;
	}
	public String getUseremail() {
		return useremail;
	}
	public String getUserpwd() {
		return userpwd;
	}
	public char getGender() {
		return gender;
	}
	public String getBirth() {
		return birth;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public String getLastAccess() {
		return lastAccess;
	}
	public int getPoint() {
		return point;
	}
	public int getWaringCount() {
		return waringCount;
	}
	public int getAdmin() {
		return admin;
	}
	public int getStatis() {
		return statis;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public void setGender(char gender) {
		this.gender = gender;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public void setLastAccess(String lastAccess) {
		this.lastAccess = lastAccess;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public void setWaringCount(int waringCount) {
		this.waringCount = waringCount;
	}
	public void setAdmin(int admin) {
		this.admin = admin;
	}
	public void setStatis(int statis) {
		this.statis = statis;
	}
	@Override
	public String toString() {
		return "Member [userid=" + userid + ", useremail=" + useremail + ", userpwd=" + userpwd + ", gender=" + gender
				+ ", birth=" + birth + ", joinDate=" + joinDate + ", lastAccess=" + lastAccess + ", point=" + point
				+ ", waringCount=" + waringCount + ", admin=" + admin + ", statis=" + statis + "]";
	}
	
	
}
