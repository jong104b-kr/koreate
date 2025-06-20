package model;

import lombok.Data;

@Data
public class Item {

	private int itemCode;
	private String itemCategory;
	private String itemSubCategory;
	private String id;
	private String itemName;
	private int itemPrice;
	private int itemQuantity;
	private String itemOnSale;
	private String itemImage1;
	private String thumbNail;
}
