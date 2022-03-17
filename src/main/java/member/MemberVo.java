package member;

public class MemberVo {
	String mid;
	String irum;
	String pwd;
	String phone;
	String zip;
	String address;
	String address2;
	String photo;
	String delFile;//수정시 이전 이미지 파일명
	
	public String getMid() {return mid;}
	public void setMid(String mid) {this.mid = mid;}
	public String getIrum() {return irum;}
	public void setIrum(String irum) {this.irum = irum;}
	public String getPwd() {return pwd;}
	public void setPwd(String pwd) {this.pwd = pwd;}
	public String getPhone() {return phone;}
	public void setPhone(String phone) {this.phone = phone;}
	public String getZip() {return zip;}
	public void setZip(String zip) {this.zip = zip;}
	public String getAddress() {return address;}
	public void setAddress(String address) {this.address = address;}
	public String getAddress2() {return address2;}
	public void setAddress2(String address2) {this.address2 = address2;}
	public String getPhoto() {return photo;}
	public void setPhoto(String photo) {this.photo = photo;}
	public String getDelFile() {return delFile;}
	public void setDelFile(String delFile) {this.delFile = delFile;}
	
}
