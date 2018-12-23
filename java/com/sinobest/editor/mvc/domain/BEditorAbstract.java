package com.sinobest.editor.mvc.domain;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @author liulv
 * @date 2018/1/5
 *
 *  * 注意以下几点：
 * 1、UUID自动主键（需要手动添加）
 *  @GeneratedValue(generator = "uuid")
 *  @GenericGenerator(name = "uuid", strategy = "uuid")
 *
 *  2、数据库Date类型，对应使用Java8的LocalDateTime类型（需要手动修改）
 *
 *  3、schema = "YY_GXKSH_ZSB"必须去掉，在集成库不是使用此用户
 *
 *  4、columnDefinition 在Hibernate添加实体时候默认值不起作用
 *  需要手动添加其值，进行实体保存，可能是工程那里配置不正确。后续版本会跟进处理此BUG
 */
@Entity
@Table(name = "B_EDITOR_ABSTRACT")
public class BEditorAbstract implements Serializable {
    private String systemid;
    private String createUser;
    private Date createTime;
    private Date updateTime;
    private long scbz;
    private String blzd1;
    private String blzd2;
    private String blzd3;
    private String blzd4;
    private String blzd5;
    private long documentType;
    private long articleType;
    private String articleTitle;
    private String articleAbstract;
    private String articleContent;
    private String articlePdf;

    @Id
    @Column(name = "SYSTEMID", nullable = false, length = 32)
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    public String getSystemid() {
        return systemid;
    }

    public void setSystemid(String systemid) {
        this.systemid = systemid;
    }

    @Basic
    @Column(name = "CREATE_USER", nullable = false, length = 50)
    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    @Basic
    @Column(name = "CREATE_TIME", nullable = false, updatable = false)
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Basic
    @Column(name = "UPDATE_TIME", nullable = true, insertable = false)
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Basic
    @Column(name = "SCBZ", nullable = false, precision = 0)
    public long getScbz() {
        return scbz;
    }

    public void setScbz(long scbz) {
        this.scbz = scbz;
    }

    @Basic
    @Column(name = "BLZD1", nullable = true, length = 30)
    public String getBlzd1() {
        return blzd1;
    }

    public void setBlzd1(String blzd1) {
        this.blzd1 = blzd1;
    }

    @Basic
    @Column(name = "BLZD2", nullable = true, length = 100)
    public String getBlzd2() {
        return blzd2;
    }

    public void setBlzd2(String blzd2) {
        this.blzd2 = blzd2;
    }

    @Basic
    @Column(name = "BLZD3", nullable = true, length = 200)
    public String getBlzd3() {
        return blzd3;
    }

    public void setBlzd3(String blzd3) {
        this.blzd3 = blzd3;
    }

    @Basic
    @Column(name = "BLZD4", nullable = true, length = 400)
    public String getBlzd4() {
        return blzd4;
    }

    public void setBlzd4(String blzd4) {
        this.blzd4 = blzd4;
    }

    @Basic
    @Column(name = "BLZD5", nullable = true, length = 1000)
    public String getBlzd5() {
        return blzd5;
    }

    public void setBlzd5(String blzd5) {
        this.blzd5 = blzd5;
    }

    @Basic
    @Column(name = "DOCUMENT_TYPE", nullable = false, precision = 0)
    public long getDocumentType() {
        return documentType;
    }

    public void setDocumentType(long documentType) {
        this.documentType = documentType;
    }

    @Basic
    @Column(name = "ARTICLE_TYPE", nullable = false, precision = 0)
    public long getArticleType() {
        return articleType;
    }

    public void setArticleType(long articleType) {
        this.articleType = articleType;
    }

    @Basic
    @Column(name = "ARTICLE_TITLE", nullable = false, length = 300)
    public String getArticleTitle() {
        return articleTitle;
    }

    public void setArticleTitle(String articleTitle) {
        this.articleTitle = articleTitle;
    }

    @Basic
    @Column(name = "ARTICLE_ABSTRACT", nullable = true, length = 300)
    public String getArticleAbstract() {
        return articleAbstract;
    }

    public void setArticleAbstract(String articleAbstract) {
        this.articleAbstract = articleAbstract;
    }

    @Basic
    @Column(name = "ARTICLE_CONTENT", nullable = false)
    public String getArticleContent() {
        return articleContent;
    }

    public void setArticleContent(String articleContent) {
        this.articleContent = articleContent;
    }

    @Basic
    @Column(name = "ARTICLE_PDF", nullable = true)
    public String getArticlePdf() {
        return articlePdf;
    }

    public void setArticlePdf(String articlePdf) {
        this.articlePdf = articlePdf;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BEditorAbstract that = (BEditorAbstract) o;

        if (systemid != null ? !systemid.equals(that.systemid) : that.systemid != null) return false;
        /*if (scbz != that.scbz) return false;
        if (documentType != that.documentType) return false;
        if (articleType != that.articleType) return false;
        if (createUser != null ? !createUser.equals(that.createUser) : that.createUser != null) return false;
        if (createTime != null ? !createTime.equals(that.createTime) : that.createTime != null) return false;
        if (updateTime != null ? !updateTime.equals(that.updateTime) : that.updateTime != null) return false;
        if (blzd1 != null ? !blzd1.equals(that.blzd1) : that.blzd1 != null) return false;
        if (blzd2 != null ? !blzd2.equals(that.blzd2) : that.blzd2 != null) return false;
        if (blzd3 != null ? !blzd3.equals(that.blzd3) : that.blzd3 != null) return false;
        if (blzd4 != null ? !blzd4.equals(that.blzd4) : that.blzd4 != null) return false;
        if (blzd5 != null ? !blzd5.equals(that.blzd5) : that.blzd5 != null) return false;
        if (articleTitle != null ? !articleTitle.equals(that.articleTitle) : that.articleTitle != null) return false;
        if (articleAbstract != null ? !articleAbstract.equals(that.articleAbstract) : that.articleAbstract != null)
            return false;
        if (articleContent != null ? !articleContent.equals(that.articleContent) : that.articleContent != null)
            return false;
        if (articlePdf != null ? !articlePdf.equals(that.articlePdf) : that.articlePdf != null)
            return false;*/

        return true;
    }

    @Override
    public int hashCode() {
        int result = systemid != null ? systemid.hashCode() : 0;
        result = 31 * result + (createUser != null ? createUser.hashCode() : 0);
        result = 31 * result + (createTime != null ? createTime.hashCode() : 0);
        result = 31 * result + (updateTime != null ? updateTime.hashCode() : 0);
        result = 31 * result + (int) (scbz ^ (scbz >>> 32));
        result = 31 * result + (blzd1 != null ? blzd1.hashCode() : 0);
        result = 31 * result + (blzd2 != null ? blzd2.hashCode() : 0);
        result = 31 * result + (blzd3 != null ? blzd3.hashCode() : 0);
        result = 31 * result + (blzd4 != null ? blzd4.hashCode() : 0);
        result = 31 * result + (blzd5 != null ? blzd5.hashCode() : 0);
        result = 31 * result + (int) (documentType ^ (documentType >>> 32));
        result = 31 * result + (int) (articleType ^ (articleType >>> 32));
        result = 31 * result + (articleTitle != null ? articleTitle.hashCode() : 0);
        result = 31 * result + (articleAbstract != null ? articleAbstract.hashCode() : 0);
        result = 31 * result + (articleContent != null ? articleContent.hashCode() : 0);
        result = 31 * result + (articlePdf != null ? articlePdf.hashCode() : 0);
        return result;
    }
}
