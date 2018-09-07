package global.sesoc.Youtube.dto;

public class Black {
	private String useremail;
	private int	whichboard;
	private int	replynum;
	private String regdate;
	
	public Black() {
		// TODO Auto-generated constructor stub
	} 
	

	public Black(String useremail, int whichboard, int replynum, String regdate) {
		super();
		this.useremail = useremail;
		this.whichboard = whichboard;
		this.replynum = replynum;
		this.regdate = regdate;
	}


	public String getUseremail() {
		return useremail;
	}

	public int getWhichboard() {
		return whichboard;
	}

	public int getReplynum() {
		return replynum;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}

	public void setWhichboard(int whichboard) {
		this.whichboard = whichboard;
	}

	public void setReplynum(int replynum) {
		this.replynum = replynum;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}


	@Override
	public String toString() {
		return "Black [useremail=" + useremail + ", whichboard=" + whichboard + ", replynum=" + replynum + ", regdate="
				+ regdate + "]";
	}
	
	
}
