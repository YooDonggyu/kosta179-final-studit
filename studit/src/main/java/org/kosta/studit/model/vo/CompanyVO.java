package org.kosta.studit.model.vo;

public class CompanyVO {
	private int companyNo;
	private String name;
	private String addr1;
	private String addr2;
	private String addr3;
	private String addr4;
	private String primaryAddr;
	private String detailAddr;
	private String tel;
	private String license;
	private String regdate;
	private String url;
	private String open;
	private String close;
	private String holiday;
	private String intro;
	private String profilePath;
	private String state;
	private int hit;
	private MemberVO memberVO; // FK

	public CompanyVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CompanyVO(int companyNo, String name, String intro, String profilePath) {
		super();
		this.companyNo = companyNo;
		this.name = name;
		this.intro = intro;
		this.profilePath = profilePath;
	}
	
	public CompanyVO(int companyNo, String name, String open, String close, String holiday) {
		super();
		this.companyNo = companyNo;
		this.name = name;
		this.open = open;
		this.close = close;
		this.holiday = holiday;
	}

	public CompanyVO(int companyNo, String name, String addr1, String addr2, String addr3, String addr4,
			String primaryAddr, String detailAddr, String tel, String license, String regdate, String url, String open,
			String close, String holiday, String intro, String profilePath, String state, int hit, MemberVO memberVO) {
		super();
		this.companyNo = companyNo;
		this.name = name;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.addr3 = addr3;
		this.addr4 = addr4;
		this.primaryAddr = primaryAddr;
		this.detailAddr = detailAddr;
		this.tel = tel;
		this.license = license;
		this.regdate = regdate;
		this.url = url;
		this.open = open;
		this.close = close;
		this.holiday = holiday;
		this.intro = intro;
		this.profilePath = profilePath;
		this.state = state;
		this.hit = hit;
		this.memberVO = memberVO;
	}

	public int getCompanyNo() {
		return companyNo;
	}

	public void setCompanyNo(int companyNo) {
		this.companyNo = companyNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getAddr3() {
		return addr3;
	}

	public void setAddr3(String addr3) {
		this.addr3 = addr3;
	}

	public String getAddr4() {
		return addr4;
	}

	public void setAddr4(String addr4) {
		this.addr4 = addr4;
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

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getOpen() {
		return open;
	}

	public void setOpen(String open) {
		this.open = open;
	}

	public String getClose() {
		return close;
	}

	public void setClose(String close) {
		this.close = close;
	}

	public String getHoliday() {
		return holiday;
	}

	public void setHoliday(String holiday) {
		this.holiday = holiday;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getProfilePath() {
		return profilePath;
	}

	public void setProfilePath(String profilePath) {
		this.profilePath = profilePath;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

	@Override
	public String toString() {
		return "CompanyVO [companyNo=" + companyNo + ", name=" + name + ", addr1=" + addr1 + ", addr2=" + addr2
				+ ", addr3=" + addr3 + ", addr4=" + addr4 + ", primaryAddr=" + primaryAddr + ", detailAddr="
				+ detailAddr + ", tel=" + tel + ", license=" + license + ", regdate=" + regdate + ", url=" + url
				+ ", open=" + open + ", close=" + close + ", holiday=" + holiday + ", intro=" + intro + ", profilePath="
				+ profilePath + ", state=" + state + ", hit=" + hit + ", memberVO=" + memberVO + "]";
	}
}
