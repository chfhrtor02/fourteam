package com.fourteam.project.memberdao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fourteam.project.membervo.MemberVO;
import com.zaxxer.hikari.HikariDataSource;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberDAO {

	@Autowired
	HikariDataSource dataSource;
	
	// 데이터베이스 insert 로직
	public String insert(MemberVO data)
	{
		String result="";
		String sql = "insert into member values (?,?,?,?,?,?,?,?,?,?)";
	
		try(Connection conn =dataSource.getConnection();
			PreparedStatement ppst = conn.prepareStatement(sql);){
			
			//매개변수로 전달된 데이터를 쿼리문 매핑
			ppst.setString(1, data.getMember_id());
			ppst.setString(2, data.getMember_pwd());
			ppst.setString(3, data.getMember_name());
			ppst.setString(4, data.getMember_gender());
			ppst.setString(5, data.getMember_email());
			ppst.setString(6, data.getMember_phone());
			ppst.setString(7, data.getMember_addrn());
			ppst.setString(8, data.getMember_addr1());
			ppst.setString(9, data.getMember_addr2());
			ppst.setString(10, data.getMember_birthday());
			//쿼리 수행
			if(ppst.executeUpdate()==1) {
				log.info("회원가입에 성공하셨습니다");
				result="회원가입에 성공하셨습니다";
			}//if
			else {
				log.error("회원가입 실패 하셨습니다");
			}
		}//try
		catch(Exception e) {
			log.error("insert 에러");
			result="회원가입 실패 하셨습니다";
			e.printStackTrace();
		}
		
		return result;
		
	}//public insert
	
	public List<MemberVO> getList(){
		List<MemberVO> list =new ArrayList<>(); //List 객체 생성
		String sql ="select * from member";
		try(Connection conn = dataSource.getConnection();
			PreparedStatement ppst = conn.prepareStatement(sql);
			ResultSet rs =ppst.executeQuery();	){
			
			while(rs.next()) {
				
				//반복문이 수행 될 때마다 MemberVO 생성
				MemberVO data =new MemberVO();				
				data.setMember_id(rs.getString("member_id"));
				data.setMember_pwd(rs.getString("member_pwd"));
				data.setMember_name(rs.getString("member_name"));
				data.setMember_gender(rs.getString("member_gender"));
				data.setMember_email(rs.getString("member_email"));
				data.setMember_phone(rs.getString("member_phone"));
				data.setMember_addrn(rs.getString("member_addrn"));
				data.setMember_addr1(rs.getString("member_addr1"));
				data.setMember_addr2(rs.getString("member_addr2"));
				data.setMember_birthday(rs.getString("member_birthday"));
				list.add(data);
					
			}//while
		
		}//try 
		catch(Exception e) {
			log.error("getList 예외발생");
			e.printStackTrace();
		}// catch
		
		return list;
	}//List
	
	public  void update(MemberVO data) {
		String sql =   "update into set member_id= ?"
					 + "member_pwd =  ? "
					 + "member_name = ? "
					 + "member_gender = ? "
					 + "member_email = ?  "
					 + "member_phone = ?  "
					 + "member_addrn = ?  "
					 + "member_addr1 = ?  "
					 + "member_addr2 = ?  "
					 + "member_birthday = ? ";
		try(Connection conn = dataSource.getConnection();
				PreparedStatement ppst = conn.prepareStatement(sql);){
				data.setMember_id("member_id");
				data.setMember_pwd("member_pwd");
				data.setMember_name("member_name");
				data.setMember_gender("member_gender");
				data.setMember_email("member_email");
				data.setMember_phone("member_phone");
				data.setMember_addrn("member_addrn");
				data.setMember_addr1("member_addr1");
				data.setMember_addr2("member_addr2");
				data.setMember_birthday("member_birthday");
				ppst.executeUpdate();
		}//try
		catch(Exception e) {
			e.printStackTrace();
		}//catch
		
		
		
	}//update
	
	public void delete(String id) {
		String sql =   "delete from member where = ?";
		try { Connection conn = dataSource.getConnection();
		PreparedStatement ppst = conn.prepareStatement(sql);
		ppst.setString(1, id);
		//쿼리 수행
		if(ppst.executeUpdate()==1) {
			log.info("회원삭제 성공하셨습니다");
		}//if
		else {
			log.error("회원삭제 실패 하셨습니다");
		}	
		}//try
		catch(Exception e) {
			e.printStackTrace();
		}//catch
	}
	
	public MemberVO getMember(String id){
		MemberVO data =new MemberVO();
		String sql ="select * from member where member_id = '"+id+"'";
		try(Connection conn = dataSource.getConnection();
			PreparedStatement ppst = conn.prepareStatement(sql);
			ResultSet rs =ppst.executeQuery();	){
			
			if(rs.next()) {
				
				//반복문이 수행 될 때마다 MemberVO 생성
						
				data.setMember_id(rs.getString("member_id"));
				data.setMember_pwd(rs.getString("member_pwd"));
				data.setMember_name(rs.getString("member_name"));
				data.setMember_gender(rs.getString("member_gender"));
				data.setMember_email(rs.getString("member_email"));
				data.setMember_phone(rs.getString("member_phone"));
				data.setMember_addrn(rs.getString("member_addrn"));
				data.setMember_addr1(rs.getString("member_addr1"));
				data.setMember_addr2(rs.getString("member_addr2"));
				data.setMember_birthday(rs.getString("member_birthday"));
				
			}//if
		
		}//try 
		catch(Exception e) {
			log.error("getList 예외발생");
			e.printStackTrace();
		}// catch
		
		return data;
	}//List
	

//	public String getOneMembers() {
//		String sql = "select * from member where member_id";
//		
//		Connection conn = dataSource.getConnection();
//		PreparedStatement ppst = conn.prepareStatement(sql);
//		ResultSet rs =ppst.executeQuery();
//		
//		MemberVO data =new MemberVO();				
//		data.setMember_id(rs.getString("member_id"));
//	}
	/**
	 * 회원정보조회
	 * ex) id로 검색시
	 * ex) id+pwd로 검색시
	 * ex) id+email 검색시
	 * ex) pwd+email/ 
	 * 
	 * @param memberVO
	 * @return
	 */
	public MemberVO getMember(MemberVO memberVO){
		MemberVO data =new MemberVO();
		String sql ="select * from member where ";
		String subSql = "member_id = '"+memberVO.getMember_id()+"' "; // 1record
		
		if(memberVO.getMember_id()!=null && memberVO.getMember_email()!=null) { //1record
		
			subSql += "and member_email = '"+memberVO.getMember_email()+"' ";		
		} 
		else if (memberVO.getMember_id()!=null && memberVO.getMember_pwd()!=null) { //1record
			
			subSql += "and member_pwd = '"+memberVO.getMember_pwd()+"' ";
		} 
		else if (memberVO.getMember_pwd()!=null && memberVO.getMember_email()!=null) { // 1record
			
			subSql =  "member_pwd = '"+memberVO.getMember_pwd()+"' "
					+ "and member_email = '"+memberVO.getMember_email()+"'";
		} 
		
		sql += subSql;

		
		try(Connection conn = dataSource.getConnection();
			PreparedStatement ppst = conn.prepareStatement(sql);
			ResultSet rs =ppst.executeQuery();	){
			
			if(rs.next()) {
				
				//반복문이 수행 될 때마다 MemberVO 생성
						
				data.setMember_id(rs.getString("member_id"));
				data.setMember_pwd(rs.getString("member_pwd"));
				data.setMember_name(rs.getString("member_name"));
				data.setMember_gender(rs.getString("member_gender"));
				data.setMember_email(rs.getString("member_email"));
				data.setMember_phone(rs.getString("member_phone"));
				data.setMember_addrn(rs.getString("member_addrn"));
				data.setMember_addr1(rs.getString("member_addr1"));
				data.setMember_addr2(rs.getString("member_addr2"));
				data.setMember_birthday(rs.getString("member_birthday"));
				
			}//if
		
		}//try 
		catch(Exception e) {
			log.error("getList 예외발생");
			e.printStackTrace();
		}// catch
		
		return data;
	}//
	
	
	public boolean hasMember(String id){
		boolean result = false;
		String sql ="select count(*) from member where member_id = '"+id+"'";
		try(Connection conn = dataSource.getConnection();
			PreparedStatement ppst = conn.prepareStatement(sql);
			ResultSet rs =ppst.executeQuery();	){
			
			if(rs.next()) {
				
				if(rs.getInt(1)==1){
					result = true;
				}
				
			}//if
		
		}//try 
		catch(Exception e) {
			log.error("result 예외발생");
			e.printStackTrace();
		}// catch
		
		return result;
	}//List
	
	public boolean isMember(String field, String value){
		boolean flag = false;
		String sql ="select count(*) from member where "+field+" = '"+value+"'";
		try(Connection conn = dataSource.getConnection();
			PreparedStatement ppst = conn.prepareStatement(sql);
			ResultSet rs =ppst.executeQuery();	){
			
			if(rs.next()) {
				flag = rs.getInt(1)==1 ? true : false;
			}//if
		
		}//try 
		catch(Exception e) {
			log.error("isMember 예외발생");
			e.printStackTrace();
		}// catch
		
		return flag;
	}//
	
	
}
