package global.sesoc.Youtube.Controller;


import java.io.FileInputStream;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.Youtube.dao.DubbingRepository;
import global.sesoc.Youtube.dao.EducationRepository;
import global.sesoc.Youtube.dto.Dubbing;
import global.sesoc.Youtube.dto.Education;
import global.sesoc.Youtube.util.EasySubtitlesMaker;
import global.sesoc.Youtube.util.FileService;


@Controller
public class DubbingController {
	
	@Autowired
	EducationRepository eduRepository;
	@Autowired
	DubbingRepository dubRepository;
	
	private final String eduFileRoot = "/EducationDubbing";
	
	@RequestMapping(value="DubbingWrite",method=RequestMethod.GET)
	public String DubbingWrite(Model model,int videoNum) {
		Education edu = eduRepository.selectOneFromEduVideo(videoNum);
		model.addAttribute("edu",edu);
		return"dubbing/dubbingView";
	}
	
	
	@RequestMapping(value="getSubtitles",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,String> getSubtitles(Dubbing dub){
		String jamacURL = eduFileRoot + "/" + dub.getVoiceFile();
		EasySubtitlesMaker esm=new EasySubtitlesMaker();
		Map<String,String>result=esm.GetSubtitles(jamacURL);
		return result;
		
	}
	
	@RequestMapping(value="savedubbing",method=RequestMethod.POST)
	public String savedubbing(Dubbing dub, MultipartFile saveFile) {
		if(saveFile.getSize()!=0) {
			String savedfile = FileService.saveFile(saveFile, eduFileRoot);
			dub.setVoiceFile(savedfile);
		}
		dubRepository.insertDubbing(dub);
		return "redirect:/";
	}
	
	@RequestMapping(value = "getDubbingSoundFile", method = RequestMethod.GET)
	public String imagedownload(int dubbingnum, HttpServletResponse response) {
		
		System.out.println(dubbingnum);
		String fileName="testsoundfile(full).mp3";
		String fullPath = eduFileRoot + "/" + fileName;

		FileInputStream fis = null;
		ServletOutputStream fout = null;

		try {
			fout = response.getOutputStream();
			fis = new FileInputStream(fullPath);
			FileCopyUtils.copy(fis, fout);

		} catch (Exception e) {

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
	
}
