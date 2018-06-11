package com.sinobest.editor.dictionaries.dao.impl;

import com.sinobest.editor.dictionaries.dao.EditorDictionariesDao;
import com.sinobest.editor.dictionaries.domain.BEditorDictionaries;
import com.sinobest.framework.base.dao.impl.BaseDaoImpl;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author liulv
 * @date 2018/6/11
 */
@Transactional(value = "transactionManagerOracle")
@Repository(value = "EditorDictionariesDao")
public class EditorDictionariesDaoImp extends BaseDaoImpl<BEditorDictionaries> implements EditorDictionariesDao{
}
