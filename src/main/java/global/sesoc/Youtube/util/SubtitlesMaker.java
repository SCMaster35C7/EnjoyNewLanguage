package global.sesoc.Youtube.util;
 
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.StringTokenizer;

import global.sesoc.Youtube.dto.SubtitlesList;

public class SubtitlesMaker {
	ArrayList<Double> playtime;
	ArrayList<String> playtimeView;
	ArrayList<String> quizIndex;

	// url : 자막파일절대위치, level : 난이도(숫자가 높을수록 높은 난이도)
	public SubtitlesList RandomText(String url, int level) {
		SubtitlesList resultlist = new SubtitlesList();
		FileReader fileReader = null;
		BufferedReader in = null;
		String str = null;
		List<ArrayList<String>> fulltext = new ArrayList<>(); // 본문 풀 텍스트
		List<ArrayList<String>> quiz = new ArrayList<>(); // 문제지
		ArrayList<String> correct = new ArrayList<>(); // 정답 리스트
		playtimeView = new ArrayList<>(); // 자막 타임 시각용	
		playtime = new ArrayList<>(); // 각 자막 줄별 시작타임 저장
		quizIndex = new ArrayList<>(); // 각 퀴즈들의 인덱스 정보
		int height = 0; // [][] 정보중 [?][]부분
		
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
				ArrayList<String> textlist = (ArrayList<String>) analysisText(str);
				if (textlist != null) {

					fulltext.add(textlist);
					ArrayList<String> quiztext = new ArrayList<>();
					quiztext = (ArrayList<String>) textlist.clone();
					int block = quiztext.size() / (6 - level);
					ArrayList<Integer> numberlist = new ArrayList<>();
					for (int i = 0; i < textlist.size(); i++) {
						numberlist.add(i);
					}
					Collections.shuffle(numberlist);
					int[] sortlist = new int[block];
					for (int i = 0; i < block; i++) 
						sortlist[i] = numberlist.get(i);

					Arrays.sort(sortlist);
					//빈칸을 뚫을 칸을 랜덤으로 선택하되 랜덤으로 뽑은칸을 순서대로 뚫어야 하므로(채점의 문제)
					//랜덤숫자 추출 후 sort를 통해 정렬한다.
					for (int i = 0; i < block; i++) {
						String Index = height + ":" + sortlist[i];
						quizIndex.add(Index);
						correct.add(textlist.get(sortlist[i]));
						quiztext.set(sortlist[i], "★★" + textlist.get(sortlist[i]).length());
					}

					quiz.add(quiztext);
					height++;
				}
			}
			resultlist.setCorrect(correct);
			resultlist.setFulltext(fulltext);
			resultlist.setPlaytime(playtime);
			resultlist.setQuiz(quiz);
			resultlist.setPlaytimeView(playtimeView);
			resultlist.setQuizIndex(quizIndex);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return resultlist;
	}

	// 한줄의 문장을 받아서 이를 단어단위로 쪼개고, 특수문자등을 걸러냄
	public List<String> analysisText(String text) {
		int textLen = text.trim().length();
		String replacedText = new String(text);
		List<String> result = new ArrayList<>();
		// 앤터 지우기, 앤터가 있는 문장의 길이가 0다.
		if (textLen == 0)
			return null;

		// 자막 순번 숫자 제거
		if ((text.charAt(0)) >= '0' && text.charAt(0) <= '9') {
			// 뒤에 . 이 붙은 숫자는 대본임으로 삭제하지 않는다.
			if (!text.contains(".") && text.length() < 5)
				return null;
		}
		//시간정보 거르고 대신 시간정보를 분석 메소드로 보냄
		if (text.contains("-->")) {
			double resultTime = analysisTime(text);
			playtime.add(resultTime);
			return null;
		}
        //단어단위로 문장을 쪼개고 특수문자 거름
		StringTokenizer st = new StringTokenizer(replacedText, " -?!♪.,:—–^\"[]{}()<>");

		while (st.hasMoreTokens()) {
			String textpiece = st.nextToken();
			textpiece = textpiece.trim();
			result.add(textpiece);
		}
		return result;
	}

	// 시간분석, time 부분 String 값을 받아서 해당 시간을 분석, second 로 리턴
	public double analysisTime(String time) {
		double resultTime = 0;

		int checkpoint = time.indexOf(",");
		String playtime = time.substring(0, checkpoint);
		StringTokenizer st = new StringTokenizer(time, ":,");
		resultTime += (Double.parseDouble(st.nextToken()) * 3600);
		resultTime += (Double.parseDouble(st.nextToken()) * 60);
		resultTime += Double.parseDouble(st.nextToken());
		resultTime += (Double.parseDouble(st.nextToken().substring(0, 2)) / 100.0);
		playtimeView.add(playtime);

		return resultTime;
	}
}
