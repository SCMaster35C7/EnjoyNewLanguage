package global.sesoc.Youtube.dto;

public class WishList {

	private int rnum;
	private int wishtable;
	private int identificationnum;
	private String useremail;
	private String url;
	private String title;
	private String regdate;
	
	public WishList() {
		super();
	}

	public WishList(int rnum, int wishtable, int identificationnum, String useremail, String url, String title,
			String regdate) {
		super();
		this.rnum = rnum;
		this.wishtable = wishtable;
		this.identificationnum = identificationnum;
		this.useremail = useremail;
		this.url = url;
		this.title = title;
		this.regdate = regdate;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public int getWishtable() {
		return wishtable;
	}

	public void setWishtable(int wishtable) {
		this.wishtable = wishtable;
	}

	public int getIdentificationnum() {
		return identificationnum;
	}

	public void setIdentificationnum(int identificationnum) {
		this.identificationnum = identificationnum;
	}

	public String getUseremail() {
		return useremail;
	}

	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "WishList [rnum=" + rnum + ", wishtable=" + wishtable + ", identificationnum=" + identificationnum
				+ ", useremail=" + useremail + ", url=" + url + ", title=" + title + ", regdate=" + regdate + "]";
	}
	
	
}

