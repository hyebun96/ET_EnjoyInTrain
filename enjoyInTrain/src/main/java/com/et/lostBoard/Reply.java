package com.et.lostBoard;

public class Reply {
	private int lostNum;
	private int lostReplyNum;
	private int num;
	private String crewId;
	private String userName;
	private String content;
	private String created;
	private int answer;
	private int answerCount;

	
	public int getLostNum() {
		return lostNum;
	}

	public void setLostNum(int lostNum) {
		this.lostNum = lostNum;
	}

	public int getLostReplyNum() {
		return lostReplyNum;
	}

	public void setLostReplyNum(int lostReplyNum) {
		this.lostReplyNum = lostReplyNum;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	public int getAnswer() {
		return answer;
	}

	public void setAnswer(int answer) {
		this.answer = answer;
	}

	public int getAnswerCount() {
		return answerCount;
	}

	public void setAnswerCount(int answerCount) {
		this.answerCount = answerCount;
	}
}
