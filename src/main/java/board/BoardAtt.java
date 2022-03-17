package board;

public class BoardAtt {
	int serial;
	int grp; //PK로 연결된 board의 serial 번호
	String attFile;
	
	public int getSerial() {return serial;}
	public void setSerial(int serial) {this.serial = serial;}
	public int getGrp() {return grp;}
	public void setGrp(int grp) {this.grp = grp;}
	public String getAttFile() {return attFile;}
	public void setAttFile(String attFile) {this.attFile = attFile;}
	
}
