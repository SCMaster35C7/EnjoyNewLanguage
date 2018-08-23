package global.sesoc.Youtube.dto;

public class WishList {
	private int wishnum;	
	private String useremail;	
	private String url;			
	private String title;
	private String regDate;
	
	public WishList() {
		// TODO Auto-generated constructor stub
	}

	public WishList(int wishnum, String useremail, String url, String title, String regDate) {
		super();
		this.wishnum = wishnum;
		this.useremail = useremail;
		this.url = url;
		this.title = title;
		this.regDate = regDate;
	}

	public int getWishnum() {
		return wishnum;
	}

	public void setWishnum(int wishnum) {
		this.wishnum = wishnum;
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

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
}
