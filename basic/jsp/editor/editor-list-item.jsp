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

<head>
    <%
        System.setProperty("sun.jnu.encoding", "utf-8");
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    %>

    <%
        List<BEditorAbstract> bEditorAbstractsList = (List<BEditorAbstract>) request.getAttribute("bEditorAbstractsList");
        Set<String> abstractEditorTypeSet;
        abstractEditorTypeSet = new HashSet<>();
        if(bEditorAbstractsList != null){
            for (BEditorAbstract bEditorAbstract : bEditorAbstractsList) {
                abstractEditorTypeSet.add(bEditorAbstract.getArticleType() + "");
            }
            application.setAttribute("abstractEditorTypeSet", abstractEditorTypeSet);
        }
    %>
</head>
<body>
<div class="article-list-item">
    <c:forEach items="${dictionariesList}" var="dl" varStatus="dls">
        <c:if test="${fn:contains(abstractEditorTypeSet, dl.code)}">
            <div class="article-category-item">
                <h3 id="${dl.code}">${dl.value}</h3>
            </div>

            <div class="article-title-list">
                <blockquote>
                    <ul>
                        <c:forEach items="${bEditorAbstractsList}" var="bal" varStatus="s">
                            <c:if test="${bal.articleType eq dl.code}">
                                <div class="article-title-item">
                                    <li>
                                        <div class="article-title-name">
                                            <p class="article-title-name-txt">
                                                <c:if test="${bal.documentType == '1'}">
                                                    <a href="<%=basePath%>/editor/docs?title=${bal.articleTitle}"
                                                       title="${bal.articleTitle}"
                                                       target="_Blank">
                                                            ${bal.articleTitle}
                                                    </a>
                                                </c:if>
                                                <c:if test="${bal.documentType == '4'}">
                                                    <a href="<%=basePath%>${bal.articleTitle}"
                                                       title="${bal.articleTitle}"
                                                       class=""
                                                       target="_Blank">
                                                            ${bal.articleTitle}
                                                    </a>
                                                </c:if>
                                                <c:if test="${bal.documentType == '2'}">
                                                    ${bal.articleTitle}
                                                </c:if>
                                                <c:if test="${bal.documentType == '3'}">
                                                    ${bal.articleTitle}
                                                </c:if>
                                            </p>
                                        </div>
                                        <div class="article-title-info">
                                            <div class="item-info-left">
                                                <span class="">${bal.updateTime}</span>
                                            </div>

                                            <div class="item-info-right">
                                                <c:if test="${bal.articlePdf != null}">
                                                    <a href="<%=basePath%>${bal.articlePdf}"
                                                       title="${bal.articlePdf}"
                                                       target="_Blank">PDF</a>
                                                </c:if>
                                                <a href="<%=basePath%>/editor/edit?title=${bal.articleTitle}"
                                                   title="${bal.articleTitle}" target="_Blank">编辑</a>
                                                &nbsp;
                                                <p id="systemid" style="display: none">${bal.systemid}
                                                </p>
                                                <a href="" class="delete" title="${bal.systemid}"><span
                                                        class="del">删除</span></a>
                                            </div>
                                        </div>
                                    </li>
                                </div>
                            </c:if>
                        </c:forEach>
                    </ul>
                </blockquote>
            </div>
        </c:if>
    </c:forEach>
</div>
</body>
</html>
