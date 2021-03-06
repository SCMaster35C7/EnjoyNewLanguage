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
	private int warningCount;
	private int admin;
	private int status;
	//만든고
	private int allSuccess;
	private int allFailure;
	private int allChallenge;
	private int winningRate;
	 
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Member(String useremail, String usernick, String userpwd, char gender, String birth, String joinDate,
			String lastAccess, int point, int warningCount, int admin, int status, int allSuccess, int allFailure,
			int allChallenge, int winningRate) {
		super();
		this.useremail = useremail;
		this.usernick = usernick;
		this.userpwd = userpwd;
		this.gender = gender;
		this.birth = birth;
		this.joinDate = joinDate;
		this.lastAccess = lastAccess;
		this.point = point;
		this.warningCount = warningCount;
		this.admin = admin;
		this.status = status;
		this.allSuccess = allSuccess;
		this.allFailure = allFailure;
		this.allChallenge = allChallenge;
		this.winningRate = winningRate;
	}
	public String getUseremail() {
		return useremail;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public String getUsernick() {
		return usernick;
	}
	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}
	public String getUserpwd() {
		return userpwd;
	}
	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public char getGender() {
		return gender;
	}
	public void setGender(char gender) {
		this.gender = gender;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getLastAccess() {
		return lastAccess;
	}
	public void setLastAccess(String lastAccess) {
		this.lastAccess = lastAccess;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getWarningCount() {
		return warningCount;
	}
	public void setWarningCount(int warningCount) {
		this.warningCount = warningCount;
	}
	public int getAdmin() {
		return admin;
	}
	public void setAdmin(int admin) {
		this.admin = admin;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getAllSuccess() {
		return allSuccess;
	}
	public void setAllSuccess(int allSuccess) {
		this.allSuccess = allSuccess;
	}
	public int getAllFailure() {
		return allFailure;
	}
	public void setAllFailure(int allFailure) {
		this.allFailure = allFailure;
	}
	public int getAllChallenge() {
		return allChallenge;
	}
	public void setAllChallenge(int allChallenge) {
		this.allChallenge = allChallenge;
	}
	public int getWinningRate() {
		return winningRate;
	}
	public void setWinningRate(int winningRate) {
		this.winningRate = winningRate;
	}
	@Override
	public String toString() {
		return "Member [useremail=" + useremail + ", usernick=" + usernick + ", userpwd=" + userpwd + ", gender="
				+ gender + ", birth=" + birth + ", joinDate=" + joinDate + ", lastAccess=" + lastAccess + ", point="
				+ point + ", warningCount=" + warningCount + ", admin=" + admin + ", status=" + status + ", allSuccess="
				+ allSuccess + ", allFailure=" + allFailure + ", allChallenge=" + allChallenge + ", winningRate="
				+ winningRate + "]";
	}
}

