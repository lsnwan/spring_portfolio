package com.hyeontae.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class FindMail {

	
	public void sendMail(String userEmail, String newPassword ) throws Exception {
		
		MailInfo mail = new MailInfo();

		String host = "smtp.naver.com"; 
		final String username = mail.getUsername(); 
		final String password = mail.getPassword();
		int port=465; // 메일 내용 
		
		String recipient = userEmail; 
		
		String subject = "[조현태 포트폴리오]요청하신 임시 비밀번호 입니다."; 
		String body = "아래 임시 비밀번호로 로그인하여 비밀번호를 변경해 주세요\n\n"
				+ "비밀번호: " + newPassword; 
		
		Properties props = System.getProperties(); 
		
		props.put("mail.smtp.host", host); 
		props.put("mail.smtp.port", port); 
		props.put("mail.smtp.auth", "true"); 
		props.put("mail.smtp.ssl.enable", "true"); 
		props.put("mail.smtp.ssl.trust", host); 
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un=username; 
			String pw=password; 
			protected PasswordAuthentication getPasswordAuthentication() { 
				return new PasswordAuthentication(un, pw); 
			} 
		}); 
		
		session.setDebug(true); //for debug 
		
		Message mimeMessage = new MimeMessage(session); 
		mimeMessage.setFrom(new InternetAddress("progsin@naver.com")); 
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); 
		mimeMessage.setSubject(subject); 
		mimeMessage.setText(body); 
		
		Transport.send(mimeMessage);
		
	}
}
