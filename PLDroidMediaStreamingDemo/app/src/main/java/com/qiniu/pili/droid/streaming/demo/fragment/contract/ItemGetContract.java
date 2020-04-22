package com.qiniu.pili.droid.streaming.demo.fragment.contract;

import com.qiniu.pili.droid.streaming.demo.base.BasePresenter;
import com.qiniu.pili.droid.streaming.demo.base.IView;
import com.qiniu.pili.droid.streaming.demo.model.ButtonItem;

import java.util.List;

/**
 * 将一个 int 分为两段，前 16 位存储一级菜单，分别是 美颜、美型、滤镜选项
 * 第 17～24 位存储二级菜单，如美颜的 大眼、瘦脸等，美型选项的 瘦脸、大眼等
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
    // 美型
    int TYPE_BEAUTY_RESHAPE = 2 << OFFSET;
    // 美妆
    int TYPE_MAKEUP = 4 << OFFSET;
    // 滤镜
    int TYPE_FILTER = 5 << OFFSET;
    // 美妆类型
    int TYPE_MAKEUP_OPTION = 6 << OFFSET;

    // 二级菜单

    // 美颜
    int TYPE_BEAUTY_FACE_SMOOTH = TYPE_BEAUTY_FACE + (1 << SUB_OFFSET);
    int TYPE_BEAUTY_FACE_WHITEN = TYPE_BEAUTY_FACE + (2 << SUB_OFFSET);
    int TYPE_BEAUTY_FACE_SHARPEN = TYPE_BEAUTY_FACE + (3 << SUB_OFFSET);
    int TYPE_BEAUTY_FACE_BRIGHTEN_EYE = TYPE_BEAUTY_FACE + (4 << SUB_OFFSET);
    int TYPE_BEAUTY_FACE_REMOVE_POUCH = TYPE_BEAUTY_FACE + (5 << SUB_OFFSET);
    int TYPE_BEAUTY_FACE_SMILE_FOLDS = TYPE_BEAUTY_FACE + (6 << SUB_OFFSET);
    int TYPE_BEAUTY_FACE_WHITEN_TEETH = TYPE_BEAUTY_FACE + (7 << SUB_OFFSET);

    // 美型
    int TYPE_BEAUTY_RESHAPE_FACE_OVERALL = TYPE_BEAUTY_RESHAPE + (1 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_EYE = TYPE_BEAUTY_RESHAPE + (2 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_FACE_SMALL = TYPE_BEAUTY_RESHAPE + (3 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_FACE_CUT = TYPE_BEAUTY_RESHAPE + (4 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_CHEEK = TYPE_BEAUTY_RESHAPE + (5 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_JAW = TYPE_BEAUTY_RESHAPE + (6 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_NOSE_LEAN = TYPE_BEAUTY_RESHAPE + (7 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_NOSE_LONG = TYPE_BEAUTY_RESHAPE + (8 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_CHIN = TYPE_BEAUTY_RESHAPE + (9 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_FOREHEAD = TYPE_BEAUTY_RESHAPE + (10 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_EYE_ROTATE = TYPE_BEAUTY_RESHAPE + (11 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_MOUTH_ZOOM = TYPE_BEAUTY_RESHAPE + (12 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_MOUTH_SMILE = TYPE_BEAUTY_RESHAPE + (13 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_DECREE = TYPE_BEAUTY_RESHAPE + (14 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_DARK = TYPE_BEAUTY_RESHAPE + (15 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_EYE_SPACING = TYPE_BEAUTY_RESHAPE + (16 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_EYE_MOVE = TYPE_BEAUTY_RESHAPE + (17 << SUB_OFFSET);
    int TYPE_BEAUTY_RESHAPE_MOUTH_MOVE = TYPE_BEAUTY_RESHAPE + (18 << SUB_OFFSET);

    // Makeup 美妆
    int TYPE_MAKEUP_LIP = TYPE_MAKEUP_OPTION + (1 << SUB_OFFSET);
    int TYPE_MAKEUP_BLUSHER = TYPE_MAKEUP_OPTION + (2 << SUB_OFFSET);
    int TYPE_MAKEUP_EYELASH = TYPE_MAKEUP_OPTION + (3 << SUB_OFFSET);
    int TYPE_MAKEUP_PUPIL = TYPE_MAKEUP_OPTION + (4 << SUB_OFFSET);
    int TYPE_MAKEUP_HAIR = TYPE_MAKEUP_OPTION + (5 << SUB_OFFSET);
    int TYPE_MAKEUP_EYESHADOW = TYPE_MAKEUP_OPTION + (6 << SUB_OFFSET);
    int TYPE_MAKEUP_EYEBROW = TYPE_MAKEUP_OPTION + (7 << SUB_OFFSET);
    int TYPE_MAKEUP_FACIAL = TYPE_MAKEUP_OPTION + (8 << SUB_OFFSET);

    interface View extends IView {
    }

    abstract class Presenter extends BasePresenter<View> {
        /**
         * 根据类型返回一个 {@link ButtonItem} 列表
         */
        public abstract List<ButtonItem> getItems(int type);
    }
}
