package global.sesoc.Youtube.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		
		//더빙겟

		@RequestMapping(value="/dubbingBoard", method=RequestMethod.GET)
		public String dubbingBoard(HttpSession session, Model model) {
			//System.out.println("들어오냐");
			List<Dubbing> dubbing =  dubRepository.dubbingBoard();
			model.addAttribute("dubbing", dubbing);
			return "DubbingBoard/dubbingBoard";
		}
		
		
		//더빙 디테일

			@RequestMapping(value="/dubDetail", method=RequestMethod.GET)
			public String dubDetail(int dubbingnum, Model model) {
				System.out.println("더빙넘은,,,,,,"+dubbingnum);
				
				Dubbing dubbing = dubRepository.selectOneDub(dubbingnum);
				model.addAttribute("dubbing", dubbing);
			
				return "DubbingBoard/dubDetail";
			}
			
			@RequestMapping(value="DubbingWrite",method=RequestMethod.GET)
			public String DubbingWrite(Model model,int videoNum) {
				Education edu = eduRepository.selectOneFromEduVideo(videoNum);
				model.addAttribute("edu",edu);
				return"DubbingBoard/dubbingWrite";
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
			
}
