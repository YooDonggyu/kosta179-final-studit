package org.kosta.studit.model.vo;


import java.util.List;

import org.kosta.studit.model.PagingBean;

/**
 * 게시물 리스트 정보와 페이징 정보를 가지고 있는 클래스 
 * @author 변태섭
 *
 */
public class StudyConditionListVO {
	private List<StudyConditionVO> list;
	private PagingBean pagingBean;
	
	public StudyConditionListVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StudyConditionListVO(List<StudyConditionVO> list, PagingBean pagingBean) {
		super();
		this.list = list;
		this.pagingBean = pagingBean;
	}

	public List<StudyConditionVO> getList() {
		return list;
	}

	public void setList(List<StudyConditionVO> list) {
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
		return "ListVO [list=" + list + ", pagingBean=" + pagingBean + "]";
	}
	
}










