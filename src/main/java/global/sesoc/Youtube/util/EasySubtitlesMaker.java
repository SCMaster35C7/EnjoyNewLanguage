package global.sesoc.Youtube.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import global.sesoc.Youtube.dto.SubtitlesList;
 
public class EasySubtitlesMaker {

	ArrayList<Double> playtime;
	ArrayList<String> fullsentence;

	public Map<String,String> GetSubtitles(String url) {
		FileReader fileReader = null;
		BufferedReader in = null;
		String str = null;
		fullsentence = new ArrayList<>(); // 본문 풀 텍스트
		Map<String,String> result=new HashMap<>();

		playtime = new ArrayList<>(); // 각 자막 줄별 시작타임 저장
		int cut = 0; // srt 자막의 첫 문장은 보이지 않는 문자로 글 압축타입을 지정한다. 그러므로 무조건 첫줄은 걸러야 한다.
		try {
			fileReader = new FileReader(url);
			in = new BufferedReader(fileReader);

			while (true) {
				str = in.readLine();

				if (str == null)
					break;
				if (cut == 0) {
					cut++;
					continue;
				}
				analysisText(str);			
			}
			for(int i=0;i<fullsentence.size();i++) {
				result.put(playtime.get(i)+"", fullsentence.get(i));
			}

		} catch (Exception e) {
			
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}

		return result;

	}

	// 한줄의 문장을 받아서 이를 단어단위로 쪼개고, 특수문자등을 걸러냄
	public void analysisText(String text) {
		int textLen = text.trim().length();
		String replacedText = new String(text);
		List<String> result = new ArrayList<>();
		// 앤터 지우기, 앤터가 있는 문장의 길이가 0다.
		if (textLen == 0)
			return;

		// 위에 적힌 1, 2, 3 이런거 지우기
		if ((text.charAt(0)) >= '0' && text.charAt(0) <= '9') {
			// 뒤에 . 이 붙은 숫자는 대본임으로 삭제하지 않는다.
			if (!text.contains(".") && text.length() < 5)
				return;
		}
		// ??:??:??,??? --> ??:??:??,??? 지우기
		if (text.contains("-->")) {
			double resultTime = analysisTime(text);
			playtime.add(resultTime);
			return;
		}
		fullsentence.add(text);

		return;
	}

	// 시간분석, time 부분 String 값을 받아서 해당 시간을 분석, second 로 리턴
	public double analysisTime(String time) {
		double resultTime = 0;
		StringTokenizer st = new StringTokenizer(time, ":,");
		resultTime += (Double.parseDouble(st.nextToken()) * 3600);
		resultTime += (Double.parseDouble(st.nextToken()) * 60);
		resultTime += Double.parseDouble(st.nextToken());
		resultTime += (Double.parseDouble(st.nextToken().substring(0, 2)) / 100.0);

		return resultTime;
	}
}
