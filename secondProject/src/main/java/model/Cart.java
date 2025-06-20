package model;

import lombok.Data;

@Data
public class Cart {

	private int cartNo;
	private String orderCode;
	private String id;
	private String itemCode;
	private int itemPrice;
	private int itemQuantity;
	private String cartStatus;
	private String cartSignDate;
	private String itemImage1; // item 테이블 첨부이미지
}
