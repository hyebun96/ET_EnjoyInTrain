package com.et.freeBoard;
/*
테이블명	freeBoardReply	자유게시판의 댓글 테이블
컬럼명	fbReplyNum	댓글 번호
		crewCode	회원 코드
		content	댓글 내용
		created	댓글 작성 날짜
		answer	답변 번호
		fbNum	게시판 번호
시퀀스	fbreply_seq	
참조		freeBoard	자유게시판
		crew	회원테이블
*/
public class Reply {
	private int fbReplyNum;	//댓글 번호
	private int num;
	private String crewId;
	private String crewName;
	private String content;	//댓글내용
	private String created; //댓글작성날짜
	private String answer;  //답변번호
	private int fbNum;		//게시판번호
	
	private int answerCount;   //답변갯수
	private int likeCount;		//좋아요갯수
	private int disLikeCount;	//싫어요갯수
	
	public int getFbReplyNum() {
		return fbReplyNum;
	}
	public void setFbReplyNum(int fbReplyNum) {
		this.fbReplyNum = fbReplyNum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCrewId() {
		return crewId;
	}
	public void setCrewId(String crewId) {
		this.crewId = crewId;
	}
	public String getCrewName() {
		return crewName;
	}
	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public int getFbNum() {
		return fbNum;
	}
	public void setFbNum(int fbNum) {
		this.fbNum = fbNum;
	}
	public int getAnswerCount() {
		return answerCount;
	}
	public void setAnswerCount(int answerCount) {
		this.answerCount = answerCount;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public int getDisLikeCount() {
		return disLikeCount;
	}
	public void setDisLikeCount(int disLikeCount) {
		this.disLikeCount = disLikeCount;
	}
	
	

}
