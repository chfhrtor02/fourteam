package com.fourteam.project.membervo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
	/*아이디*/
	private String member_id ;
	/*비밀번호*/
	private String member_pwd;
	/*이름*/
	private String member_name;
	/*성별*/
	private String member_gender;
	/*이메일*/
	private String member_email;
	/*휴대폰번호*/
	private String member_phone;
	/*우편번호*/
	private String member_addrn;
	/*주소*/
	private String member_addr1;
	/*상세주소*/
	private String member_addr2;
	/*생일*/
	private String member_birthday;
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pwd() {
		return member_pwd;
	}
	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public String getMember_addrn() {
		return member_addrn;
	}
	public void setMember_addrn(String member_addrn) {
		this.member_addrn = member_addrn;
	}
	public String getMember_addr1() {
		return member_addr1;
	}
	public void setMember_addr1(String member_addr1) {
		this.member_addr1 = member_addr1;
	}
	public String getMember_addr2() {
		return member_addr2;
	}
	public void setMember_addr2(String member_addr2) {
		this.member_addr2 = member_addr2;
	}
	public String getMember_birthday() {
		return member_birthday;
	}
	public void setMember_birthday(String member_birthday) {
		this.member_birthday = member_birthday;
	}
	@Override
	public String toString() {
		return "MemberVO [member_id=" + member_id + ", member_pwd=" + member_pwd + ", member_name=" + member_name
				+ ", member_gender=" + member_gender + ", member_email=" + member_email + ", member_phone="
				+ member_phone + ", member_addrn=" + member_addrn + ", member_addr1=" + member_addr1 + ", member_addr2="
				+ member_addr2 + ", member_birthday=" + member_birthday + "]";
	}
}
