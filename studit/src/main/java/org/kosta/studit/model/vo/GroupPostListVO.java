package org.kosta.studit.model.vo;

import java.util.List;

import org.kosta.studit.model.PagingBean;

public class GroupPostListVO {
	private List<GroupPostVO> list;
	private PagingBean pb;
	
	public GroupPostListVO() {
		super();
	}
	public GroupPostListVO(List<GroupPostVO> list, PagingBean pb) {
		super();
		this.list = list;
		this.pb = pb;
	}
	public List<GroupPostVO> getList() {
		return list;
	}
	public void setList(List<GroupPostVO> list) {
		this.list = list;
	}
	public PagingBean getPb() {
		return pb;
	}
	public void setPb(PagingBean pb) {
		this.pb = pb;
	}
	@Override
	public String toString() {
		return "GroupPostListVO [list=" + list + ", pb=" + pb + "]";
	}
	
}
