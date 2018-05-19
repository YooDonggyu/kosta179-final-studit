package org.kosta.studit.model.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring-model.xml" })
public class RecruitServiceTest {
	@Autowired
	private RecruitService recruitService;

	@Test
	public void registerRecruiteTest() {
		recruitService.registerRecruitStudy(2, "j@k.com", "자기소개냐??");
	}

	/**
	 * 전체 모집글 목록 확인 TEST.
	 * 
	 * @author 김유란
	 */
	@Test
	public void getRecruitPostList() {
		List<RecruitPostVO> list = recruitService.getRecruitPostList("1").getRecruitPostList();
		for (RecruitPostVO vo : list) {
			System.out.println(vo);
		}
	}

	/**
	 * 검색된 모집글 목록 가져오기 확인 TEST.
	 * 
	 * @author 김유란
	 */
	@Test
	public void findRecruitPostByCategoryAndKeyword() {
		String category[] = { "1", "2", "3" };
		List<RecruitPostVO> list = recruitService.findRecruitPostByCategoryAndKeyword(null, "강남", "1")
				.getRecruitPostList();
		for (RecruitPostVO vo : list) {
			System.out.println(vo);
		}
	}
}
