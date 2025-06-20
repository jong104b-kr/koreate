package model;

import lombok.Data;

@Data
public class Member {

	private String id;
	private String passwd;
	private String name;
	private String phone;
	private String email;
	private String zipcode;
	private String addressNew;
	private String addressOld;
	private String addressDetail;
	private String addressRef;
	private String comment;
	private int level;
}
