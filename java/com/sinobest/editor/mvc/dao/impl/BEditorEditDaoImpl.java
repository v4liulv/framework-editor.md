package com.sinobest.editor.mvc.dao.impl;

import com.sinobest.editor.mvc.dao.BEditorEditDao;
import com.sinobest.editor.mvc.domain.BEditorEdit;
import com.sinobest.framework.base.dao.impl.BaseDaoImpl;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author liulv
 * @date 2018/1/1
 */
@Deprecated
@Transactional(value = "transactionManagerOracle")
@Repository(value = "BEditorEditDao")
public class BEditorEditDaoImpl extends BaseDaoImpl<BEditorEdit> implements BEditorEditDao {
}
