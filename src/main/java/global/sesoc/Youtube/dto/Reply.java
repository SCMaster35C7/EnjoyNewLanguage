package global.sesoc.Youtube.dto;

public class Reply {
	private int replynum;
	private int dubbingnum;
	private String useremail;
	private String content;
	private String regdate;
	private int blackcount;
	
	private String usernick;
	
	public Reply() {
		// TODO Auto-generated constructor stub
	}

	public Reply(int replynum, int dubbingnum, String useremail, String content, String regdate, int blackcount,
			String usernick) {
		super();
		this.replynum = replynum;
		this.dubbingnum = dubbingnum;
		this.useremail = useremail;
		this.content = content;
		this.regdate = regdate;
		this.blackcount = blackcount;
		this.usernick = usernick;
	}

	public int getReplynum() {
		return replynum;
	}

	public int getDubbingnum() {
		return dubbingnum;
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

	public int getBlackcount() {
		return blackcount;
	}

	public String getUsernick() {
		return usernick;
	}

	public void setReplynum(int replynum) {
		this.replynum = replynum;
	}

	public void setDubbingnum(int dubbingnum) {
		this.dubbingnum = dubbingnum;
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

	public void setBlackcount(int blackcount) {
		this.blackcount = blackcount;
	}

	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}

	@Override
	public String toString() {
		return "Reply [replynum=" + replynum + ", dubbingnum=" + dubbingnum + ", useremail=" + useremail + ", content="
				+ content + ", regdate=" + regdate + ", blackcount=" + blackcount + ", usernick=" + usernick + "]";
	}

	
	
	
}
