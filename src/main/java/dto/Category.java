package dto;

public class Category {
	private int cateoryNo;
	private String kind;
	private String title;
	private String createdate;
	private int count;
	
	public int getCateoryNo() {
		return cateoryNo;
	}
	public void setCateoryNo(int cateoryNo) {
		this.cateoryNo = cateoryNo;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	@Override
	public String toString() {
		return "Category [cateoryNo=" + cateoryNo + ", kind=" + kind + ", title=" + title + ", createdate=" + createdate
				+ ", count=" + count + "]";
	}
}
