package global.sesoc.Youtube.dto;

public class Member {
	private String userid;
	private String username;
	private String userpwd;
	private String phone;
	private char gender;
	private String birth;
	private String joinDate;
	private String lastAccess;
	private int point;
	private int waringCount;
	private int admin;
	
	public Member() {
		super();
	}
	
	public Member(String userid, String username, String userpwd, String phone, char gender, String birth,
			String joinDate, String lastAccess, int point, int waringCount, int admin) {
		super();
		this.userid = userid;
		this.username = username;
		this.userpwd = userpwd;
		this.phone = phone;
		this.gender = gender;
		this.birth = birth;
		this.joinDate = joinDate;
		this.lastAccess = lastAccess;
		this.point = point;
		this.waringCount = waringCount;
		this.admin = admin;
	}
	
	public String getUserid() {
		return userid;
	}
	public String getUsername() {
		return username;
	}
	public String getUserpwd() {
		return userpwd;
	}
	public String getPhone() {
		return phone;
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
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public void setPhone(String phone) {
		this.phone = phone;
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
	
	@Override
	public String toString() {
		return "Member [userid=" + userid + ", username=" + username + ", userpwd=" + userpwd + ", phone=" + phone
				+ ", gender=" + gender + ", birth=" + birth + ", joinDate=" + joinDate + ", lastAccess=" + lastAccess
				+ ", point=" + point + ", waringCount=" + waringCount + ", admin=" + admin + "]";
	}
}
