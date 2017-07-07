<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
<script type="text/javascript">
	var isMode = "normal";
	var moreHero = false;
	$(document).ready(function () {
		
		$(".isNormalBtn").click(function () {
			$(".isNormalBtn").addClass("BtnActive");
			$(".isTearBtn").removeClass("BtnActive");
			$(".normalBattle").show();
			$(".tierBattle").hide();
			$(".normalSelect option:eq(0)").attr("selected", "selected");
			$(".normalSelect").trigger("change");
			$(".normalHeroSelect option:eq(0)").attr("selected", "selected");
			$(".normalHeroSelect").trigger("change");
		});
		
		$(".isTearBtn").click(function () {
			$(".isTearBtn").addClass("BtnActive");
			$(".isNormalBtn").removeClass("BtnActive");
			$(".tierBattle").show();
			$(".normalBattle").hide();
			$(".tierSelect option:eq(0)").attr("selected", "selected");
			$(".tierSelect").trigger("change");
			$(".tierHeroSelect option:eq(0)").attr("selected", "selected");
			$(".tierHeroSelect").trigger("change");
		});
		
		$(".normalSelect").change(function () {
			$(".heroInfoBoxList").hide();
			
			$("."+$(".normalSelect").val()).show();
		});
		
		$(".tierSelect").change(function () {
			$(".heroInfoBoxList").hide();
			
			$("."+$(".tierSelect").val()).show();
		});
		
		$(".moreHeroBtn").click(function () {
			if (moreHero == false) {
/* 				$(".highHeroData").css("height","2100px"); */
/* 				$(".heroDeatilStats").css("top","3568px"); */
				
				$(".heroInfo").each(function (index) {
					if (index > 4) $(".heroInfo" + index).show();
				});
/* 				$(".moreHeroDiv").css("top","93%"); */
				$(".moreHeroBtn > span").html("접기 ▲");
				moreHero = true;
			} else {
/* 				$(".highHeroData").css("height","650px"); */
/* 				$(".heroDeatilStats").css("top","2118px"); */
				$(".moreHeroBtn").attr("tabindex", -1).focus();
				$(".heroInfo").each(function (index) {
					if (index > 4) $(".heroInfo" + index).hide();
				});
/* 				$(".moreHeroDiv").css("top","88%"); */
				$(".moreHeroBtn > span").html("모든 영웅 보기 ▼");
				moreHero = false;
			}
		});
		
		$(".normalHeroSelect").change(function () {
			$(".allHeroDetail").hide();
// 			$(".heroDeatilStats").height($("."+$(".normalHeroSelect").val()).height() + 4000);
			//$("."+$(".normalHeroSelect").val()).height()
			$("."+$(".normalHeroSelect").val()).show();			
		});
		
		$(".tierHeroSelect").change(function () {
			$(".allHeroDetail").hide();
// 			$(".heroDeatilStats").height($("."+$(".tierHeroSelect").val()).height() + 4000);
			$("."+$(".tierHeroSelect").val()).show();			
		});
		
		$(".activeSelect").change(function () {
			resetDetailActive();
			$(".activeList").hide();
			$("."+$(".activeSelect").val()).show();
		})
		
/* 		$(".aImg").mouseup(function () {
			$(".clickActive").css("visibility","hidden");	
		}).mousedown(function () {
			$(".clickActive").css("visibility","visible");		
		}) */
		
/*  		$(".aImg").click(function () {
			$(".clickActive").css("visibility","visible");
			$(".aImg").css("border-color","#00c3ff"); 
			$(".aImg").css("box-shadow","inset 0 0 60px 0 rgba(0,195,255,.3)");
			$(".bubble").show();
			$(".clickActive").fadeOut('slow',function(){
				$(".clickActive").show();
				$(".clickActive").css("visibility","hidden");
			});
		});  */
		
		initDetail();
		
		//$(".heroBar").height($("#heroImg").height() + 4);
		
	});
	
	function initDetail() {
		$(".isNormalBtn").trigger("click");
		
		$(".activeSelect option:eq(0)").attr("selected", "selected");
		$(".activeSelect").trigger("change");
		
		$(".heroInfo").each(function (index) {
			if (index > 4) $(".heroInfo" + index).hide();
		});
		
	}
	
	function showDetailActive(index) {
		var isTouch = false;
		
		if ($(".touchActivement" + index).val() == 'true') {
			isTouch = true;
		}
		
		var bubble = "bubble";
		if (index%2 != 0) {
			bubble = "rightBubble";
		}
		
		resetDetailActive();
		
		if (isTouch == false) {
			$(".touchActivement" + index).val('true');
			$(".aImg" + index + " > .clickActive").css("visibility","visible");
			$(".aImg" + index).css("border-color","#00c3ff"); 
			$(".aImg" + index).css("box-shadow","inset 0 0 60px 0 rgba(0,195,255,.3)");
			$(".aImg" + index + " > ." + bubble).show();
			$(".aImg" + index + " > .clickActive").fadeOut('slow',function(){
				$(".aImg" + index + " > .clickActive").show();
				$(".aImg" + index + " > .clickActive").css("visibility","hidden");
			});			
		}
	}
	
	function resetDetailActive() {
		$(".touchActivement").val("false");
		$(".aImg").css("border-color",""); 
		$(".aImg").css("box-shadow","");
		$(".bubble").hide();
		$(".rightBubble").hide();
	}
</script>
<title>Insert title here</title>
</head>
<body>
	<div class="phoneMainHeader" style="overflow-y : hidden;">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container">
		<div class="phoneBody">
			<div class="phoneBodyContent" style="overflow-y : auto" >
				<div>
				<div class="overwatchBackground">
					<div style="width: 100%; height: 90%; position: absolute; top: 13%;">
						<img src="${userInfo.userImg}" />					
						<div>
							<span class="fontWhite" style="font-size: 200%; font-weight: bold;">${userInfo.userName}</span>
						</div>					
						<div>
							<span style="font-size: 300%; font-weight: bold; color: #9daac8">${userInfo.mastheadDetail}</span>
						</div>
						<div>					
						<div class="userLevel">
							<div class="levelImg" style="${userInfo.userLevelBorderImg}">
								<div style="line-height: 4.6">
									<span class="fontWhite" style="font-size: 200%; font-weight: bold;">${userInfo.userLevelTxt}</span>
								</div>
							</div>
							<div class="levelImg2" style="${userInfo.userLevelRankImg2}"></div>
						</div>
						<div class="userRank">
							<img src="${userInfo.userRankImg}" style="width: 50%">
							<div class="userRankValue">
								<span class="fontWhite" style="font-size: 150%; font-weight: bold;">${userInfo.userRankVal}</span>
							</div>
						</div>
						</div>					
					</div>
				</div>
				<div class="overwatchContent">
					<div class="col-3per"></div>
					<div class="col-94per">
						<div class="isNormalTearBtnLine">
							<div class="col-2"></div>
							<div class="col-6">
								<div class="btnCenter">
									<div class="isNormalBtn"><span>빠른대전</span></div>
									<div class="isTearBtn"><span>경쟁전</span></div>							
								</div>
							</div>
							<div class="col-2"></div>
						</div>
						<div class="statsTitle">
							<span>주요 통계</span>
						</div>
						<hr class="lineStyle">=
						<div class="statsContent normalBattle">
							<table class= "statsTable">
								<tr>
									<th colspan="2">통계</th>
								</tr>
								<tbody>
									<tr>
										<td>처치 - 평균</td>
										<td>${userInfo.kill}</td>
									</tr>
									<tr>
										<td>준 피해 - 평균</td>
										<td>${userInfo.damage}</td>
									</tr>
									<tr>
										<td>죽음 - 평균</td>
										<td>${userInfo.death}</td>
									</tr>
									<tr>
										<td>결정타 - 평균</td>
										<td>${userInfo.hit}</td>
									</tr>
									<tr>
										<td>치유 - 평균</td>
										<td>${userInfo.heal}</td>
									</tr>
									<tr>
										<td>임무 기여 처치 - 평균</td>
										<td>${userInfo.missionKill}</td>
									</tr>
									<tr>
										<td>임무 기여 시간 - 평균</td>
										<td>${userInfo.missionTime}</td>
									</tr>
									<tr>
										<td>단독 처치 - 평균</td>
										<td>${userInfo.AloneKill}</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="statsContent tierBattle">
							<table class= "statsTable">
								<tr>
									<th colspan="2">통계</th>
								</tr>
								<tbody>
									<tr>
										<td>처치 - 평균</td>
										<td>${userInfo.tierkill}</td>
									</tr>
									<tr>
										<td>준 피해 - 평균</td>
										<td>${userInfo.tierdamage}</td>
									</tr>
									<tr>
										<td>죽음 - 평균</td>
										<td>${userInfo.tierdeath}</td>
									</tr>
									<tr>
										<td>결정타 - 평균</td>
										<td>${userInfo.tierhit}</td>
									</tr>
									<tr>
										<td>치유 - 평균</td>
										<td>${userInfo.tierheal}</td>
									</tr>
									<tr>
										<td>임무 기여 처치 - 평균</td>
										<td>${userInfo.tiermissionKill}</td>
									</tr>
									<tr>
										<td>임무 기여 시간 - 평균</td>
										<td>${userInfo.tiermissionTime}</td>
									</tr>
									<tr>
										<td>단독 처치 - 평균</td>
										<td>${userInfo.tierAloneKill}</td>
									</tr>
								</tbody>
							</table>
						</div>
						
					</div>
					<div class="col-3per"></div>
				</div>
				<div class="highHeroData">
						<div class="highHeroText">
							<span>상위 영웅</span>
							<br></br>
							<select class="highHeroSortType normalBattle normalSelect">
								<c:forEach var="sortSelect" items="${userInfo.highHeroSort}" varStatus="status">
									<c:if test="${sortSelect.type eq 'normal'}">
										<option value="normal${status.index}">${sortSelect.key}</option>									
									</c:if>
								</c:forEach>
							</select>
							<select class="highHeroSortType tierBattle tierSelect">
								<c:forEach var="sortSelect" items="${userInfo.highHeroSort}" varStatus="status">
									<c:if test="${sortSelect.type eq 'tier'}">
										<option value="tier${status.index}">${sortSelect.key}</option>									
									</c:if>
								</c:forEach>
							</select>
							<br></br>
						</div>
						<hr class="heroLine">=
						
						<c:forEach var="sortHero" items="${userInfo.highHeroSort}" varStatus="index">
							<div style="width: 100%;" class="${sortHero.type}${index.index} heroInfoBoxList">
								<c:forEach var="heroDeatil" items="${sortHero.value}" varStatus="status">
									<div style="width: 100%; display: flex; margin-bottom: 10px" class="heroInfo${status.index} heroInfo">
										<img id="heroImg" src="${heroDeatil.heroImg}" style="border: 2px solid white; border-radius: 10%; width: 15%; height: 50%">	
										<div class="progress heroBar" style="height: auto">
		  									<div class="progress-bar percentBar" role="progressbar" aria-valuenow="${heroDeatil.progressPercent}" aria-valuemin="0" aria-valuemax="10" style="background-image : none;width: ${heroDeatil.progressPercent * 100}%; ${heroDeatil.progressColor}"></div>	
			  								<div class="heroText">
			  									<div class="heroName"><span>${heroDeatil.heroName}</span></div>
			  									<div class="heroValue"><span>${heroDeatil.heroVal}</span></div>
			  								</div>				
		  								</div>
									</div>							
								</c:forEach>
							</div>
						</c:forEach>
						<div class="moreHeroDiv">
							<div class="moreHeroBtn">
								<span>모든 영웅 보기 ▼</span>
							</div>
						</div>
				</div>
				
				
				<div class="heroDeatilStats">
						<div class="highHeroText">
							<span>통계</span>
							<br></br>
							<select class="highHeroSortType normalBattle normalHeroSelect">
								<c:forEach var="sortSelect" items="${userInfo.heroDetailInfo}" varStatus="status">
									<c:if test="${sortSelect.type eq 'normal'}">
										<option value="heroDetailnormal${status.index}">${sortSelect.hero}</option>									
									</c:if>
								</c:forEach>
							</select>
							<select class="highHeroSortType tierBattle tierHeroSelect">
								<c:forEach var="sortSelect" items="${userInfo.heroDetailInfo}" varStatus="status">
									<c:if test="${sortSelect.type eq 'tier'}">
										<option value="heroDetailtier${status.index}">${sortSelect.hero}</option>									
									</c:if>
								</c:forEach>
							</select>
							<br></br>
						</div>
						<hr class="heroLine">=
						<c:forEach var="heroCnt" items="${userInfo.heroDetailInfo}" varStatus="status">
							<div class="heroDetail${heroCnt.type}${status.index} allHeroDetail">
								<c:forEach var="heroDetailInfo" items="${heroCnt.value}" varStatus="cnt">
									<table class= "heroDetailTable" style="margin-top: 3%">
										<tr>
											<th colspan="2">${heroDetailInfo.key}</th>
										</tr>	
										<tbody>
											<c:forEach var="hDetail" items="${heroDetailInfo.value}" varStatus="count">
												<tr>
													<td>${hDetail.key}</td>
													<td>${hDetail.value}</td>
												</tr>
											</c:forEach>
										</tbody>									
									</table>									
								</c:forEach>
							</div>							
						</c:forEach>
						
						<div class="activementDiv">
							<div class="highHeroText">
								<span>업적</span>
								<br></br>
								<select class="highHeroSortType normalBattle activeSelect">
									<c:forEach var="sortSelect" items="${userInfo.active}" varStatus="status">
										<c:if test="${sortSelect.activeSort ne ''}">
											<option value="active${status.index}">${sortSelect.activeSort}</option>									
										</c:if>
									</c:forEach>
								</select>
								<br></br>
							</div>
							<hr class="heroLine">=
							
							<c:forEach var="active" items="${userInfo.active}" varStatus="status">
								<c:if test="${active.activeSort ne ''}">
									<div class="activeContent active${status.index} activeList" style="width: 100%; overflow: hidden">
										<c:forEach var="activeVal" items="${active.value}" varStatus="index">
											<c:choose>
												<c:when test="${activeVal.isActive eq true}">
													<c:set var="oper" value="1"></c:set>
												</c:when>
												<c:otherwise>
													<c:set var="oper" value="0.3"></c:set>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${index.index%2 != 0}">
													<c:set var="bubbleClass" value="rightBubble"></c:set>
												</c:when>
												<c:otherwise>
													<c:set var="bubbleClass" value="bubble"></c:set>
												</c:otherwise>
											</c:choose>
											<div class="aImg aImg${index.index}" onclick="showDetailActive(${index.index})">
												<input type="hidden" class="touchActivement touchActivement${index.index}" value="false" />
												<div class="activeSort">
													<img src="${activeVal.activeImg}" style="width: 100%; height: 100%; opacity: ${oper}">
													<div class="activeNameTxt">
														${activeVal.activeName}
													</div>									
												</div>
												<div class="clickActive"></div>
												<div class="${bubbleClass}">
													<div class="activeDetailNameTxt">
														<span>${activeVal.activeName}</span>
													</div>
													<div class="activeDetailContentTxt">
														${activeVal.activeContent}
													</div>
													<div style="width: 100%; height: 3em; background-color: #3c4860"></div>
												</div>
											</div>
										</c:forEach>
										<div style="width: 100%; height: 200px; float: left;"></div>
									</div>
								</c:if>
							</c:forEach>
						</div>		
				</div>
			</div>
			</div>
		</div>
	</div>
</body>
</html>