package kr.co.mlec.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SecurityCryptograph {
	public static final String encodingMD5(final String text) {
	     try {
	         // Create MD5 Hash
	         MessageDigest digest = java.security.MessageDigest
	                 .getInstance("MD5");
	         digest.update(text.getBytes());
	         byte messageDigest[] = digest.digest();
	  
	         // Create Hex String
	         StringBuffer hexString = new StringBuffer();
	         for (int i = 0; i < messageDigest.length; i++) {
	             String h = Integer.toHexString(0xFF & messageDigest[i]);
	             while (h.length() < 2)
	                 h = "0" + h;
	             hexString.append(h);
	         }
	         return hexString.toString();
	  
	     } catch (NoSuchAlgorithmException e) {
	         e.printStackTrace();
	     }
	     return "";
	 }
}
