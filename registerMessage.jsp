<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//セッションの有効期限設定（秒単位）
session.setMaxInactiveInterval(180);
String logout = (String)request.getParameter("logout");
String message = null;
if (logout != null && logout.equals("ture")){
	//セッションの破棄
	session.invalidate();
} else {
	//GETパラメータから「メッセージ」を取り出す
	message = (String)request.getParameter("message");
	if (message != null){
		//「メッセージ」が送信されていたのでセッションに保存
		session.setAttribute("message", message);
	} else {
		//「メッセージ」が送信されていなかったのでセッションからメッセージを取得
		message = (String)session.getAttribute("message");
	}
}
if (message == null)message = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>registerMessage</title>
<style>
ul{
list-style: none;
}
</style>
</head>
<body>
<form action="/techboost/registerMessage.jsp" method="get">
<ul>
<li>
<label for="message">メッセージ</label>
<input type="text" name="message" value="<%= message %>">
</li>
<li>
<input type="submit" value="登録">
<a href="/techboost/registerMessage.jsp?logout=ture">ログアウト</a>
</li>
</ul>
</form>
</body>
</html>