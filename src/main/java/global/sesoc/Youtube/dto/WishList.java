package global.sesoc.Youtube.dto;

public class WishList {
	private int wishnum;
	private int videoNum;			
	private int subtitlenum;			
	private int dubbingnum;
	private String useremail;	
	private String url;			
	private String title;
	private String regDate;
	
	public WishList() {
		super();
	}
	
	public WishList(int wishnum, int videoNum, int subtitlenum, int dubbingnum, String useremail, String url,
			String title, String regDate) {
		super();
		this.wishnum = wishnum;
		this.videoNum = videoNum;
		this.subtitlenum = subtitlenum;
		this.dubbingnum = dubbingnum;
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

	public int getVideoNum() {
		return videoNum;
	}

	public void setVideoNum(int videoNum) {
		this.videoNum = videoNum;
	}

	public int getSubtitlenum() {
		return subtitlenum;
	}

	public void setSubtitlenum(int subtitlenum) {
		this.subtitlenum = subtitlenum;
	}

	public int getDubbingnum() {
		return dubbingnum;
	}

	public void setDubbingnum(int dubbingnum) {
		this.dubbingnum = dubbingnum;
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

	@Override
	public String toString() {
		return "WishList [wishnum=" + wishnum + ", videoNum=" + videoNum + ", subtitlenum=" + subtitlenum
				+ ", dubbingnum=" + dubbingnum + ", useremail=" + useremail + ", url=" + url + ", title=" + title
				+ ", regDate=" + regDate + "]";
	}
}
