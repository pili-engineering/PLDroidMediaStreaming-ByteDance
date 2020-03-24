package com.qiniu.pili.droid.streaming.demo.fragment;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.qiniu.bytedanceplugin.model.FilterItem;
import com.qiniu.pili.droid.streaming.demo.R;
import com.qiniu.pili.droid.streaming.demo.adapter.FilterRVAdapter;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.FilterContract;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.OnCloseListener;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.presenter.FilterPresenter;

/**
 * 滤镜
 */
public class FilterFragment extends BaseFeatureFragment<FilterContract.Presenter, FilterFragment.IFilterCallback>
        implements FilterRVAdapter.OnItemClickListener, OnCloseListener, FilterContract.View {
    private RecyclerView rv;

    public interface IFilterCallback {
        void onFilterSelected(FilterItem filterItem);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        rv = (RecyclerView) View.inflate(getContext(), R.layout.fragment_filter, null);
        return rv;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        setPresenter(new FilterPresenter());

        FilterRVAdapter adapter = new FilterRVAdapter(mPresenter.getItems(), this);
        rv.setLayoutManager(new LinearLayoutManager(getContext(), LinearLayoutManager.HORIZONTAL, false));
        rv.setAdapter(adapter);
    }

    public void setSelect(int select) {
        ((FilterRVAdapter)rv.getAdapter()).setSelect(select);
    }

    public void setSelectItem(String fileName) {
        ((FilterRVAdapter)rv.getAdapter()).setSelectItem(fileName);
    }

    @Override
    public void onItemClick(FilterItem filterItem) {
        if (getCallback() == null) {
            return;
        }
        getCallback().onFilterSelected(filterItem);
    }

    @Override
    public void onClose() {
        ((FilterRVAdapter)rv.getAdapter()).setSelect(0);
    }
}
