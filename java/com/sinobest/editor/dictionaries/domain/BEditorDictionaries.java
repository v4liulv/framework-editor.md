package com.sinobest.editor.dictionaries.domain;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * @author liulv
 * @date 2018/6/11
 *
 * Hibernate table domain : BEditionDictionaries - B_EDITOR_DICTIONARIES
 */
@Entity
@Table(name = "B_EDITOR_DICTIONARIES")
public class BEditorDictionaries{
    private String systemid;
    private String kind;
    private String kindDel;
    private String code;
    private String value;
    private String codeDel;
    private long scbz;
    private String createUser;
    private Date createTime;
    private Date updateTime;

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "SYSTEMID", nullable = false, length = 32)
    public String getSystemid() {
        return systemid;
    }

    public void setSystemid(String systemid) {
        this.systemid = systemid;
    }

    @Basic
    @Column(name = "KIND", nullable = false, length = 50)
    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    @Basic
    @Column(name = "KIND_DEL", nullable = true, length = 1000)
    public String getKindDel() {
        return kindDel;
    }

    public void setKindDel(String kindDel) {
        this.kindDel = kindDel;
    }

    @Basic
    @Column(name = "CODE", nullable = false, length = 50)
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Basic
    @Column(name = "VALUE", nullable = false, length = 200)
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Basic
    @Column(name = "CODE_DEL", nullable = true, length = 1000)
    public String getCodeDel() {
        return codeDel;
    }

    public void setCodeDel(String codeDel) {
        this.codeDel = codeDel;
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
    @ColumnDefault("'admin'")
    @Column(name = "CREATE_USER", nullable = false, length = 50)
    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    @Basic
    @Column(name = "CREATE_TIME", nullable = false)
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Basic
    @Column(name = "UPDATE_TIME", nullable = true)
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BEditorDictionaries that = (BEditorDictionaries) o;

        if (scbz != that.scbz) return false;
        if (systemid != null ? !systemid.equals(that.systemid) : that.systemid != null) return false;
        if (kind != null ? !kind.equals(that.kind) : that.kind != null) return false;
        if (kindDel != null ? !kindDel.equals(that.kindDel) : that.kindDel != null) return false;
        if (code != null ? !code.equals(that.code) : that.code != null) return false;
        if (value != null ? !value.equals(that.value) : that.value != null) return false;
        if (codeDel != null ? !codeDel.equals(that.codeDel) : that.codeDel != null) return false;
        if (createUser != null ? !createUser.equals(that.createUser) : that.createUser != null) return false;
        if (createTime != null ? !createTime.equals(that.createTime) : that.createTime != null) return false;
        if (updateTime != null ? !updateTime.equals(that.updateTime) : that.updateTime != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = systemid != null ? systemid.hashCode() : 0;
        result = 31 * result + (kind != null ? kind.hashCode() : 0);
        result = 31 * result + (kindDel != null ? kindDel.hashCode() : 0);
        result = 31 * result + (code != null ? code.hashCode() : 0);
        result = 31 * result + (value != null ? value.hashCode() : 0);
        result = 31 * result + (codeDel != null ? codeDel.hashCode() : 0);
        result = 31 * result + (int) (scbz ^ (scbz >>> 32));
        result = 31 * result + (createUser != null ? createUser.hashCode() : 0);
        result = 31 * result + (createTime != null ? createTime.hashCode() : 0);
        result = 31 * result + (updateTime != null ? updateTime.hashCode() : 0);
        return result;
    }
}
