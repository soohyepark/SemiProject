package bean;

import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;

public class AES {
	String iv;
	Key keySpec;
	final static String key = "abcdefghijklmnoq";

	public AES() {
		try {
			iv = key.substring(0,16);
			byte[] keyBytes = new byte[16];
			byte[] b = key.getBytes("utf-8");
			int len = b.length;
			if(len> keyBytes.length) len = keyBytes.length;
			
			System.arraycopy(b, 0, keyBytes, 0, len);
			SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
			this.keySpec = keySpec;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public String encrypt(String str) {
		String enStr="";
		try {
			Cipher c= Cipher.getInstance("AES/CBC/PKCS5Padding");
			c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
			byte[] encrypted = c.doFinal(str.getBytes("utf-8"));
			enStr = new String(Base64.encodeBase64(encrypted));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return enStr;
	}
	
	public String decrypt(String str) {
		String rStr = null;
		Cipher c = null;
		byte[] byteStr = null;
		try {
			c = Cipher.getInstance("AES/CBC/PKCS5Padding");
			c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
			byteStr = Base64.decodeBase64(str.getBytes());
			
			rStr = new String(c.doFinal(byteStr),"utf-8");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return rStr;
				
	}
	public static void main(String[] args) {
		AES aes = new AES();
		String msg = "박수혜";
		String rMsg = aes.encrypt(msg);
		System.out.println(msg);
		System.out.println(rMsg);
		String decStr = aes.decrypt(rMsg);
		System.out.println(decStr);

	}

}
