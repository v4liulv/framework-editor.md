-- Create table
create table B_EDITOR_DICTIONARIES
(
  systemid    NVARCHAR2(32) default SYS_GUID() not null,
  kind        VARCHAR2(50) not null,
  kind_del    VARCHAR2(1000),
  code        NVARCHAR2(50) not null,
  value       NVARCHAR2(200) not null,
  code_del    VARCHAR2(1000),
  scbz        NUMBER(2) default 0 not null,
  create_user VARCHAR2(50) default 'SYS' not null,
  create_time DATE default SYSDATE not null,
  update_time DATE default SYSDATE
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
comment on table B_EDITOR_DICTIONARIES
is '字典表';
-- Add comments to the columns
comment on column B_EDITOR_DICTIONARIES.kind
is '字典类型';
comment on column B_EDITOR_DICTIONARIES.kind_del
is 'KIND详情';
comment on column B_EDITOR_DICTIONARIES.code
is '字段子项的CODE';
comment on column B_EDITOR_DICTIONARIES.value
is '字段项的值';
comment on column B_EDITOR_DICTIONARIES.code_del
is 'CODE详情';
-- Create/Recreate primary, unique and foreign key constraints
alter table B_EDITOR_DICTIONARIES
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
alter table B_EDITOR_DICTIONARIES
  add unique (KIND, CODE)
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
