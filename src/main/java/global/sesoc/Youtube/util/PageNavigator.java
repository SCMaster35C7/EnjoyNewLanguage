package global.sesoc.Youtube.util;
 
public class PageNavigator {
	// 멤버
	// << < 1 2 3 4 5 > >>
	private final int PAGE_PER_GROUP = 5; 	// 페이지를 5개씩 묶어서 사용하려고 그룹을 만든다.
	private int countPerPage;				// 한 페이지에 들어갈 게시글 개수
	private int currentPage;				// 현재 페이지
	private int totalRecordCount;			// 총 게시물 수
	
	private int totalPageCount;				// 총 페이지수
	private int currentGroup;				// 현재 페이지 그룹
	private int startPageGroup;				// 현 그룹의 시작 페이지 번호
	private int endPageGroup;				// 현 그룹의 마지막 페이지 번호
	private int startRecord;				
	
	// 생성자
	public PageNavigator(int currentPage, int totalRecordCount , int countPerPage) {
		this.totalRecordCount = totalRecordCount;
		this.countPerPage = countPerPage;
		
		// 총 페이지 수 계산, 현재 페이지 수정
		totalPageCount = (totalRecordCount + countPerPage -1) / countPerPage;
		
		if(currentPage < 1) currentPage = 1;
		if(currentPage > totalPageCount) currentPage = totalPageCount;
		this.currentPage = currentPage;
		
		currentGroup = (currentPage - 1) / PAGE_PER_GROUP;
		
		// 현재 그룹의 첫 페이지 0 * 5;
		startPageGroup = currentGroup * PAGE_PER_GROUP + 1;
		startPageGroup = (startPageGroup < 1)? 1: startPageGroup;
		
		// 현재 그룹의 마지막 페이지
		endPageGroup = (currentGroup+1) * PAGE_PER_GROUP;
		endPageGroup = (endPageGroup < totalPageCount)? endPageGroup : totalPageCount;
		
		startRecord = (currentPage -1) * countPerPage;
	}
	
	// setter, getter, toString
	public int getcountPerPage() {
		return countPerPage;
	}

	public int getPAGE_PER_GROUP() {
		return PAGE_PER_GROUP;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getTotalRecordCount() {
		return totalRecordCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public int getCurrentGroup() {
		return currentGroup;
	}

	public int getStartPageGroup() {
		return startPageGroup;
	}

	public int getEndPageGroup() {
		return endPageGroup;
	}

	public int getStartRecord() {
		return startRecord;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public void setCurrentGroup(int currentGroup) {
		this.currentGroup = currentGroup;
	}

	public void setStartPageGroup(int startPageGroup) {
		this.startPageGroup = startPageGroup;
	}

	public void setEndPageGroup(int endPageGroup) {
		this.endPageGroup = endPageGroup;
	}

	public void setStartRecord(int starRecord) {
		this.startRecord = starRecord;
	}

	@Override
	public String toString() {
		return "PageNavigator [countPerPage=" + countPerPage + ", PAGE_PER_GROUP=" + PAGE_PER_GROUP
				+ ", currentPage=" + currentPage + ", totalRecordCount=" + totalRecordCount + ", totalPageCount="
				+ totalPageCount + ", currentGroup=" + currentGroup + ", startPageGroup=" + startPageGroup
				+ ", endPageGroup=" + endPageGroup + ", starRecord=" + startRecord + "]";
	}
}
