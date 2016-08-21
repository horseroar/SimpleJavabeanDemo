package cn.javabean.demo.model;

public class Employee {
	private String empCode;// 员工编码
	private String name; // 员工姓名
	private String departMent;// 部门名称
	private byte sex;// 性别
	private String cardNo;// 卡号

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getDepartMent() {
		return departMent;
	}

	public void setDepartMent(String departMent) {
		this.departMent = departMent;
	}

	public byte getSex() {
		return sex;
	}

	public void setSex(byte sex) {
		this.sex = sex;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
