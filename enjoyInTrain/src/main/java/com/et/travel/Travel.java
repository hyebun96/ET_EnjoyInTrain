package com.et.travel;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Travel {
	private int categoryNum;		// 카테고리 번호 (여행지종류)
	
	private String pmCode;			// 프로모션 코드 
	
	private int partnerCode;		// 협력업체 번호 
	private String partnerName;		
	private String partnerTel;
	
	// 가는기차
	private String startStation;	// 출발하는 역 
	private String endStation;		// 도착하는 역 
	
	// 오는 기차
	private String startStation2;	// 출발하는 역 
	private String endStation2;		// 도착하는 역 
	
	private String[] startCode;		// 출발하는 기차  
	private String stCode;
	private String[] endCode;		// 돌아오는 기차 
	private String edCode;
	
	private String pmStartDate;		// 프로모션 예약 가능 시작 날짜 
	private String pmEndDate;		// 프로모션 예약 가능 종료 날짜 
	
	private String pmTitle;			// 프로모션 제목 
	private int pmPrice;			// 프로모션 가격
	private int pmMaxCount;			// 프로모션 최대 인원
	private int pmPercent;			// 협력업체 상환 비율 
	
	private String product;			// 프로모션 상품
	private String productContent;	// 프로모션 상품 설명
	
	private MultipartFile upload;
	private String saveFileName;
	
	private List<MultipartFile> uploadContent;
	
	private int stPrice;
	private int price;
	private int edPrice;
	
	private int stock;
	
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	public String getPmCode() {
		return pmCode;
	}
	public void setPmCode(String pmCode) {
		this.pmCode = pmCode;
	}
	public int getPartnerCode() {
		return partnerCode;
	}
	public void setPartnerCode(int partnerCode) {
		this.partnerCode = partnerCode;
	}
	public String getStartStation() {
		return startStation;
	}
	public void setStartStation(String startStation) {
		this.startStation = startStation;
	}
	public String getEndStation() {
		return endStation;
	}
	public void setEndStation(String endStation) {
		this.endStation = endStation;
	}
	public String getStartStation2() {
		return startStation2;
	}
	public void setStartStation2(String startStation2) {
		this.startStation2 = startStation2;
	}
	public String getEndStation2() {
		return endStation2;
	}
	public void setEndStation2(String endStation2) {
		this.endStation2 = endStation2;
	}
	public String[] getStartCode() {
		return startCode;
	}
	public void setStartCode(String[] startCode) {
		this.startCode = startCode;
	}
	public String getStCode() {
		return stCode;
	}
	public void setStCode(String stCode) {
		this.stCode = stCode;
	}
	public String[] getEndCode() {
		return endCode;
	}
	public void setEndCode(String[] endCode) {
		this.endCode = endCode;
	}
	public String getEdCode() {
		return edCode;
	}
	public void setEdCode(String edCode) {
		this.edCode = edCode;
	}
	public String getPmStartDate() {
		return pmStartDate;
	}
	public void setPmStartDate(String pmStartDate) {
		this.pmStartDate = pmStartDate;
	}
	public String getPmEndDate() {
		return pmEndDate;
	}
	public void setPmEndDate(String pmEndDate) {
		this.pmEndDate = pmEndDate;
	}
	public String getPmTitle() {
		return pmTitle;
	}
	public void setPmTitle(String pmTitle) {
		this.pmTitle = pmTitle;
	}
	public int getPmPrice() {
		return pmPrice;
	}
	public void setPmPrice(int pmPrice) {
		this.pmPrice = pmPrice;
	}
	public int getPmMaxCount() {
		return pmMaxCount;
	}
	public void setPmMaxCount(int pmMaxCount) {
		this.pmMaxCount = pmMaxCount;
	}
	public int getPmPercent() {
		return pmPercent;
	}
	public void setPmPercent(int pmPercent) {
		this.pmPercent = pmPercent;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getProductContent() {
		return productContent;
	}
	public void setProductContent(String productContent) {
		this.productContent = productContent;
	}
	public String getPartnerName() {
		return partnerName;
	}
	public void setPartnerName(String partnerName) {
		this.partnerName = partnerName;
	}
	public String getPartnerTel() {
		return partnerTel;
	}
	public void setPartnerTel(String partnerTel) {
		this.partnerTel = partnerTel;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public List<MultipartFile> getUploadContent() {
		return uploadContent;
	}
	public void setUploadContent(List<MultipartFile> uploadContent) {
		this.uploadContent = uploadContent;
	}
	public int getStPrice() {
		return stPrice;
	}
	public void setStPrice(int stPrice) {
		this.stPrice = stPrice;
	}
	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getEdPrice() {
		return edPrice;
	}
	public void setEdPrice(int edPrice) {
		this.edPrice = edPrice;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	
	
}
