package com.sinobest.editor.mvc.dao.impl;

import com.sinobest.editor.mvc.dao.BEditorAbstractDao;
import com.sinobest.editor.mvc.domain.BEditorAbstract;
import com.sinobest.framework.base.dao.impl.BaseDaoImpl;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author liulv
 * @date 2018/1/5
 */
@Transactional(value = "transactionManagerJdbc")
@Repository(value = "BEditorAbstractDao")
public class BEditorAbstractDaoImpl extends BaseDaoImpl<BEditorAbstract> implements BEditorAbstractDao {
}
