package com.qiniu.pili.droid.streaming.demo.fragment.contract;

import com.qiniu.bytedanceplugin.model.FilterItem;
import com.qiniu.pili.droid.streaming.demo.base.BasePresenter;
import com.qiniu.pili.droid.streaming.demo.base.IView;

import java.util.List;


public interface FilterContract {
    interface View extends IView {

    }

    abstract class Presenter extends BasePresenter<View> {
        public abstract List<FilterItem> getItems();
    }
}
