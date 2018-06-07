package com.sinobest.editor.mvc.service.impL;

import com.sinobest.editor.mvc.dao.BEditorAbstractDao;
import com.sinobest.editor.mvc.domain.BEditorAbstract;
import com.sinobest.editor.mvc.service.BEditorAbstractService;
import com.sinobest.framework.base.service.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

/**
 * @author liulv
 * @date 2018/1/5
 */
@Service("BEditorAbstractService")
public class BEditorAbstractServiceImpl extends BaseServiceImpl<BEditorAbstract> implements BEditorAbstractService {
    @Qualifier("BEditorAbstractDao")
    @Autowired
    private BEditorAbstractDao bEditorAbstractDao;
}