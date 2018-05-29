package org.kosta.studit.model.vo;

import java.util.List;

import org.kosta.studit.model.CompanyPagingBean;

public class CompanyListVO {
	private List<CompanyVO> list;
	private CompanyPagingBean pagingBean;
	
	public CompanyListVO() {
		super();
	}

	public CompanyListVO(List<CompanyVO> list, CompanyPagingBean pagingBean) {
		super();
		this.list = list;
		this.pagingBean = pagingBean;
	}

	public List<CompanyVO> getList() {
		return list;
	}

	public void setList(List<CompanyVO> list) {
		this.list = list;
	}

	public CompanyPagingBean getPagingBean() {
		return pagingBean;
	}

	public void setPagingBean(CompanyPagingBean pagingBean) {
		this.pagingBean = pagingBean;
	}

	@Override
	public String toString() {
		return "CompanyListVO [list=" + list + ", pagingBean=" + pagingBean + "]";
	}
	
}
