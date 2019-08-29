<%--
  Created by IntelliJ IDEA.
  User: liulv
  Date: 2018/1/2
  Time: 16:19

  Description: editor.md的doces文章汇总的JSP
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    System.setProperty("sun.jnu.encoding", "utf-8");
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);

    String mainPage = (String) request.getAttribute("mainPage");
    if (mainPage == null || mainPage.equals("")) {
        mainPage = "/jsp/editor/editor-list-main.jsp";
    }
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="" xml:lang="">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <meta name="generator" content="pandoc"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes"/>
    <title>DOC-概要汇总</title>

    <link rel="shortcut icon" href="${basePath}/images/logo/editor/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${basePath}/plug/datatables-bootstrap4/datatables.min.css"/>

    <link rel="stylesheet" href="${basePath}/css/editor/editor-list.css"/>

    <!--jquery3 -->
    <script type="text/javascript" charset="utf-8" src="${basePath}/js/jquery/jquery-3.3.1.min.js"></script>
    <!-- datatables - bootstrap4控件 -->
    <script type="text/javascript" charset="utf-8"
            src="${basePath}/plug/datatables-bootstrap4/datatables.min.js"></script>

    <script src="${basePath}/js/editor/editor-list.js"></script>
    <script src="${basePath}/js/file/FileSaver.js"></script>
    <![endif]-->
    <script src="${basePath}/js/input/title-search.js"></script>
    <!-- SpinJS-->
    <script type="text/javascript" src="${basePath}/plug/spin-2.1.0/jquery.spin.merge.js"></script>
    <!-- lhgdialog弹出窗口框架 -->
    <script type="text/javascript" src="${basePath}/plug/lhgdialog-4.2.0/lhgdialog.js?skin=bootstrap2"></script>
    <!-- 日期控件 -->
    <script type="text/javascript" src="${basePath}/plug/momentjs/moment.min.js"></script>
    <!-- 图标控件 -->
    <script type="text/javascript" charset="utf-8" src="${basePath}/plug/handlebars/handlebars-v3.0.1.js"></script>
</head>
<body>
<div id="mainbody">
    <jsp:include page="<%=mainPage %>"/>
</div>
</body>
</html>