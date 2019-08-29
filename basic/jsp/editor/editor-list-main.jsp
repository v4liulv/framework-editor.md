<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: liulv
  Date: 2019/8/29
  Time: 20:46
  
  Description: 
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.sinobest.editor.mvc.domain.BEditorAbstract" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>

<html>
<head>
    <%
        String basePath = (String) request.getAttribute("basePath");

        List<BEditorAbstract> bEditorAbstractsList = (List<BEditorAbstract>) request.getAttribute("bEditorAbstractsList");
        Set<String> abstractEditorTypeSet;
        abstractEditorTypeSet = new HashSet<>();
        if (bEditorAbstractsList != null) {
            for (BEditorAbstract bEditorAbstract : bEditorAbstractsList) {
                abstractEditorTypeSet.add(bEditorAbstract.getArticleType() + "");
            }
            application.setAttribute("abstractEditorTypeSet", abstractEditorTypeSet);
        }
    %>
</head>
<body>
  <div id="mainBox" class="container clearfix">
    <main>
        <div class="content-box">
            <div class="header-box">
                <div class="title-box">
                     <h1 class="title">
                        文档管理-项目文档汇总
                     </h1>
                 </div>
            </div>

            <div class="main-search-box">
                <form action="" class="main-nav-tab-search search_input">
                    <div class="float-left label">
                        <label>筛选： </label>
                    </div>

                    <div class="float-left mr24 dropdown type" data-toggle="dropdown" aria-haspopup="true"
                         aria-expanded="false">
                        <button class="btn btn-dropdown dropdown-toggle" type="button">
                            文章类型
                        </button>
                        <input type="hidden" value="" name="type">
                        <ul>
                            <li class="dropdown-item"><a href="javaScript:">全部</a></li>
                            <%-- <jsp:useBean id="dictionariesByTypeList" scope="request" type="java.util.List"/>--%>
                            <c:forEach items="${dictionariesByTypeList}" var="dl" varStatus="s">
                                <li class="dropdown-item" value="${dl.code}"><a href="javaScript:">${dl.value}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="float-left mr24 dropdown classify" data-toggle="dropdown" aria-haspopup="true"
                         aria-expanded="false">
                        <button class="btn btn-dropdown dropdown-toggle" type="button">
                            文章分类
                        </button>
                        <input id="type" type="hidden" value="" name="type">
                        <ul>
                            <li class="dropdown-item"><a href="javaScript:">全部</a></li>
                            <%-- <jsp:useBean id="dictionariesList" scope="request" type="java.util.List"/>--%>
                            <c:forEach items="${dictionariesList}" var="dl" varStatus="s">
                                <li class="dropdown-item" value="${dl.code}"><a href="javaScript:">${dl.value}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="float-left mr32 dropdown title" id="search"
                         onclick="search.changeValue(this);search.searchKeyword()">
                        <input class="txt-keyword dropdown-selected" id="search-input" type="text"
                               placeholder="请输入标题关键词" aria-label="Search" onkeyup="search.searchKeyword();">
                        <ul>
                            <c:forEach items="${bEditorAbstractsList}" var="bal" varStatus="s">
                                <li class="dropdown-item" value=""><a href="javaScript:">${bal.articleTitle}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="float-right search-box mr24">
                        <button type="button" class="btn btn-primary btn-mp-search"><i class="fa fa-search"></i> 搜索
                        </button>
                    </div>
                </form>
            </div>

            <div class="" style="margin: 0 0 1rem 0; ">
                <div class="info-box">
                    <input type="button" class="btn btn-primary" onclick="window.open('<%=basePath%>/editor/add')"
                           value="新增文档">
                    &nbsp;&nbsp;&nbsp;
                    <form target="_blank" action="<%=basePath%>/editor_local/edit" method="post"
                          enctype="multipart/form-data"
                          style="margin:0px;display: inline">
                        <input type="button" id="open" value="打开本地文档" class="btn"/>
                        <input type="file" name="file" id="files" style="display:none"/>
                        <input type="submit" id="submit" value="submit" style="display:none"/>
                    </form>
                </div>
            </div>

            <div class="article-list-box" id="article-list">
               <%-- <c:import url="/jsp/editor/editor-list-item.jsp"></c:import>--%>
                <jsp:include page="/jsp/editor/editor-list-item.jsp"/>
            </div>
        </div>
    </main>
</div>
</body>
</html>
