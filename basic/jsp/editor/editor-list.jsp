<%--
  Created by IntelliJ IDEA.
  User: liulv
  Date: 2018/1/2
  Time: 16:19

  Description: editor.md的doces文章汇总的JSP
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.sinobest.editor.mvc.domain.BEditorAbstract" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="" xml:lang="">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <meta name="generator" content="pandoc"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes"/>
    <title>DOC-概要汇总</title>
    <%
        System.setProperty("sun.jnu.encoding", "utf-8");
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    %>

    <%
        List<BEditorAbstract> bEditorAbstractsList = (List<BEditorAbstract>) request.getAttribute("bEditorAbstractsList");
        Set<String> abstractEditorTypeSet;
        abstractEditorTypeSet = new HashSet<>();
        for (BEditorAbstract bEditorAbstract : bEditorAbstractsList) {
            abstractEditorTypeSet.add(bEditorAbstract.getArticleType() + "");
        }
        application.setAttribute("abstractEditorTypeSet", abstractEditorTypeSet);
    %>


    <link rel="shortcut icon" href="<%=basePath%>/images/logo/editor/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>/css/editor/editor-list.css"/>

    <script src="<%=basePath%>/js/jquery/jquery-1.9.1.js"></script>
    <script src="<%=basePath%>/js/editor/editor-list.js"></script>
    <script src="<%=basePath%>/js/file/FileSaver.js"></script>
    <!--[if lt IE 9]>
    <script src="<%=basePath%>/js/html5shiv-printshiv.min.js"></script>
    <![endif]-->
    <script src="<%=basePath%>/js/input/title-search.js"></script>
    <script type="text/javascript">
    </script>
</head>
<body>
<div id="mainBox" class="container clearfix">
    <main>
        <div class="content-box">
            <div class="header-box">
                <div class="title-box">
                    <h1 class="title">
                        MD文章管理-项目文档汇总
                    </h1>
                </div>

                <div class="info-box">
                    <input type="button" class="btn" onclick="window.open('<%=basePath%>/editor/add')" value="新增文档">
                    &nbsp;&nbsp;&nbsp;
                    <%--<a href="<%=basePath%>/editor/add" title="" style="color: #bfcace">新增文档</a>--%>
                    <form target="_blank" action="<%=basePath%>/editor_local/edit" method="post"
                          enctype="multipart/form-data"
                          style="margin:0px;display: inline">
                        <input type="button" id="open" value="打开本地文档" class="btn"/>
                        <input type="file" name="file" id="files" style="display:none"/>
                        <input type="submit" id="submit" value="submit" style="display:none"/>
                    </form>
                </div>
            </div>

            <div class="main-search-box">
                <form action="" class="main-nav-tab-search search_input">
                    <div class="float-left">
                        <label>筛选： </label>
                    </div>

                    <div class="float-left mr24 dropdown type" data-toggle="dropdown" aria-haspopup="true"
                         aria-expanded="false">
                        <button class="btn1 btn-dropdown dropdown-toggle" type="button" >
                            文章类型
                        </button>
                        <input type="hidden" value="" name="type">
                        <ul>
                            <li class="dropdown-item"><a href="javaScript:">全部</a></li>
                            <c:forEach items="${dictionariesByTypeList}" var="dl" varStatus="s">
                                <li class="dropdown-item"><a href="javaScript:">${dl.value}</a></li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="float-left mr24 dropdown classify" data-toggle="dropdown" aria-haspopup="true"
                         aria-expanded="false" >
                        <button class="btn1 btn-dropdown dropdown-toggle" type="button" >
                            文章分类
                        </button>
                        <input id="type" type="hidden" value="" name="type">
                        <ul>
                            <li class="dropdown-item"><a href="javaScript:">全部</a></li>
                            <c:forEach items="${dictionariesList}" var="dl" varStatus="s">
                                <li class="dropdown-item"><a href="javaScript:">${dl.value}</a></li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="float-left mr32 dropdown" id="search" onclick="search.changeValue(this);search.searchKeyword()">
                        <input class="txt-keyword dropdown-selected" id="search-input" type="text"
                               placeholder="请输入标题关键词" aria-label="Search" onkeyup="search.searchKeyword();">
                        <ul>
                            <c:forEach items="${bEditorAbstractsList}" var="bal" varStatus="s">
                            <li class="dropdown-item"><a href="javaScript:">${bal.articleTitle}</a></li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="float-right search-box mr24">
                        <button type="button" class="btn1 btn-mp-search">搜索</button>
                    </div>
                </form>
            </div>

            <div class="article-list-box">
                <c:import url="editor-list-item.jsp"></c:import>
            </div>
        </div>
    </main>
</div>
</body>
</html>