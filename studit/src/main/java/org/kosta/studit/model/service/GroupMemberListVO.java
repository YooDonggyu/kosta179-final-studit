package org.kosta.studit.model.service;

import java.util.List;

import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.vo.GroupMemberVO;

public class GroupMemberListVO {

	private PagingBean pagingBean;
	private List<GroupMemberVO> list;

	public GroupMemberListVO() {
		super();

	}

	public GroupMemberListVO(PagingBean pagingBean, List<GroupMemberVO> list) {
		super();
		this.pagingBean = pagingBean;
		this.list = list;
	}

	public PagingBean getPagingBean() {
		return pagingBean;
	}

	public void setPagingBean(PagingBean pagingBean) {
		this.pagingBean = pagingBean;
	}

	public List<GroupMemberVO> getList() {
		return list;
	}

	public void setList(List<GroupMemberVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "GroupListVO [pagingBean=" + pagingBean + ", list=" + list + "]";
	}

}
