package org.kosta.studit.model.vo;

public class MemoVO {
	private int sgMemoNo;
	private String content;
	private String position;
	private String color;
	private int sgNo;
	public MemoVO() {
		super();
	}
	public MemoVO(int sgMemoNo, String content, String position, String color, int sgNo) {
		super();
		this.sgMemoNo = sgMemoNo;
		this.content = content;
		this.position = position;
		this.color = color;
		this.sgNo = sgNo;
	}
	public int getSgMemoNo() {
		return sgMemoNo;
	}
	public void setSgMemoNo(int sgMemoNo) {
		this.sgMemoNo = sgMemoNo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getSgNo() {
		return sgNo;
	}
	public void setSgNo(int sgNo) {
		this.sgNo = sgNo;
	}
	@Override
	public String toString() {
		return "MemoVO [sgMemoNo=" + sgMemoNo + ", content=" + content + ", position=" + position + ", color=" + color
				+ ", sgNo=" + sgNo + "]";
	}
}
