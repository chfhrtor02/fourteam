package com.fourteam.project.memberservice;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import com.fourteam.project.memberdao.MemberDAO;
import com.fourteam.project.membervo.MemberVO;
import com.fourteam.project.membervo.MemberVO.MemberVOBuilder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service//("")
public class MemberService implements IMemberService {
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@Autowired
	private TransactionTemplate transactionTemplate;
	
	@Transactional
	@Override
	public String insertMember(MemberVO member) {
		
		log.info("tx service insertMember");
		/*
		transactionTemlate.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {
				try {
					memberDAO.insert(member);
				}catch(Exception e){
					status.setRollbackOnly();
					log.error(" insertMember error ");
				}
				
			}
		}); //transactonTemlate.execute
		 */
		
		return transactionTemplate.execute(new TransactionCallback<String>() {
		
			@Override
			public String doInTransaction(TransactionStatus status) {
				String msg= "" ;
				try {
					msg=memberDAO.insert(member);
				}catch(Exception e){
					status.setRollbackOnly();
					log.error(" insertMember error ");
					msg="회원가입이 실패했습니다.";
				}
				return msg;
			}
			
		});
	}//insert
	
	@Transactional(readOnly=true)
	@Override
	public MemberVO getMember(String id) {
		log.info("tx service getMember ");
		
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status =transactionManager.getTransaction(def);
		
		MemberVO member = new MemberVO();
		try {
			member=	memberDAO.getMember(id);
			transactionManager.commit(status);
		}// try
		catch(Exception e){
			transactionManager.rollback(status);
			log.error(" getMember error ");
		}//catch
		return member;
	}//getMember
	
	@Transactional
	@Override
	public void updateMember(MemberVO member) {
	
		 transactionTemplate.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {
				try {
					memberDAO.update(member);
				}catch(Exception e){
					status.setRollbackOnly();
					log.error(" updateMember error ");
					log.error("회원수정이 실패했습니다.");
				}
				log.info( "회원수정이 실패했습니다 "); 
			}
		 });
	}//updateMember
	
	@Transactional
	@Override
	public void deleteMember(String id) {
		
		 transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					try {
						memberDAO.delete(id);
					}catch(Exception e){
						status.setRollbackOnly();
						log.error(" deleteMember error ");
						log.error("회원삭제 실패했습니다.");
					}
					log.info( "회원삭제 성공했습니다 "); 
				}
			 });

	}//deleteMember

	@Override
	public List<MemberVO> getAllMembers() {
		log.info("tx service getAllMember ");
		
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status =transactionManager.getTransaction(def);
		List<MemberVO> members= new ArrayList<>();
		
		try {
			members=memberDAO.getList();
			transactionManager.commit(status);
		}// try
		catch(Exception e){
			transactionManager.rollback(status);
			log.error(" getMember error ");
		}//catch
		return members;

	}//List<Member>

		// id가 존재하지 않는경우
		// id가 존재하나 pw가 불일치
		// 오류 메세지 [Id나 Pw가 일치하지 않습니다.]로 통일 
		// 오류메세지는 jsp에 스크립트로 작성 
		// id/pwd 일치


//	@Override
//	public List<MemberVO> getOneMembers() {
//		// TODO Auto-generated method stub
//		return null;
//	}

	@Override
	public boolean hasMember(String id) {
		//DAO hasMember의 result값을 호출
		MemberDAO dao = new MemberDAO();
		
		
		
		
		return false;
	}

	@Override
	public MemberVO getOneMember(MemberVO member) {
		log.info("tx service getOneMember ");
		
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status =transactionManager.getTransaction(def);
		
		
		try {
			member=memberDAO.getMember(member);
//			member=MemberVO.builder().member_id(member.getMember_id())
//									 .member_pwd(member.getMember_pwd())
//									 .member_email(member.getMember_email())
//									 .build();
//			
			transactionManager.commit(status);
		}// try
		catch(Exception e){
			transactionManager.rollback(status);
			log.error(" getMember error ");
		}//catch
		
		return member;
	}
	
	@Override
	public boolean isMember(String field, String value) {
		log.info("isMember");
		
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status =transactionManager.getTransaction(def);
		boolean flag = false;
		try {
			flag=memberDAO.isMember(field, value);
			transactionManager.commit(status);
		}// try
		catch(Exception e){
			transactionManager.rollback(status);
			log.error(" isMember error ");
		}//catch
		return flag;
	}

	@Override
	public boolean isPhone(String field,String memberPhone) {
		log.info("isMemberPhone");
		
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status =transactionManager.getTransaction(def);
		boolean phoneCheck= false;
		try {
			phoneCheck=memberDAO.isMember(field, memberPhone);
			transactionManager.commit(status);
		}//try
		catch (Exception e) {
			transactionManager.rollback(status);
			log.error(" isPhone error ");
		}
		return phoneCheck;
	}

	
}
