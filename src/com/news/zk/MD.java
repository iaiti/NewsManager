package com.news.zk;

import java.security.MessageDigest;  
import java.security.NoSuchAlgorithmException;  

import sun.misc.BASE64Encoder;
  
public class MD {  
      
//	public String encrypMD5(String str) {
//		   try{
//	        // 根据MD5算法生成MessageDigest对象
//	        MessageDigest md5 = MessageDigest.getInstance("MD5");
//	        byte[] bytes = str.getBytes();
//	        // 使用bytes更新摘要
//	        md5.update(bytes);
//	        // 完成哈希运算，生成不可解密的密文
//	        byte[] result = md5.digest();
//	        //用base64再次加密
//	        BASE64Encoder encoder = new BASE64Encoder();
//	        String str_ = encoder.encode(result);
//	        return str_;
//		   }catch(Exception e){
//			   return "111";
//		   }
//	}

public String toMd5(String sourceStr) {
	try {
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(sourceStr.getBytes());
		byte b[] = md.digest();
		int i;
		StringBuffer buf = new StringBuffer("");
		for (int offset = 0; offset < b.length; offset++) {
			i = b[offset];
			if (i < 0)
				i += 256;
			if (i < 16)
				buf.append("0");
			buf.append(Integer.toHexString(i));
		}

		// return buf.toString().substring(8, 24); //16
		return buf.toString(); // 32

	} catch (Exception e) {
		return "sourceStr can't get MD5";
	}
}

//public byte[] eccrypt(String info) throws NoSuchAlgorithmException{  
//    //根据MD5算法生成MessageDigest对象  
//    MessageDigest md5 = MessageDigest.getInstance("MD5");  
//    byte[] srcBytes = info.getBytes();  
//    //使用srcBytes更新摘要  
//    md5.update(srcBytes);  
//    //完成哈希计算，得到result  
//    byte[] resultBytes = md5.digest();  
//    return resultBytes;  
//}  
//    public static void main(String args[]) throws NoSuchAlgorithmException{  
//        String msg = "admin";  
//        MD md5 = new MD();  
//        byte[] resultBytes = md5.encode(msg);  
//        //SHOW VARIABLES LIKE 'character_set%';
//        System.out.println("密文是：" + new String(resultBytes));  
//       // System.out.println("明文是：" + msg);  
//    }  
	
}  