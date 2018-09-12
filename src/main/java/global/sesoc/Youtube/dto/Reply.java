package global.sesoc.Youtube.dto;

public class Reply {
	private int replynum;
	private int dubbingnum;
	private String useremail;
	private String content;
	private String regdate;
	private int blackcount;
	
	private String usernick;
	private int whichboard;
	
	public Reply() {
		// TODO Auto-generated constructor stub
	}
<<<<<<< HEAD
	
	public Reply(int replynum, int idnum, int blackcount, String useremail, String content, String regdate,
			String usernick, int whichboard) {
		super();
		this.replynum = replynum;
		this.idnum = idnum;
		this.blackcount = blackcount;
=======

	public Reply(int replynum, int dubbingnum, String useremail, String content, String regdate, int blackcount,
			String usernick) {
		super();
		this.replynum = replynum;
		this.dubbingnum = dubbingnum;
>>>>>>> Muk
		this.useremail = useremail;
		this.content = content;
		this.regdate = regdate;
		this.usernick = usernick;
		this.whichboard = whichboard;
	}

	public int getReplynum() {
		return replynum;
	}

	public int getDubbingnum() {
		return dubbingnum;
	}
<<<<<<< HEAD
	public int getBlackcount() {
		return blackcount;
	}
=======

>>>>>>> Muk
	public String getUseremail() {
		return useremail;
	}

	public String getContent() {
		return content;
	}

	public String getRegdate() {
		return regdate;
	}
<<<<<<< HEAD
	public String getUsernick() {
		return usernick;
	}
	public int getWhichboard() {
		return whichboard;
	}
	
=======

	public int getBlackcount() {
		return blackcount;
	}

	public String getUsernick() {
		return usernick;
	}

>>>>>>> Muk
	public void setReplynum(int replynum) {
		this.replynum = replynum;
	}

	public void setDubbingnum(int dubbingnum) {
		this.dubbingnum = dubbingnum;
	}
<<<<<<< HEAD
	public void setBlackcount(int blackcount) {
		this.blackcount = blackcount;
	}
=======

>>>>>>> Muk
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
<<<<<<< HEAD
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
=======

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
>>>>>>> Muk
	}

	
	
	
}
