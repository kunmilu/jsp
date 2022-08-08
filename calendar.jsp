<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="ja_JP" />
<%!
    private static Map eventMap = new HashMap();
  static {
    eventMap.put("20220101", "お正月");
    eventMap.put("20220110", "成人の日");
    eventMap.put("20220203", "節分");
    eventMap.put("20220214", "バレンタインデー");
    eventMap.put("20220303", "ひな祭り");
    eventMap.put("20220314", "ホワイトデー");
    eventMap.put("20220401", "エイプリルフール");
    eventMap.put("20220422", "イースター");
    eventMap.put("20220508", "母の日");
    eventMap.put("20220619", "父の日");
    eventMap.put("20220707", "七夕");
    eventMap.put("20220723", "土用の丑の日");
    eventMap.put("20220804", "土用の丑の日");
    eventMap.put("20220910", "お月見");
    eventMap.put("20221010", "スポーツの日");
    eventMap.put("20221031", "ハロウィン");
    eventMap.put("20221115", "七五三");
    eventMap.put("20191225", "クリスマス");
    eventMap.put("20191231", "大晦日");
  }
%>
<%
  // リクエストのパラメーターから日付を取り出す
  String year = (String)request.getParameter("year");
  String month = (String)request.getParameter("month");
  String day = (String)request.getParameter("day");
  LocalDate localDate = null;
  if (year == null || month == null || day == null) {
    // 日付が送信されていないので、現在時刻を元に日付の設定を行う
    localDate = LocalDate.now();
    year = String.valueOf(localDate.getYear());
    month = String.valueOf(localDate.getMonthValue());
    day = String.valueOf(localDate.getDayOfMonth());
  } else {
    // 送信された日付を元に、LocalDateのインスタンスを生成する
    localDate = LocalDate.of(Integer.valueOf(year), Integer.valueOf(month), Integer.valueOf(day));
  }
  String[] dates = { year, month, day };

  // 画面で利用するための日付、イベント情報を保存
  session.setAttribute("dates", dates);  
  session.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
  
  String event = (String)eventMap.get(year + month + day);
  session.setAttribute("event", event);
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<style>
ul {
  list-style: none;
}
</style>
</head>
<body>
  <form method="post" action="/techboost/calendar.jsp">
    <ul>
      <li><input type="text" name="year" value="${dates[0]}" /><label for="year">年</label><input type="text" name="month" value="${dates[1]}" /><label for="month">月</label><input type="text" name="day" value="${dates[2]}" /><label for="day">日</label></li>
      <li><input type="submit" value="送信" />
      <li><c:out value="${fn:join(dates, '/')}" /> (<fmt:formatDate value="${date}" pattern="E" />)</li>
      <li><c:out value="${event}" /></li>
    </ul>
  </form>
</body>
</html>
