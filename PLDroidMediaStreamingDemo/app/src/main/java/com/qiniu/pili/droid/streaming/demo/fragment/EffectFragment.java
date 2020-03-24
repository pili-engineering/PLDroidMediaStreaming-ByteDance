package com.qiniu.pili.droid.streaming.demo.fragment;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.Nullable;
import android.support.design.widget.TabLayout;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.ViewPager;
import android.util.SparseArray;
import android.util.SparseIntArray;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.qiniu.bytedanceplugin.model.FilterItem;
import com.qiniu.pili.droid.streaming.demo.R;
import com.qiniu.pili.droid.streaming.demo.adapter.FragmentVPAdapter;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.EffectContract;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.ItemGetContract;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.OnCloseListener;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.presenter.EffectPresenter;
import com.qiniu.pili.droid.streaming.demo.model.ButtonItem;
import com.qiniu.pili.droid.streaming.demo.model.ComposerNode;
import com.qiniu.pili.droid.streaming.demo.ui.ProgressBar;

import java.util.ArrayList;
import java.util.List;

import static com.qiniu.pili.droid.streaming.demo.fragment.contract.ItemGetContract.*;

public class EffectFragment extends
        BaseFeatureFragment<EffectContract.Presenter, EffectFragment.IEffectCallback>
        implements OnCloseListener, MakeupOptionFragment.IMakeupOptionCallback,
        EffectContract.View, ItemGetContract.View, View.OnClickListener {
    public static final int POSITION_BEAUTY = 0;
    public static final int POSITION_RESHAPE = 1;
    public static final int POSITION_FILTER = 2;

    public static final String TAG_MAKEUP_OPTION_FRAGMENT = "makeup_option";
    public static final int ANIMATION_DURATION = 400;

    public static final float NO_VALUE = -1F;

    // view
    private ProgressBar pb;
    private TabLayout tl;
    private TextView tvTitle;
    private ImageView ivCloseMakeupOption;
    private ViewPager vp;

    private List<Fragment> mFragmentList;
    // 当前选择的效果类型，如磨皮等
    private int mSelectType = TYPE_CLOSE;
    // 当前选择的 fragment
    private IProgressCallback mSelectFragment;
    // 效果强度表
    private SparseArray<Float> mProgressMap = new SparseArray<>();
    // 每一个 Fragment 中选中的效果
    private SparseIntArray mTypeMap = new SparseIntArray();
    // 每一个美妆效果选中的类型，如口红的胡萝卜红
    private SparseIntArray mMakeupOptionSelectMap = new SparseIntArray();
    // 所有选中的效果集合
    private SparseArray<ComposerNode> mComposerNodeMap = new SparseArray<>();

    private String mSavedFilterPath;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_effect, container, false);
    }

    @SuppressLint("ClickableViewAccessibility")
    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        setPresenter(new EffectPresenter());
        pb = view.findViewById(R.id.pb_effect);
        Button btnNormal = view.findViewById(R.id.btn_normal);
        Button btnDefault = view.findViewById(R.id.btn_default);
        tl = view.findViewById(R.id.tl_identify);
        tvTitle = view.findViewById(R.id.tv_title_identify);
        ivCloseMakeupOption = view.findViewById(R.id.iv_close_makeup_option);
        vp = view.findViewById(R.id.vp_identify);

        pb.setOnProgressChangedListener(new ProgressBar.OnProgressChangedListener() {
            @Override
            public void onProgressChanged(ProgressBar progressBar, float progress, boolean isFormUser) {
                if (isFormUser) {
                    dispatchProgress(progress);
                }
            }
        });

        btnNormal.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        onNormalDown();
                        break;
                    case MotionEvent.ACTION_CANCEL:
                    case MotionEvent.ACTION_UP:
                        onNormalUp();
                        break;
                    default:
                        break;
                }
                return false;
            }
        });
        btnDefault.setOnClickListener(this);
        ivCloseMakeupOption.setOnClickListener(this);
        initVP();

        new Handler().post(new Runnable() {
            @Override
            public void run() {
                onDefaultClick();
            }
        });
    }

    private void initVP() {
        mFragmentList = new ArrayList<>();
        List<String> titleList = new ArrayList<>();

        // 美颜
        mFragmentList.add(new BeautyFaceFragment().setType(TYPE_BEAUTY_FACE)
                .setCallback(new BeautyFaceFragment.IBeautyCallBack() {
            @Override
            public void onBeautySelect(ButtonItem item) {
                int type = item.getNode().getId();
                mSelectType = type;
                mTypeMap.put(POSITION_BEAUTY, mSelectType);
                if (type == TYPE_CLOSE) {
                    closeBeautyFace();
                    return;
                }

                if (mComposerNodeMap.get(type) == null) {
                    mComposerNodeMap.put(type, item.getNode());
                    updateComposerNodes();
                }
                float progress = mProgressMap.get(type, NO_VALUE);
                if (progress == NO_VALUE) {
                    dispatchProgress((float) item.getDefaultIntensity());
                } else {
                    dispatchProgress(progress);
                }
            }
        }));
        titleList.add(getString(R.string.tab_face_beautification));

        // 美形
        mFragmentList.add(new BeautyFaceFragment().setType(TYPE_BEAUTY_RESHAPE)
                .setCallback(new BeautyFaceFragment.IBeautyCallBack() {
            @Override
            public void onBeautySelect(ButtonItem item) {
                int type = item.getNode().getId();
                mSelectType = type;
                mTypeMap.put(POSITION_RESHAPE, mSelectType);
                if (type == TYPE_CLOSE) {
                    closeBeautyReshape();
                    return;
                }

                if (mComposerNodeMap.get(type) == null) {
                    mComposerNodeMap.put(type, item.getNode());
                    updateComposerNodes();
                }
                float progress = mProgressMap.get(type, NO_VALUE);
                if (progress == NO_VALUE) {
                    dispatchProgress((float) item.getDefaultIntensity());
                } else {
                    dispatchProgress(progress);
                }
            }
        }));
        titleList.add(getString(R.string.tab_face_beauty_reshape));

        // 滤镜
        mFragmentList.add(new FilterFragment()
                .setCallback(new FilterFragment.IFilterCallback() {
            @Override
            public void onFilterSelected(FilterItem filterItem) {
                mSelectType = TYPE_FILTER;
                mTypeMap.put(POSITION_FILTER, TYPE_FILTER);
                mSavedFilterPath = filterItem.getFileName();
                if (getCallback() == null) {
                    return;
                }
                getCallback().onFilterSelected(mSavedFilterPath);
                // 选中滤镜之后初始化强度
                dispatchProgress((float) filterItem.getDefaultIntensity());
            }
        }));
        titleList.add(getString(R.string.tab_filter));

        mSelectFragment = (IProgressCallback) mFragmentList.get(0);
        FragmentVPAdapter adapter = new FragmentVPAdapter(getChildFragmentManager(),
                mFragmentList, titleList);
        vp.setAdapter(adapter);
        vp.setOffscreenPageLimit(mFragmentList.size());
        vp.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
                mSelectType = mTypeMap.get(position, TYPE_CLOSE);
                pb.setProgress(mProgressMap.get(mSelectType, NO_VALUE));

                if (mFragmentList.get(position) instanceof IProgressCallback) {
                    mSelectFragment = (IProgressCallback) mFragmentList.get(position);
                }

                showOrHideProgressBar(true);
            }

            @Override
            public void onPageSelected(int position) {

            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });
        tl.setupWithViewPager(vp);
    }

    /**
     * 将进度分发出去，有两个出口
     * 1、分到对应的 Fragment 中供其更改 UI
     * 2、传递给 Callback 供 EffectRenderHelper 渲染
     * @param progress 进度，0～1
     */
    private void dispatchProgress(float progress) {
        if (mSelectType < 0) {
            return;
        }

        if (mSelectFragment != null) {
            mSelectFragment.onProgress(progress, mSelectType);
        }

        if (pb.getProgress() != progress) {
            pb.setProgress(progress);
        }

        if (mSelectType == TYPE_FILTER) {
            if (getCallback() == null) {
                return;
            }
            mProgressMap.put(TYPE_FILTER, progress);
            getCallback().onFilterValueChanged(progress);
        } else {
            if ((mSelectType & MASK) == TYPE_BEAUTY_FACE ||
                    (mSelectType & MASK) == TYPE_BEAUTY_RESHAPE) {
                mProgressMap.put(mSelectType, progress);
            }

            // 从 mComposerNodeMap 中取 node
            ComposerNode node = mComposerNodeMap.get(mSelectType);
            if (node == null) {
                return;
            }
            node.setValue(progress);
            updateNodeIntensity(node);
        }
    }

    @Override
    public void onClose() {
        // 关闭美颜、美妆、滤镜效果
        if (getCallback() == null) {
            return;
        }
        getCallback().updateComposeNodes(new String[0]);
        getCallback().onFilterSelected(null);

        // 重置 view
        vp.setCurrentItem(0);
        pb.setProgress(0);

        // 重置 MakeupOptionFragment
        MakeupOptionFragment fragment = (MakeupOptionFragment) getChildFragmentManager()
                .findFragmentByTag(TAG_MAKEUP_OPTION_FRAGMENT);
        if (fragment != null) {
            showOrHideMakeupOptionFragment(false);
        }

        // 调用子 View onClose
        for (Fragment f : mFragmentList) {
            if (f instanceof OnCloseListener) {
                ((OnCloseListener) f).onClose();
            }
        }
    }

    @Override
    public void onOptionSelect(ButtonItem item, int select) {
        // 记录当前选择并更新 UI
        mMakeupOptionSelectMap.put(mSelectType, select);

        int lastType = mSelectType;
        mSelectType = item.getNode().getId();

        // 关闭按钮
        if (mSelectType == TYPE_CLOSE) {
            mComposerNodeMap.remove(lastType);
            mProgressMap.remove(lastType);
            pb.setProgress(0);

            updateComposerNodes();
            return;
        }

        mComposerNodeMap.put(mSelectType, item.getNode());
        updateComposerNodes();

        float progress = mProgressMap.get(mSelectType, (float) item.getDefaultIntensity());
        dispatchProgress(progress);
    }

    /**
     * 默认按钮点击之后，需要将所有的值都设置为默认给定的值，其间主要需要解决三个问题
     * 1。 各功能强度值变动之后，需要更改各 item 的标志点
     * 2。 修改到默认值后，需要回到原来的状态（原来选中的按钮依旧选中，进度条依旧指示当前选中的按钮）
     * 3。 不能影响没有强度或不参与的功能（美体、美妆）
     */
    @Override
    public void onDefaultClick() {
        getCallback().onDefaultClick();

        int currentType = mSelectType;
        IProgressCallback currentFragment = mSelectFragment;
        float currentProgress = pb.getProgress();
        int selectedFace = mTypeMap.get(POSITION_BEAUTY, TYPE_CLOSE);
        int selectedReshape = mTypeMap.get(POSITION_RESHAPE, TYPE_CLOSE);

        // close beauty body and makeup when set default
        ((FilterFragment)mFragmentList.get(POSITION_FILTER)).onClose();
        getCallback().onFilterSelected(null);
        mMakeupOptionSelectMap.clear();
        showOrHideMakeupOptionFragment(false);

        mComposerNodeMap.clear();
        mPresenter.generateDefaultBeautyNodes(mComposerNodeMap);
        updateComposerNodes();
        for (int i = 0; i < mComposerNodeMap.size(); i++) {
            ComposerNode node = mComposerNodeMap.valueAt(i);
            if (mPresenter.hasIntensity(node.getId())) {
                mSelectType = node.getId();
                mSelectFragment = getFragmentWithType(mSelectType);
                dispatchProgress(node.getValue());

                if (mSelectType == currentType) {
                    currentProgress = node.getValue();
                }
            }
        }

        if (selectedFace == TYPE_CLOSE) {
            ((IProgressCallback)mFragmentList.get(POSITION_BEAUTY)).setSelect(-1);
        } else {
            ((IProgressCallback)mFragmentList.get(POSITION_BEAUTY)).setSelectItem(selectedFace);
        }
        if (selectedReshape == TYPE_CLOSE) {
            ((IProgressCallback)mFragmentList.get(POSITION_BEAUTY)).setSelect(-1);
        } else {
            ((IProgressCallback)mFragmentList.get(POSITION_RESHAPE)).setSelect(-1);
        }
        pb.setProgress(currentProgress);
        mSelectType = currentType;
        mSelectFragment = currentFragment;
    }

    private void updateComposerNodes() {
        if (getCallback() == null) {
            return;
        }
        getCallback().updateComposeNodes(mPresenter.generateComposerNodes(mComposerNodeMap));
    }

    private void updateNodeIntensity(ComposerNode node) {
        if (getCallback() == null) {
            return;
        }
        getCallback().updateComposeNodeIntensity(node.getKey(), node.getValue());
    }

    private void closeBeautyFace() {
        mPresenter.removeNodesOfType(mComposerNodeMap, TYPE_BEAUTY_FACE);
        mPresenter.removeProgressInMap(mProgressMap, TYPE_BEAUTY_FACE);
        updateComposerNodes();

        pb.setProgress(0);

        // 调用子 Fragment 关闭 UI
        OnCloseListener listener = (OnCloseListener) mFragmentList.get(POSITION_BEAUTY);
        listener.onClose();
    }

    private void closeBeautyReshape() {
        mPresenter.removeNodesOfType(mComposerNodeMap, TYPE_BEAUTY_RESHAPE);
        mPresenter.removeProgressInMap(mProgressMap, TYPE_BEAUTY_RESHAPE);
        updateComposerNodes();

        pb.setProgress(0);

        OnCloseListener listener = (OnCloseListener) mFragmentList.get(POSITION_RESHAPE);
        listener.onClose();
    }

    private void showOrHideProgressBar(boolean isShow) {
        pb.setVisibility(isShow ? View.VISIBLE : View.INVISIBLE);
    }

    /**
     * 显示 or 隐藏 MakeupOptionFragment，在没有实例的情况下会先初始化一个实例
     * 显示一个 MakeupOptionFragment 的时候还会设置其默认选择位置，这个位置保存在
     * {@link this#mMakeupOptionSelectMap} 中
     * @param isShow 是否显示
     */
    private void showOrHideMakeupOptionFragment(boolean isShow) {
        FragmentManager manager = getChildFragmentManager();
        FragmentTransaction transaction = manager.beginTransaction();
        transaction.setCustomAnimations(R.anim.push_down_in, R.anim.push_down_out);
        Fragment makeupOptionFragment = manager.findFragmentByTag(TAG_MAKEUP_OPTION_FRAGMENT);

        if (isShow) {
            tl.setVisibility(View.GONE);
            vp.setVisibility(View.GONE);
            ivCloseMakeupOption.setVisibility(View.VISIBLE);
            tvTitle.setVisibility(View.VISIBLE);
            tvTitle.animate().alpha(1).setDuration(ANIMATION_DURATION).start();
            ivCloseMakeupOption.animate().alpha(1).setDuration(ANIMATION_DURATION).start();
            if (makeupOptionFragment == null) {
                makeupOptionFragment = generateMakeupOptionFragment();
                ((MakeupOptionFragment)makeupOptionFragment).setMakeupType(mSelectType, mMakeupOptionSelectMap.get(mSelectType, 0));

                transaction.add(R.id.fl_identify, makeupOptionFragment, TAG_MAKEUP_OPTION_FRAGMENT).commit();
            } else {
                ((MakeupOptionFragment)makeupOptionFragment).setMakeupType(mSelectType, mMakeupOptionSelectMap.get(mSelectType, 0));
                transaction.show(makeupOptionFragment).commit();
            }
        } else {
            if (makeupOptionFragment == null) {
                return;
            }
            transaction.hide(makeupOptionFragment).commit();
            tvTitle.animate().alpha(0).setDuration(ANIMATION_DURATION).start();
            ivCloseMakeupOption.animate().alpha(0).setDuration(ANIMATION_DURATION).start();
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    tvTitle.setVisibility(View.GONE);
                    ivCloseMakeupOption.setVisibility(View.GONE);
                    tl.setVisibility(View.VISIBLE);
                    vp.setVisibility(View.VISIBLE);
                }
            }, ANIMATION_DURATION);
        }
    }

    private Fragment generateMakeupOptionFragment() {
        return new MakeupOptionFragment().setCallback(this);
    }

    /**
     * 对比按钮按下，关闭无美颜美妆
     */
    private void onNormalDown() {
        if (getCallback() == null) {
            return;
        }
        getCallback().setEffectOn(false);
    }

    /**
     * 对比按钮松开，恢复美颜美妆
     */
    private void onNormalUp() {
        if (getCallback() == null) {
            return;
        }
        getCallback().setEffectOn(true);
    }

    private IProgressCallback getFragmentWithType(int type) {
        int index = ((type & MASK) >> OFFSET) - 1;
        // TYPE_MAKEUP_OPTION 映射到 TYPE_MAKEUP
        if (index == 5) {
            index = 3;
        }
        return index < mFragmentList.size() ? (IProgressCallback) mFragmentList.get(index) : null;
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_default:
                onDefaultClick();
                break;
            case R.id.iv_close_makeup_option:
                showOrHideMakeupOptionFragment(false);
                break;
        }
    }

    /**
     * 用户手动调节 ProgressBar 之后，由此回调至各功能 Fragment 调整 UI
     */
    public interface IProgressCallback {

        void onProgress(float progress, int id);

        int getSelect();

        void setSelect(int select);

        void setSelectItem(int id);
    }

    public interface IEffectCallback {
        /**
         * 更新美妆美颜设置
         * @param nodes 字符串数组，存储所有设置的美颜内容，当 node 长度为 0 时意为关闭美妆
         */
        void updateComposeNodes(String[] nodes);

        /**
         * 更新某一个效果的强度
         * @param key 特效对应的 key 值
         * @param value 特效强度 范围 0~1
         */
        void updateComposeNodeIntensity(String key, float value);

        // 滤镜
        void onFilterSelected(String path);
        void onFilterValueChanged(float cur);

        /**
         * 设置是否处理特效
         * @param isOn if false，则在处理纹理的时候不使用 RenderManager 处理原始纹理，则不会有效果
         */
        void setEffectOn(boolean isOn);

        void onDefaultClick();
    }
}
