package board;

public class Page {
	int startNo, endNo;
	int listSize=10, blockSize=5, totSize;
	int startPage, endPage, totPage;
	int nowPage=1;
	String findStr="";//nullpointexception떨어지지않기 위해 공백값 집어넣기
	
	public Page() {
		pageCompute();
	}
	public Page(int tot, int now) {
		this.totSize = tot;
		this.nowPage = now;
		pageCompute();
	}
	
	public void pageCompute() {
		totPage = (int)Math.ceil(totSize/(double)listSize);
		endNo = nowPage * listSize;
		startNo = endNo - listSize +1; //startNo 설정 순서 중요 endNo보정보다 먼저 설정해야함
		if(endNo>totSize) endNo = totSize;
		
		endPage = (int)Math.ceil(nowPage/(double)blockSize) * blockSize;
		startPage = endPage - blockSize +1;
		if(endPage>totPage) endPage = totPage;
		
	}
	
	public String getFindStr() {return findStr;}
	public void setFindStr(String findStr) {this.findStr = findStr;}
	public int getStartNo() {return startNo;}
	public void setStartNo(int startNo) {this.startNo = startNo;}
	public int getEndNo() {return endNo;}
	public void setEndNo(int endNo) {this.endNo = endNo;}
	public int getListSize() {return listSize;}
	public void setListSize(int listSize) {this.listSize = listSize;}
	public int getBlockSize() {return blockSize;}
	public void setBlockSize(int blockSize) {this.blockSize = blockSize;}
	public int getTotSize() {return totSize;}
	public void setTotSize(int totSize) {this.totSize = totSize;}
	public int getStartPage() {return startPage;}
	public void setStartPage(int startPage) {this.startPage = startPage;}
	public int getEndPage() {return endPage;}
	public void setEndPage(int endPage) {this.endPage = endPage;}
	public int getTotPage() {return totPage;}
	public void setTotPage(int totPage) {this.totPage = totPage;}
	public int getNowPage() {return nowPage;}
	public void setNowPage(int nowPage) {this.nowPage = nowPage;}

}
