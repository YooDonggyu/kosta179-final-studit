package org.kosta.studit.model.vo;

public class ComReviewCommentVO {
	private int comCommentNo;
	private String content;
	private String regdate;
	private ComReviewVO comReviewVO; //FK
	private CompanyVO companyVO; //FK
	public ComReviewCommentVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ComReviewCommentVO(int comCommentNo, String content, String regdate, ComReviewVO comReviewVO,
			CompanyVO companyVO) {
		super();
		this.comCommentNo = comCommentNo;
		this.content = content;
		this.regdate = regdate;
		this.comReviewVO = comReviewVO;
		this.companyVO = companyVO;
	}
	public int getComCommentNo() {
		return comCommentNo;
	}
	public void setComCommentNo(int comCommentNo) {
		this.comCommentNo = comCommentNo;
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
	public ComReviewVO getComReviewVO() {
		return comReviewVO;
	}
	public void setComReviewVO(ComReviewVO comReviewVO) {
		this.comReviewVO = comReviewVO;
	}
	public CompanyVO getCompanyVO() {
		return companyVO;
	}
	public void setCompanyVO(CompanyVO companyVO) {
		this.companyVO = companyVO;
	}
	@Override
	public String toString() {
		return "ComReviewCommentVO [comCommentNo=" + comCommentNo + ", content=" + content + ", regdate=" + regdate
				+ ", comReviewVO=" + comReviewVO + ", companyVO=" + companyVO + "]";
	}
	
	
	
	
}
