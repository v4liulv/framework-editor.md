<H1> framework-editor.md框架使用说明 </H1>

# Maven依赖引用

首先得进行Maven进行framework-editor.md的依赖添加，进行如下方式添加

**步骤一:** repositories标签中添加如下内容
```xml
<!-- liulv的GitHub版本库 -->
<repository>
    <id>maven-repo-master</id>
    <url>https://raw.githubusercontent.com/v4liulv/maven-repo/master</url>
    <releases>
        <enabled>true</enabled>
    </releases>
    <snapshots>
        <enabled>true</enabled>
    </snapshots>
</repository>
```

**步骤二:** properties标签添加framework-editor版本信息
```xml
 <sinobest.framework.version>1.0.0</sinobest.framework.version>
 ```


**步骤三:** dependencies标签添加framework-editor依赖

```xml
 <!-- framework-editor -->
<dependency>
    <groupId>com.sinobest</groupId>
    <artifactId>framework-editor</artifactId>
    <version>${sinobest.framework.version}</version>
</dependency>
```

# 在Web工程的Web目录下添加相关CSS和JS以及JSP文件

## 拷贝Editor的CSS目录
在本项目中拷贝WEB目录（basic目录）下的相关CSS文件，${project.basedir}/basic/css/editor文件到新项目的WEB目录中,
比如新项目的WEB目录为web,那么拷贝后的结构为${project.basedir}/web/css/editor

## 拷贝Editor的JS目录
在本项目拷贝WEB目录下的相关Editor的JS文件目录${project.basedir}/basic/js/editor文件到新项目的WEB目录中,
比如新项目的WEB目录为web,那么拷贝后的结构为${project.basedir}/web/js/editor

## 拷贝Editor支持的JSP文件目录
在本项目拷贝WEB目录下的相关Editor的JSP文件目录${project.basedir}/basic/views/jsp/editor文件到新项目的WEB目录中,
比如新项目的WEB目录为web,那么拷贝后的结构为${project.basedir}/web/views/jsp/editor

**注意：** 此处的views/jsp为ssh框架的视图层的设置目录，在spring-mvc.xml中的配置视图层解析路径，如下配置
```xml
<!-- 视图解析器 -->
<bean id="viewResolver"
      class="org.springframework.web.servlet.view.InternalResourceViewResolver">
    <property name="prefix" value="/views/jsp/"/>
    <property name="suffix" value=".jsp"/>
</bean>
```

# 配置创建Editor Oracle配置表

## Editor字典表
字段配置表的创建创建语句和插入数据语句在${project.basedir}/database/dictionaries目录下，再配置库进行相关表的创建和数据导入。
**注意：** 其中ARTICLE_TYPE文章类型可以根据自己需要进行修改调整。

## Editor Docs List配置表



## Editor文章记录表
Editor文章表创建语句在${project.basedir}/database/abstract目录下，直接创建表即可，在前端访问时候新建文章时候进行数据插入。


# WEB访问默认地址
http://id:port/editor,如http://localhost:8080/editor


# 如何新增文章、编辑文章、删除文章、新增文章类型

前提，上面步骤都已经处理，并且WBE访问Editor正常。

## 新增文章
点击“新增文档”连接即可进行新增文章，类型默认为markdown,如果您只是添加一个pdf或者docx的话，可以选择其中的类型下拉进行选择，
标题部分现在文章类型和输入文章标题名，则是不可重复的。在文章内容中编辑添加您想要编辑的文章内容，然后Ctrl + S进行保存，也可
点击保存按钮即可对文章进行保存。

## 编辑文章 
选择对应的要编辑的文章后面的“编辑”连接即可进入编辑界面对此文章进行修改。

## 删除文章
选择对应的要编辑的文章后面的“编辑”连接即可进行此文章的删除。

**注意：删除前一定要检查清楚，这是不可逆的过程。**

## 新增文章类型
可在后台B_EDITOR_DICTIONARIES插入数据，如下:
```sql
insert into B_EDITOR_DICTIONARIES (KIND, KIND_DEL, CODE, VALUE, CODE_DEL, SCBZ, CREATE_USER)
values ('ARTICLE_TYPE', '文章类型', '9', 'DSE', null, 0, 'SYS');
commit;
```













