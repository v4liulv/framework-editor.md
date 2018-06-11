-- Create table
create table B_EDITOR_ABSTRACT
(
  systemid         VARCHAR2(32) default SYS_GUID() not null,
  create_user      VARCHAR2(50) default 'SYS' not null,
  create_time      DATE default SYSDATE not null,
  update_time      DATE default SYSDATE,
  scbz             NUMBER(2) default 0 not null,
  blzd1            VARCHAR2(30),
  blzd2            VARCHAR2(100),
  blzd3            VARCHAR2(200),
  blzd4            VARCHAR2(400),
  blzd5            VARCHAR2(1000),
  document_type    NUMBER(5) not null,
  article_type     NUMBER(5) not null,
  article_title    VARCHAR2(300) not null,
  article_abstract VARCHAR2(300),
  article_content  CLOB,
  article_pdf      VARCHAR2(300)
)
tablespace PCS_GXKSH_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table
comment on table B_EDITOR_ABSTRACT
  is 'Editor编辑文件文章信息表';
-- Add comments to the columns
comment on column B_EDITOR_ABSTRACT.create_user
  is '创建人';
comment on column B_EDITOR_ABSTRACT.create_time
  is '创建时间';
comment on column B_EDITOR_ABSTRACT.update_time
  is '更新时间';
comment on column B_EDITOR_ABSTRACT.scbz
  is '删除标志';
comment on column B_EDITOR_ABSTRACT.document_type
  is '文档类型 KIND = DOCUMENT_TYPE';
comment on column B_EDITOR_ABSTRACT.article_type
  is '文章类型 KIND = ARTICLE_TYPE';
comment on column B_EDITOR_ABSTRACT.article_title
  is '文章标题';
comment on column B_EDITOR_ABSTRACT.article_abstract
  is '文章摘要';
comment on column B_EDITOR_ABSTRACT.article_content
  is '文章内容';
comment on column B_EDITOR_ABSTRACT.article_pdf
  is '文章PDF或者WORD路径';
-- Create/Recreate primary, unique and foreign key constraints
alter table B_EDITOR_ABSTRACT
  add primary key (SYSTEMID)
  using index
  tablespace PCS_GXKSH_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table B_EDITOR_ABSTRACT
  add unique (ARTICLE_TITLE)
  using index
  tablespace PCS_GXKSH_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
