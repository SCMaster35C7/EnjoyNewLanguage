package global.sesoc.Youtube.dto;

public class Member {
	private String useremail;
	private String usernick;
	private String userpwd;
	private char gender;
	private String birth;
	private String joinDate;
	private String lastAccess;
	private int point;
	private int waringCount;
	private int admin;
	private int status;
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Member(String useremail, String usernick, String userpwd, char gender, String birth, String joinDate,
			String lastAccess, int point, int waringCount, int admin, int status) {
		super();
		this.useremail = useremail;
		this.usernick = usernick;
		this.userpwd = userpwd;
		this.gender = gender;
		this.birth = birth;
		this.joinDate = joinDate;
		this.lastAccess = lastAccess;
		this.point = point;
		this.waringCount = waringCount;
		this.admin = admin;
		this.status = status;
	}
	
	public String getUseremail() {
		return useremail;
	}
	public String getUsernick() {
		return usernick;
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
	public int getStatus() {
		return status;
	}
	
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public void setUsernick(String usernick) {
		this.usernick = usernick;
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
	public void setStatus(int status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "Member [useremail=" + useremail + ", usernick=" + usernick + ", userpwd=" + userpwd + ", gender="
				+ gender + ", birth=" + birth + ", joinDate=" + joinDate + ", lastAccess=" + lastAccess + ", point="
				+ point + ", waringCount=" + waringCount + ", admin=" + admin + ", status=" + status + "]";
	}
}
