package kr.co.mlec.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/overwatch")
public class OverwatchController {
	
	
	@RequestMapping(method = RequestMethod.GET)
	public String searchForm() throws Exception {
		return "overwatch/searchForm";
	}
	
	@RequestMapping(value="/test", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> crawling() throws Exception {
		String urlstr = "https://playoverwatch.com/ko-kr/career/pc/kr/이성주-3468";
		Map<String, Object> userInfo = new HashMap<String, Object>();
		try {
			Document doc = Jsoup.connect(urlstr).get();						
			Elements titleImg = doc.select(".masthead-player > img");
			for (Element t : titleImg) {
				userInfo.put("userImg", t.attr("src"));
			}
			
			Elements userName = doc.select(".header-masthead");
			for (Element t : userName) {
				userInfo.put("userName", t.text());
			}
			Elements mastheadDetail = doc.select(".masthead-detail > span");
			userInfo.put("mastheadDetail", mastheadDetail.text());
			
			Elements userLevel = doc.select(".player-level");
			for (Element t : userLevel) {
				userInfo.put("userLevelBorderImg", t.attr("style"));
				userInfo.put("userLevelTxt", t.child(0).text());
				if (t.childNodeSize() > 1) {
					userInfo.put("userLevelRankImg2", t.child(1).attr("style"));
				}
				break;
			}
			
			Elements userRank = doc.select(".competitive-rank");
			for (Element t : userRank) {
				userInfo.put("userRankImg", t.child(0).attr("src"));
				userInfo.put("userRankVal", t.child(1).text());
				break;
			}
			
			String average[] = {"kill","damage","death","hit","heal","missionKill","missionTime","AloneKill"};
			String tier = "";
			int i = 0;		
			Elements userAverage = doc.select(".card-content");
			for (Element t : userAverage) {
				userInfo.put(tier + average[i], t.child(0).text());
				i++;
				
				if (t.child(1).text().indexOf("단독") != -1) {
					i = 0;
					tier = "tier";
				}
			}
			
			Elements selecter = doc.select(".progress-category > .progress-2");
			List<Map<String,String>> sortHeroList = new ArrayList<Map<String,String>>();
			List<Map<String,Object>> highHeroSortList = new ArrayList<Map<String,Object>>();
			Map<String, Object> sortTypeMap = new HashMap<String, Object>();
/*			String sortType[] = {"playTimeSort","winGameSort","accuracySort","killSort","MultiKillSort","missionKillSort"};
			String tierSortType[] = {"playTimeSort","winGameSort","winRateSort","accuracySort","killSort","MultiKillSort","missionKillSort"};*/
			String sortType[] ={"플레이시간","승리한 게임","명중률","목숨당처치","동시처치","임무기여"};
			String tierSortType[] ={"플레이시간","승리한 게임","승률","명중률","목숨당처치","동시처치","임무기여"};
			int hero = 0;
			int sort = 0;
			for (Element t : selecter) {
				Map<String,String> heroInfo = new HashMap<String, String>();
				heroInfo.put("progressPercent", t.attr("data-overwatch-progress-percent"));
				heroInfo.put("heroImg", t.child(0).attr("src"));
				heroInfo.put("heroName", t.child(1).child(1).child(0).text());
				heroInfo.put("heroVal", t.child(1).child(1).child(1).text());
				heroInfo.put("progressColor", t.child(1).child(0).attr("style"));
				sortHeroList.add(heroInfo);
				hero++;
				
				if (hero == 24) {
					if (sort >= 6) {
						sortTypeMap.put("key",tierSortType[sort - 6]);
						sortTypeMap.put("type","tier");
						sortTypeMap.put("value", sortHeroList);
						highHeroSortList.add(sortTypeMap);
						//sortTypeMap.put("tier"+tierSortType[sort - 6], sortHeroList);
						sortTypeMap = new HashMap<String, Object>();
						sortHeroList = new ArrayList<Map<String,String>>();
						sort++;
						hero = 0;
					} else {
						//userInfo.put(sortType[sort], sortHeroList);
						sortTypeMap.put("key", sortType[sort]);
						sortTypeMap.put("type","normal");
						sortTypeMap.put("value", sortHeroList);
						highHeroSortList.add(sortTypeMap);
						sortHeroList = new ArrayList<Map<String,String>>();
						sortTypeMap = new HashMap<String, Object>();
						sort++;
						hero = 0;						
					}
				}
			}
			userInfo.put("highHeroSort",highHeroSortList);
			
			
			Elements heroSelect = doc.select(".career-stats-section > div > div > div > select > option");
			List<String> heroNameList = new ArrayList<String>();
			for (Element t : heroSelect) {
				heroNameList.add(t.text());
				//System.out.println(t.text());
			}
			int nameIndex = 0;
			int isTier = 0;
			List<Map<String,Object>> heroDetailInfoList = new ArrayList<Map<String,Object>>();
			Elements dataTable = doc.select(".js-stats");
			for (Element t : dataTable) {
				Map<String, Object> obj = new HashMap<String, Object>();
				if (heroNameList.get(nameIndex).indexOf("모든") != -1) isTier += 1;
				obj.put("hero", heroNameList.get(nameIndex++));
				if (isTier == 2) {
					obj.put("type", "tier");
				} else {
					obj.put("type", "normal");
				}
				List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				Elements detailData = t.select(".data-table");
				for (Element d : detailData) {
					Map<String, Object> dt = new HashMap<String, Object>();
					dt.put("key", d.select(".stat-title").text());
					List<Map<String,String>> dataList = new ArrayList<Map<String,String>>();
					for (Element detail : d.select("tbody > tr")) {
						Map<String,String> detailDataMap = new HashMap<String, String>();
						detailDataMap.put("key", detail.child(0).text());
						detailDataMap.put("value", detail.child(1).text());
						dataList.add(detailDataMap);
					}
					dt.put("value", dataList);
					list.add(dt);
				}
				obj.put("value", list);
				heroDetailInfoList.add(obj);
			}
			userInfo.put("heroDetailInfo", heroDetailInfoList);
			
			String activeName[] = {"","일반","공격","수비","돌격","지원","전장","특별"};
			int activeIndex = 0;
			List<Map<String, Object>> activesList = new ArrayList<Map<String,Object>>();
			Elements activements = doc.select(".u-relative");
			for (Element t : activements) {
				Map<String,Object> activeType = new HashMap<String, Object>();
				List<Map<String,Object>> activeList = new ArrayList<Map<String,Object>>();
				activeType.put("activeSort", activeName[activeIndex++]);
				Elements activement = t.select("ul > div");
				for (Element d : activement) {
					boolean isActive = false;
					Map<String, Object> activeMap = new HashMap<String, Object>();
					if (d.child(0).attr("class").indexOf("m-disabled") == -1) {
						isActive = true;
					}
					activeMap.put("isActive", isActive);
					activeMap.put("activeImg", d.child(0).child(0).attr("src"));
					activeMap.put("activeName", d.child(0).child(1).text());
					activeMap.put("activeContent", d.child(1).child(2).text());
					activeList.add(activeMap);
				}
				activeType.put("value", activeList);
				activesList.add(activeType);
			}
			userInfo.put("active", activesList);
			return userInfo;
		} catch (Exception e) {
			userInfo.put("fail", "notFound");
			return userInfo;
		}
		
	}
	
	
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView getOverwatchLog(String overwatchId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String battleTag = overwatchId.replace("#", "-");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("overwatch/overwatchDeatil");
		String urlstr = "https://playoverwatch.com/ko-kr/career/pc/kr/" + battleTag;
		Map<String, Object> userInfo = new HashMap<String, Object>();
		try {
			Document doc = Jsoup.connect(urlstr).get();				
			Elements titleImg = doc.select(".masthead-player > img");
			for (Element t : titleImg) {
				userInfo.put("userImg", t.attr("src"));
			}
			
			Elements userName = doc.select(".header-masthead");
			for (Element t : userName) {
				userInfo.put("userName", t.text());
			}
			Elements mastheadDetail = doc.select(".masthead-detail > span");
			userInfo.put("mastheadDetail", mastheadDetail.text());
			
			Elements userLevel = doc.select(".player-level");
			for (Element t : userLevel) {
				userInfo.put("userLevelBorderImg", t.attr("style"));
				userInfo.put("userLevelTxt", t.child(0).text());
				if (t.childNodeSize() > 1) {
					userInfo.put("userLevelRankImg2", t.child(1).attr("style"));
				}
				break;
			}
			
			Elements userRank = doc.select(".competitive-rank");
			for (Element t : userRank) {
				userInfo.put("userRankImg", t.child(0).attr("src"));
				userInfo.put("userRankVal", t.child(1).text());
				break;
			}
			
			String average[] = {"kill","damage","death","hit","heal","missionKill","missionTime","AloneKill"};
			String tier = "";
			int i = 0;		
			Elements userAverage = doc.select(".card-content");
			for (Element t : userAverage) {
				userInfo.put(tier + average[i], t.child(0).text());
				i++;
				
				if (t.child(1).text().indexOf("단독") != -1) {
					i = 0;
					tier = "tier";
				}
			}
			
			Elements selecter = doc.select(".progress-category > .progress-2");
			List<Map<String,String>> sortHeroList = new ArrayList<Map<String,String>>();
			List<Map<String,Object>> highHeroSortList = new ArrayList<Map<String,Object>>();
			Map<String, Object> sortTypeMap = new HashMap<String, Object>();
/*			String sortType[] = {"playTimeSort","winGameSort","accuracySort","killSort","MultiKillSort","missionKillSort"};
			String tierSortType[] = {"playTimeSort","winGameSort","winRateSort","accuracySort","killSort","MultiKillSort","missionKillSort"};*/
			String sortType[] ={"플레이시간","승리한 게임","명중률","목숨당처치","동시처치","임무기여"};
			String tierSortType[] ={"플레이시간","승리한 게임","승률","명중률","목숨당처치","동시처치","임무기여"};
			int hero = 0;
			int sort = 0;
			for (Element t : selecter) {
				Map<String,String> heroInfo = new HashMap<String, String>();
				heroInfo.put("progressPercent", t.attr("data-overwatch-progress-percent"));
				heroInfo.put("heroImg", t.child(0).attr("src"));
				heroInfo.put("heroName", t.child(1).child(1).child(0).text());
				heroInfo.put("heroVal", t.child(1).child(1).child(1).text());
				heroInfo.put("progressColor", t.child(1).child(0).attr("style"));
				sortHeroList.add(heroInfo);
				hero++;
				
				if (hero == 24) {
					if (sort >= 6) {
						sortTypeMap.put("key",tierSortType[sort - 6]);
						sortTypeMap.put("type","tier");
						sortTypeMap.put("value", sortHeroList);
						highHeroSortList.add(sortTypeMap);
						//sortTypeMap.put("tier"+tierSortType[sort - 6], sortHeroList);
						sortTypeMap = new HashMap<String, Object>();
						sortHeroList = new ArrayList<Map<String,String>>();
						sort++;
						hero = 0;
					} else {
						//userInfo.put(sortType[sort], sortHeroList);
						sortTypeMap.put("key", sortType[sort]);
						sortTypeMap.put("type","normal");
						sortTypeMap.put("value", sortHeroList);
						highHeroSortList.add(sortTypeMap);
						sortHeroList = new ArrayList<Map<String,String>>();
						sortTypeMap = new HashMap<String, Object>();
						sort++;
						hero = 0;						
					}
				}
			}
			userInfo.put("highHeroSort",highHeroSortList);
			
			
			Elements heroSelect = doc.select(".career-stats-section > div > div > div > select > option");
			List<String> heroNameList = new ArrayList<String>();
			for (Element t : heroSelect) {
				heroNameList.add(t.text());
				//System.out.println(t.text());
			}
			int nameIndex = 0;
			int isTier = 0;
			List<Map<String,Object>> heroDetailInfoList = new ArrayList<Map<String,Object>>();
			Elements dataTable = doc.select(".js-stats");
			for (Element t : dataTable) {
				Map<String, Object> obj = new HashMap<String, Object>();
				if (heroNameList.get(nameIndex).indexOf("모든") != -1) isTier += 1;
				obj.put("hero", heroNameList.get(nameIndex++));
				if (isTier == 2) {
					obj.put("type", "tier");
				} else {
					obj.put("type", "normal");
				}
				List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				Elements detailData = t.select(".data-table");
				for (Element d : detailData) {
					Map<String, Object> dt = new HashMap<String, Object>();
					dt.put("key", d.select(".stat-title").text());
					List<Map<String,String>> dataList = new ArrayList<Map<String,String>>();
					for (Element detail : d.select("tbody > tr")) {
						Map<String,String> detailDataMap = new HashMap<String, String>();
						detailDataMap.put("key", detail.child(0).text());
						detailDataMap.put("value", detail.child(1).text());
						dataList.add(detailDataMap);
					}
					dt.put("value", dataList);
					list.add(dt);
				}
				obj.put("value", list);
				heroDetailInfoList.add(obj);
			}
			userInfo.put("heroDetailInfo", heroDetailInfoList);
			
			String activeName[] = {"","일반","공격","수비","돌격","지원","전장","특별"};
			int activeIndex = 0;
			List<Map<String, Object>> activesList = new ArrayList<Map<String,Object>>();
			Elements activements = doc.select(".u-relative");
			for (Element t : activements) {
				Map<String,Object> activeType = new HashMap<String, Object>();
				List<Map<String,Object>> activeList = new ArrayList<Map<String,Object>>();
				activeType.put("activeSort", activeName[activeIndex++]);
				Elements activement = t.select("ul > div");
				for (Element d : activement) {
					boolean isActive = false;
					Map<String, Object> activeMap = new HashMap<String, Object>();
					if (d.child(0).attr("class").indexOf("m-disabled") == -1) {
						isActive = true;
					}
					activeMap.put("isActive", isActive);
					activeMap.put("activeImg", d.child(0).child(0).attr("src"));
					activeMap.put("activeName", d.child(0).child(1).text());
					activeMap.put("activeContent", d.child(1).child(2).text());
					activeList.add(activeMap);
				}
				activeType.put("value", activeList);
				activesList.add(activeType);
			}
			userInfo.put("active", activesList);
			mav.addObject("userInfo",userInfo);
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('아이디를 확인해주세요');");
			pw.println("location.href='/overwatch'");
			pw.println("</script>");
			pw.close();
		}
		return mav;
	}
	
	
	@RequestMapping(value = "/search",method = RequestMethod.GET)
	public String popup() throws Exception {
		return "overwatch/idSearchPop";
	}
	
	@RequestMapping(value = "/search",method = RequestMethod.POST)
	public ModelAndView getBattleTag(String battleTagVal) throws Exception {
		ModelAndView mav = new ModelAndView("overwatch/idSearchPop");
		mav.addObject("battleTag", battleTagVal);
		
		return mav;
	}
	
}
