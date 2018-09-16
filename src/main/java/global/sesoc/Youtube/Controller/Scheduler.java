package global.sesoc.Youtube.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import global.sesoc.Youtube.dao.MemberRepository;

@EnableScheduling
@Controller
public class Scheduler {
	@Autowired
	MemberRepository mRepository;
	/**
	 * 매년 매월 매일 자정(0시 0분 1초)에 한 번씩 수행하는 메소드
	 */
	@Scheduled(cron = "0 0 0 * * *")
	public void idCompletelyDelete() {
		//System.out.println("자정 : 아이디 삭제 실행");
		mRepository.idCompletelyDeleteFromMember();
		mRepository.idCompletelyDeleteFromConfirmmeber();
	}
}
