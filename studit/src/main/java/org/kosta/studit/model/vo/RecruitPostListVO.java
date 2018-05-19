package org.kosta.studit.model.vo;

import java.util.List;

import org.kosta.studit.model.PagingBean;

public class RecruitPostListVO {

	private PagingBean pagingBean;
	private List<RecruitPostVO> recruitPostList;

	public RecruitPostListVO() {
		super();

	}

	public RecruitPostListVO(PagingBean pagingBean, List<RecruitPostVO> recruitPostList) {
		super();
		this.pagingBean = pagingBean;
		this.recruitPostList = recruitPostList;
	}

	public PagingBean getPagingBean() {
		return pagingBean;
	}

	public void setPagingBean(PagingBean pagingBean) {
		this.pagingBean = pagingBean;
	}

	public List<RecruitPostVO> getRecruitPostList() {
		return recruitPostList;
	}

	public void setRecruitPostList(List<RecruitPostVO> recruitPostList) {
		this.recruitPostList = recruitPostList;
	}

	@Override
	public String toString() {
		return "RecruitPostListVO [pagingBean=" + pagingBean + ", recruitPostList=" + recruitPostList + "]";
	}

}
