package global.sesoc.Youtube.Controller;

import java.io.FileInputStream;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.Youtube.dao.DubbingRepository;
import global.sesoc.Youtube.dao.EducationRepository;
import global.sesoc.Youtube.dto.Dubbing;
import global.sesoc.Youtube.dto.Education;
import global.sesoc.Youtube.dto.Reply;
import global.sesoc.Youtube.util.EasySubtitlesMaker;
import global.sesoc.Youtube.util.FileService;

@Controller
public class DubbingController {
	@Autowired
	EducationRepository eduRepository;

	@Autowired
	DubbingRepository dubRepository;

	private final String DubbingFileRoot = "/YoutubeEduCenter/EducationDubbing";
	private final String eduFileRoot = "/YoutubeEduCenter/EducationVideo";

	// 더빙겟
	@RequestMapping(value = "/dubbingBoard", method = RequestMethod.GET)
	public String dubbingBoard(HttpSession session, Model model) {
		List<Dubbing> dubbing = dubRepository.dubbingBoard();
		model.addAttribute("dubbing", dubbing);
		
		return "DubbingBoard/dubbingBoard";
	}

	@RequestMapping(value = "VideoSearch", method = RequestMethod.GET)
	public String VideoSearch() {
		return "DubbingBoard/VideoSearch";
	}

	// 더빙 디테일
	@RequestMapping(value = "dubDetail", method = RequestMethod.GET)
	public String dubDetail(int dubbingnum, Model model) {
		Dubbing dubbing = dubRepository.selectOneDub(dubbingnum);
		String savedfileName = eduRepository.selectSubName2(dubbing.getUrl());
		model.addAttribute("dubbing", dubbing);
		model.addAttribute("savedfileName", savedfileName);

		return "DubbingBoard/dubDetail";
	}

	@RequestMapping(value = "DubbingWrite", method = RequestMethod.GET)
	public String DubbingWrite(Model model, Integer videoNum, String url) {
		System.out.println(videoNum + "," + url);
		Education edu = null;
		if (videoNum != null) {
			edu = eduRepository.selectOneFromEduVideo(videoNum);
		} else {
			edu = new Education();
			edu.setUrl(url);
		}
		model.addAttribute("edu", edu);
		
		return "DubbingBoard/dubbingWrite";
	}

	@RequestMapping(value = "getSubtitles", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, String> getSubtitles(String subFileName) {
		String jamacURL = eduFileRoot + "/" + subFileName;
		EasySubtitlesMaker esm = new EasySubtitlesMaker();
		Map<String, String> result = esm.GetSubtitles(jamacURL);
		if (result.isEmpty())
			return null;
		else
			return result;
	}

	@RequestMapping(value = "savedubbing", method = RequestMethod.POST)
	public String savedubbing(Dubbing dub, MultipartFile saveFile) {
		if (saveFile.getSize() != 0) {
			String[] timeIfo = saveFile.getOriginalFilename().substring(0, saveFile.getOriginalFilename().length() - 4)
					.split("-");
			dub.setStarttime(timeIfo[0]);
			dub.setEndtime(timeIfo[1]);
			String savedfile = FileService.saveFile(saveFile, DubbingFileRoot);
			dub.setVoiceFile(savedfile);
			dubRepository.insertDubbing(dub);
		}
		
		return "redirect:dubbingBoard";
	}

	@RequestMapping(value = "getDubbingSoundFile", method = RequestMethod.GET)
	public String getDubbingSoundFile(String voiceFile, HttpServletResponse response) {
		String fullPath = DubbingFileRoot + "/" + voiceFile;
		FileInputStream fis = null;
		ServletOutputStream fout = null;

		try {
			fout = response.getOutputStream();
			fis = new FileInputStream(fullPath);
			FileCopyUtils.copy(fis, fout);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (fis != null)
					fis.close();
				if (fout != null)
					fout.close();
			} catch (Exception e) {

			}
		}
		return null;
	}
  
  @RequestMapping(value = "deleteDubbing", method = RequestMethod.POST)
	public String deleteDubbing(Dubbing dub) {
		dubRepository.deleteDubbing(dub);
		
		return "redirect:dubbingBoard";
	}
  
	@RequestMapping(value="/replyAll", method=RequestMethod.POST)
	public @ResponseBody List<Reply> replyAll(int dubbingnum) {
		//System.out.println(dubbingnum);
		List<Reply> replyList = dubRepository.replyAll(dubbingnum);
		return replyList;
	}
			
	@RequestMapping(value="/replyInsert", method=RequestMethod.POST)
	public @ResponseBody Integer replyInsert(@RequestBody Reply reply ) {
		int result = dubRepository.insertReply(reply);
		return result;
	}
			
	@RequestMapping(value="/replyDelete", method=RequestMethod.GET)
	public @ResponseBody Integer replyDelete(int replynum) {
		int result = dubRepository.replyDelete(replynum);
		return result;
	}
			
	@RequestMapping(value="/replyUpdate", method=RequestMethod.POST)
	public @ResponseBody Integer replyUpdate(@RequestBody Reply reply) {
		int result = dubRepository.replyUpdate(reply);
		return result;
	}
}
