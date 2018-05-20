package org.kosta.studit.model.vo;

import java.util.List;

import org.kosta.studit.model.PagingBean;

/**
 * 스터디 룸 신청현황 페이징을 위한 VO 
 * @author 유동규
 */
public class StudyRoomConditionListVO {
	
	private List<StudyRoomConditionVO> list;
	private PagingBean pagingBean;
	public StudyRoomConditionListVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StudyRoomConditionListVO(List<StudyRoomConditionVO> list, PagingBean pagingBean) {
		super();
		this.list = list;
		this.pagingBean = pagingBean;
	}
	public List<StudyRoomConditionVO> getList() {
		return list;
	}
	public void setList(List<StudyRoomConditionVO> list) {
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
		return "StudyRoomConditionListVO [list=" + list + ", pagingBean=" + pagingBean + "]";
	}
	
	

}
