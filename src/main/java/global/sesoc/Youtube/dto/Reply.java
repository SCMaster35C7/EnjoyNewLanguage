package global.sesoc.Youtube.dto;

public class Reply {
	private int replynum;
	private int idnum;
	private String useremail;
	private String content;
	private String regdate;
	private int blackcount;
	
	private String usernick;
	private int whichboard;
	
	public Reply() {
		super();
	}
	public Reply(int replynum, int idnum, String useremail, String content, String regdate, int blackcount,
			String usernick, int whichboard) {
		super();
		this.replynum = replynum;
		this.idnum = idnum;
		this.useremail = useremail;
		this.content = content;
		this.regdate = regdate;
		this.blackcount = blackcount;
		this.usernick = usernick;
		this.whichboard = whichboard;
	}
	public int getReplynum() {
		return replynum;
	}
	public void setReplynum(int replynum) {
		this.replynum = replynum;
	}
	public int getIdnum() {
		return idnum;
	}
	public void setIdnum(int idnum) {
		this.idnum = idnum;
	}
	public String getUseremail() {
		return useremail;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getBlackcount() {
		return blackcount;
	}
	public void setBlackcount(int blackcount) {
		this.blackcount = blackcount;
	}
	public String getUsernick() {
		return usernick;
	}
	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}
	public int getWhichboard() {
		return whichboard;
	}
	public void setWhichboard(int whichboard) {
		this.whichboard = whichboard;
	}
	@Override
	public String toString() {
		return "Reply [replynum=" + replynum + ", idnum=" + idnum + ", useremail=" + useremail + ", content=" + content
				+ ", regdate=" + regdate + ", blackcount=" + blackcount + ", usernick=" + usernick + ", whichboard="
				+ whichboard + "]";
	}
}
