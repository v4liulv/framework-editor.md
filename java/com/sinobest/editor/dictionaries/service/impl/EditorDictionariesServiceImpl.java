package com.sinobest.editor.dictionaries.service.impl;

import com.sinobest.editor.dictionaries.dao.EditorDictionariesDao;
import com.sinobest.editor.dictionaries.domain.BEditorDictionaries;
import com.sinobest.editor.dictionaries.service.EditorDictionariesService;
import com.sinobest.framework.base.service.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

/**
 * @author liulv
 * @date 2018/6/11
 */
@Service("EditorDictionariesService")
public class EditorDictionariesServiceImpl extends BaseServiceImpl<BEditorDictionaries>
        implements EditorDictionariesService  {

    @Qualifier("EditorDictionariesDao")
    @Autowired
    private EditorDictionariesDao editorDictionariesDao;

}
