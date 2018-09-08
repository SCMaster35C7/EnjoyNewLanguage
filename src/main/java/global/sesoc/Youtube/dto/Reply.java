package global.sesoc.Youtube.dto;

public class Reply {
	private int replynum;
	private int idnum;
	private int blackcount;
	private String useremail;
	private String content;
	private String regdate;
	private String usernick;
	private int whichboard;
	
	public Reply() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Reply(int replynum, int idnum, int blackcount, String useremail, String content, String regdate,
			String usernick, int whichboard) {
		super();
		this.replynum = replynum;
		this.idnum = idnum;
		this.blackcount = blackcount;
		this.useremail = useremail;
		this.content = content;
		this.regdate = regdate;
		this.usernick = usernick;
		this.whichboard = whichboard;
	}
	
	public int getReplynum() {
		return replynum;
	}
	public int getIdnum() {
		return idnum;
	}
	public int getBlackcount() {
		return blackcount;
	}
	public String getUseremail() {
		return useremail;
	}
	public String getContent() {
		return content;
	}
	public String getRegdate() {
		return regdate;
	}
	public String getUsernick() {
		return usernick;
	}
	public int getWhichboard() {
		return whichboard;
	}
	
	public void setReplynum(int replynum) {
		this.replynum = replynum;
	}
	public void setIdnum(int idnum) {
		this.idnum = idnum;
	}
	public void setBlackcount(int blackcount) {
		this.blackcount = blackcount;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}
	public void setWhichboard(int whichboard) {
		this.whichboard = whichboard;
	}
	
	@Override
	public String toString() {
		return "Reply [replynum=" + replynum + ", idnum=" + idnum + ", blackcount=" + blackcount + ", useremail="
				+ useremail + ", content=" + content + ", regdate=" + regdate + ", usernick=" + usernick
				+ ", whichboard=" + whichboard + "]";
	}
}
