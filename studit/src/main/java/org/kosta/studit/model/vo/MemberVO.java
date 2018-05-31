package org.kosta.studit.model.vo;

public class MemberVO {
	private String memberEmail;
	private String password;
	private String primaryAddr;
	private String detailAddr;
	private String phone;
	private String regdate;
	private String name;
	private String passwordHint;
	private String passwordAnswer;
	private String picPath;
	public MemberVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberVO(String memberEmail, String password) {
		this.memberEmail = memberEmail;
		this.password = password;
	}

	public MemberVO(String memberEmail, String password, String primaryAddr, String detailAddr, String phone,
			String regdate, String name, String passwordHint, String passwordAnswer, String picPath) {
		super();
		this.memberEmail = memberEmail;
		this.password = password;
		this.primaryAddr = primaryAddr;
		this.detailAddr = detailAddr;
		this.phone = phone;
		this.regdate = regdate;
		this.name = name;
		this.passwordHint = passwordHint;
		this.passwordAnswer = passwordAnswer;
		this.picPath = picPath;
	}

	
	


	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPrimaryAddr() {
		return primaryAddr;
	}

	public void setPrimaryAddr(String primaryAddr) {
		this.primaryAddr = primaryAddr;
	}

	public String getDetailAddr() {
		return detailAddr;
	}

	public void setDetailAddr(String detailAddr) {
		this.detailAddr = detailAddr;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPasswordHint() {
		return passwordHint;
	}

	public void setPasswordHint(String passwordHint) {
		this.passwordHint = passwordHint;
	}

	public String getPasswordAnswer() {
		return passwordAnswer;
	}

	public void setPasswordAnswer(String passwordAnswer) {
		this.passwordAnswer = passwordAnswer;
	}

	public String getPicPath() {
		return picPath;
	}

	public void setPicPath(String picPath) {
		this.picPath = picPath;
	}

	@Override
	public String toString() {
		return "MemberVO [memberEmail=" + memberEmail + ", password=" + password + ", primaryAddr=" + primaryAddr
				+ ", detailAddr=" + detailAddr + ", phone=" + phone + ", regdate=" + regdate + ", name=" + name
				+ ", passwordHint=" + passwordHint + ", passwordAnswer=" + passwordAnswer + ", picPath=" + picPath
				+ "]";
	}
	
}
