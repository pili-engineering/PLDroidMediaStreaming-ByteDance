package com.qiniu.pili.droid.streaming.demo.fragment.contract;

import com.qiniu.pili.droid.streaming.demo.base.BasePresenter;
import com.qiniu.pili.droid.streaming.demo.base.IView;
import com.qiniu.pili.droid.streaming.demo.model.ButtonItem;

import java.util.List;

/**
 * 将一个 int 分为两段，前 16 位存储一级菜单，分别是 美颜、微整形、滤镜选项
 * 第 17～24 位存储二级菜单，如美颜的 大眼、瘦脸等，微整形选项的 瘦脸、大眼等
 * 最后 8 位存储三级菜单，目前只有美妆选项使用到，如存储美瞳效果中的各种颜色
 */
public interface ItemGetContract {
    int OFFSET = 16;
    int MASK = ~0xFFFF;
    int SUB_OFFSET = 8;
    int SUB_MASK = ~0xFF;

    // 一级菜单
    int TYPE_CLOSE = -1;
    // 美颜
    int TYPE_BEAUTY_FACE = 1 << OFFSET;
    // 微整形
    int TYPE_BEAUTY_RESHAPE = 2 << OFFSET;
    // 美体
    int TYPE_BEAUTY_BODY = 3 << OFFSET;
    // 美妆
    int TYPE_MAKEUP = 4 << OFFSET;
    // 滤镜
    int TYPE_FILTER = 5 << OFFSET;
    // 美妆类型
    int TYPE_MAKEUP_OPTION = 6 << OFFSET;

    interface View extends IView {
    }

    abstract class Presenter extends BasePresenter<View> {
        /**
         * 根据类型返回一个 {@link ButtonItem} 列表
         */
        public abstract List<ButtonItem> getItems(int type);

        /**
         * 判断是否为美妆中的染发
         */
        public abstract boolean isHairType(int id);
    }
}