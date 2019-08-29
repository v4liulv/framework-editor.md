<%--
  Created by IntelliJ IDEA.
  User: liulv
  Date: 2018/1/2
  Time: 16:19

  Description: editor.md的doces文章汇总的JSP
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%@ page import="com.sinobest.editor.dictionaries.domain.BEditorDictionaries" %>
<%@ page import="com.sinobest.editor.mvc.domain.BEditorAbstract" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Date" %>

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
        //使用绝对地址，避免神奇的路径BUG
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        //BEditorAbstract List
        List<BEditorAbstract> bEditorAbstractsList = (List<BEditorAbstract>) request.getAttribute("bEditorAbstractsList");
        //Dictionaries List Kind = ARTICLE_TYPE
        List<BEditorDictionaries> dictionariesList = (List<BEditorDictionaries>) request.getAttribute("dictionariesList");

        Set<String> abstractEditorTypeSet;
        boolean falg = true;
        if (dictionariesList == null || dictionariesList.size() == 0) {
            falg = false;
        }
        if (bEditorAbstractsList == null || bEditorAbstractsList.size() == 0) {
            falg = false;
            return;
        }
        abstractEditorTypeSet = new HashSet<>();
        for (BEditorAbstract bEditorAbstract : bEditorAbstractsList) {
            abstractEditorTypeSet.add(bEditorAbstract.getArticleType() + "");
        }
    %>


    <link rel="shortcut icon" href="<%=basePath%>/images/logo/editor/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>/css/editor/editor-list.css"/>

    <script src="<%=basePath%>/js/jquery/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="<%=basePath%>/plug/spin-2.1.0/jquery.spin.merge.js"></script>
    <script src="<%=basePath%>/js/editor/editor-list.js"></script>
    <script src="<%=basePath%>/js/file/FileSaver.js"></script>
    <!--[if lt IE 9]>
    <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv-printshiv.min.js"></script>
    <![endif]-->
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

                    <div class="float-left mr24 dropdown type" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <button class="btn1 btn-dropdown dropdown-toggle" type="button">
                            文章类型
                        </button>
                    </div>

                    <div class="float-left mr24 dropdown classify" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <button type="button" class="btn1 btn-dropdown dropdown-toggle">
                            文章分类
                        </button>
                        <input id="type" type="hidden" value="" name="type">
                    </div>

                    <div class="float-left mr32">
                        <input class="txt-keyword" type="text" placeholder="请输入标题关键词" aria-label="Search">
                    </div>

                    <div class="float-right search-box mr24">
                        <button type="button" class="btn1 btn-mp-search">搜索</button>
                    </div>

                </form>
            </div>

            <div class="article-list-box">

                <div class="article-list-item">
                    <%
                        if (!falg) return;
                        for (BEditorDictionaries bEditorDictionaries : dictionariesList) {
                            String editorType = bEditorDictionaries.getCode();
                            String editorTypeValue = bEditorDictionaries.getValue();
                            //判断editor 类型是否存在文章
                            if (!abstractEditorTypeSet.contains(editorType)) continue;
                    %>
                    <div class="article-category-item">
                        <h3 id="<%= editorType%>"><%= editorTypeValue%>
                        </h3>
                    </div>

                    <div class="article-title-list">
                        <blockquote>
                            <ul>
                                <%
                                    for (BEditorAbstract bEditorAbstract : bEditorAbstractsList) {
                                        if (!editorType.equals(bEditorAbstract.getArticleType() + "")) continue;
                                        String systemid = bEditorAbstract.getSystemid();
                                        String editTitle = bEditorAbstract.getArticleTitle();
                                        Long documentType = bEditorAbstract.getDocumentType();
                                        String abstractContent = bEditorAbstract.getArticleContent();
                                        String abstractPDF = bEditorAbstract.getArticlePdf();
                                        Date date = bEditorAbstract.getUpdateTime();
                                %>
                                <div class="article-title-item">
                                    <li>
                                        <div class="article-title-name">
                                            <p class="article-title-name-txt">
                                                <%
                                                    if (documentType.equals(1L)) {
                                                %>
                                                <a href="<%=basePath%>/editor/docs?title=<%=editTitle %>"
                                                   title="<%=editTitle %>"
                                                   target="_Blank"><%=editTitle %>
                                                </a>
                                                <%
                                                } else if (documentType.equals(4L)) {
                                                %>
                                                <a href="<%=basePath%><%=abstractContent%>" title="<%=editTitle %>"
                                                   class=""
                                                   target="_Blank"><%=editTitle %>
                                                </a>
                                                <%
                                                } else {
                                                %>
                                                <%=editTitle %>
                                                <%
                                                    }
                                                %>
                                            </p>
                                        </div>
                                        <div class="article-title-info">
                                            <div class="item-info-left">
                                                <span class=""><%= date%></span>
                                            </div>

                                            <div class="item-info-right">
                                                <%
                                                    if (null == abstractPDF || "".equals(abstractPDF)) {
                                                %>
                                                <a href="javascript:return false;" title="<%=abstractPDF %>"
                                                   style="color: #bfcace"
                                                   target="_Blank">PDF</a>
                                                <%
                                                } else {
                                                %>
                                                <a href="<%=basePath%><%=abstractPDF%>" title="<%=abstractPDF %>"
                                                   target="_Blank">PDF</a>
                                                <%
                                                    }
                                                %>

                                                <a href="<%=basePath%>/editor/edit?title=<%=editTitle %>"
                                                   title="<%=editTitle %>" target="_Blank">编辑</a>
                                                &nbsp;
                                                <p id="systemid" style="display: none"><%=systemid %>
                                                </p>
                                                <a href="" class="delete" title="<%=systemid %>"><span
                                                        class="del">删除</span></a>
                                            </div>
                                        </div>
                                    </li>
                                </div>
                                <%
                                    }
                                %>
                            </ul>
                        </blockquote>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>