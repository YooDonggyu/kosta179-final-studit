package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GroupDAOImpl implements GroupDAO {
	@Autowired
	   private SqlSessionTemplate template;
	   
	   /**
	    * 본인이 팀장인 스터디 그룹의 개수 조회
	    * @author 송용준
	    * @param memberEmail 회원 이메일
	    * @return int 본인이 팀장인 스터디 그룹의 개수
	    */
	   @Override
	   public int findMyLeadStudyGroupCountByEmail(String memberEmail) {
	      return template.selectOne("group.findMyLeadStudyGroupCountByEmail", memberEmail);
	      
	   }
	   
	   /**
	    * 본인이 팀장인 스터디 그룹 중 팀원이 있는 그룹 조회
	    * @author 송용준
	    * @param memberEmail 회원 이메일
	    * @return Map<String, Object> 스터디 그룹 정보. Key : 스터디 그룹 넘버, 그룹 이름
	    */
	   @Override
	   public List<Map<String, Object>> findMyLeadGroupHasMemberByEmail(String memberEmail) {
	      return template.selectList("group.findMyLeadGroupHasMemberByEmail", memberEmail);
	   }
}
