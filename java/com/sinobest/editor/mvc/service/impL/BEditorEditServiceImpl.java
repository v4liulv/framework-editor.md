package com.sinobest.editor.mvc.service.impL;

import com.sinobest.editor.mvc.dao.BEditorEditDao;
import com.sinobest.editor.mvc.domain.BEditorEdit;
import com.sinobest.editor.mvc.service.BEditorEditService;
import com.sinobest.framework.base.service.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

/**
 * @author liulv
 * @date 2018/1/1
 */
@Deprecated
@Service("BEditorEditService")
public class BEditorEditServiceImpl extends BaseServiceImpl<BEditorEdit> implements BEditorEditService {
    @Qualifier("BEditorEditDao")
    @Autowired
    private BEditorEditDao bEditorEditDao;
}
