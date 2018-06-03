package org.kosta.studit.model.vo;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.PagingBean;

public class MemberListVO {
	private List<MemberVO> list;
	private PagingBean pagingBean;
	private Map<String, Object> map;
	public MemberListVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MemberListVO(List<MemberVO> list, PagingBean pagingBean) {
		super();
		this.list = list;
		this.pagingBean = pagingBean;
	}
	
	public MemberListVO(List<MemberVO> list, PagingBean pagingBean, Map<String, Object> map) {
		super();
		this.list = list;
		this.pagingBean = pagingBean;
		this.map = map;
	}
	
	public Map<String, Object> getMap() {
		return map;
	}
	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	public List<MemberVO> getList() {
		return list;
	}
	public void setList(List<MemberVO> list) {
		this.list = list;
	}
	public PagingBean getPagingBean() {
		return pagingBean;
	}
	public void setPagingBean(PagingBean pagingBean) {
		this.pagingBean = pagingBean;
	}
	@Override
	public String toString() {
		return "MemberListVO [list=" + list + ", pagingBean=" + pagingBean + "]";
	}
	
	
	
	
}
