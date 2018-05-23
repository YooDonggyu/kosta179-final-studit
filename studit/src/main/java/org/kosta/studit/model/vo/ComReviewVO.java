package org.kosta.studit.model.vo;

public class ComReviewVO {
	private int comReviewNo;
	private String content;
	private String score;
	private String name;
	private String regdate;
	private CompanyVO companyVO;  //FK
	private MemberVO memberVO; //FK
	public ComReviewVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ComReviewVO(int comReviewNo, String content, String score, String name, String regdate, CompanyVO companyVO,
			MemberVO memberVO) {
		super();
		this.comReviewNo = comReviewNo;
		this.content = content;
		this.score = score;
		this.name = name;
		this.regdate = regdate;
		this.companyVO = companyVO;
		this.memberVO = memberVO;
	}
	public int getComReviewNo() {
		return comReviewNo;
	}
	public void setComReviewNo(int comReviewNo) {
		this.comReviewNo = comReviewNo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public CompanyVO getCompanyVO() {
		return companyVO;
	}
	public void setCompanyVO(CompanyVO companyVO) {
		this.companyVO = companyVO;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	
	
}
