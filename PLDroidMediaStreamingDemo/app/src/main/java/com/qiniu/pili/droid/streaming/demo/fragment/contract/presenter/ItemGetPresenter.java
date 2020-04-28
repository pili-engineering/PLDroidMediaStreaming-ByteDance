package com.qiniu.pili.droid.streaming.demo.fragment.contract.presenter;

import com.qiniu.bytedanceplugin.ByteDancePlugin;
import com.qiniu.bytedanceplugin.model.MakeUpModel;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.ItemGetContract;
import com.qiniu.pili.droid.streaming.demo.model.ButtonItem;
import com.qiniu.pili.droid.streaming.demo.model.ComposerNode;
import com.qiniu.pili.droid.streaming.demo.utils.Util;

import java.util.ArrayList;
import java.util.List;

import static com.qiniu.pili.droid.streaming.demo.fragment.contract.ItemGetContract.*;


public class ItemGetPresenter extends ItemGetContract.Presenter {

    @Override
    public List<ButtonItem> getItems(int type) {
        List<ButtonItem> items = new ArrayList<>();
        items.add(new ButtonItem(null, "清除", 0d, new ComposerNode(TYPE_CLOSE)));
        List<MakeUpModel> makeUpModels;
        switch (type & MASK) {
            case TYPE_BEAUTY_FACE:
                makeUpModels = ByteDancePlugin.getBeautyList();
                break;
            case TYPE_BEAUTY_RESHAPE:
                makeUpModels = ByteDancePlugin.getShapeList();
                break;
            case TYPE_MAKEUP:
                makeUpModels = ByteDancePlugin.getMakeUpList();
                break;
            case TYPE_MAKEUP_OPTION:
                makeUpModels = getMakeupOptionItems(type);
                break;
            default:
                makeUpModels = new ArrayList<>();
        }
        for (MakeUpModel makeUpModel : makeUpModels) {
            items.add(new ButtonItem(makeUpModel.getIconPath(), makeUpModel.getEffectName(), makeUpModel.getDefaultIntensity(),
                    new ComposerNode(translateKey2id(makeUpModel.getKey()), makeUpModel.getFileName(), makeUpModel.getKey())));
        }
        return items;
    }

    private List<MakeUpModel> getMakeupOptionItems(int type) {
        switch (type & SUB_MASK) {
            case TYPE_MAKEUP_LIP:
                return ByteDancePlugin.getMakeUpOptionItems().get("lip");
            case TYPE_MAKEUP_BLUSHER:
                return ByteDancePlugin.getMakeUpOptionItems().get("blush");
            case TYPE_MAKEUP_EYELASH:
                return ByteDancePlugin.getMakeUpOptionItems().get("eyelash");
            case TYPE_MAKEUP_PUPIL:
                return ByteDancePlugin.getMakeUpOptionItems().get("pupil");
            case TYPE_MAKEUP_HAIR:
                return ByteDancePlugin.getMakeUpOptionItems().get("hair");
            case TYPE_MAKEUP_EYESHADOW:
                return ByteDancePlugin.getMakeUpOptionItems().get("eyeshadow");
            case TYPE_MAKEUP_EYEBROW:
                return ByteDancePlugin.getMakeUpOptionItems().get("eyebrow");
            case TYPE_MAKEUP_FACIAL:
                return ByteDancePlugin.getMakeUpOptionItems().get("facial");
            default:
                break;
        }
        return new ArrayList<>();
    }

    //返回的 int 值是用于将特效分类，便于批量关闭某一类特效所做，可用其它方式代替
    private int translateKey2id(String key) {
        switch (key) {
            case "smooth":
                return TYPE_BEAUTY_FACE_SMOOTH;
            case "whiten":
                return TYPE_BEAUTY_FACE_WHITEN;
            case "sharp":
                return TYPE_BEAUTY_FACE_SHARPEN;
            case "BEF_BEAUTY_BRIGHTEN_EYE":
                return TYPE_BEAUTY_FACE_BRIGHTEN_EYE;
            case "BEF_BEAUTY_WHITEN_TEETH":
                return TYPE_BEAUTY_FACE_WHITEN_TEETH;
            case "BEF_BEAUTY_REMOVE_POUCH":
                return TYPE_BEAUTY_FACE_REMOVE_POUCH;
            case "BEF_BEAUTY_SMILES_FOLDS":
                return TYPE_BEAUTY_FACE_SMILE_FOLDS;
            case "Internal_Deform_Overall":
                return TYPE_BEAUTY_RESHAPE_FACE_OVERALL;
            case "Internal_Deform_CutFace":
                return TYPE_BEAUTY_RESHAPE_FACE_CUT;
            case "Internal_Deform_Face":
                return TYPE_BEAUTY_RESHAPE_FACE_SMALL;
            case "Internal_Deform_Eye":
                return TYPE_BEAUTY_RESHAPE_EYE;
            case "Internal_Deform_RotateEye":
                return TYPE_BEAUTY_RESHAPE_EYE_ROTATE;
            case "Internal_Deform_Zoom_Cheekbone":
                return TYPE_BEAUTY_RESHAPE_CHEEK;
            case "Internal_Deform_Zoom_Jawbone":
                return TYPE_BEAUTY_RESHAPE_JAW;
            case "Internal_Deform_Nose":
                return TYPE_BEAUTY_RESHAPE_NOSE_LEAN;
            case "Internal_Deform_MovNose":
                return TYPE_BEAUTY_RESHAPE_NOSE_LONG;
            case "Internal_Deform_Chin":
                return TYPE_BEAUTY_RESHAPE_CHIN;
            case "Internal_Deform_Forehead":
                return TYPE_BEAUTY_RESHAPE_FOREHEAD;
            case "Internal_Deform_ZoomMouth":
                return TYPE_BEAUTY_RESHAPE_MOUTH_ZOOM;
            case "Internal_Deform_MouthCorner":
                return TYPE_BEAUTY_RESHAPE_MOUTH_SMILE;
            case "Internal_Eye_Spacing":
                return TYPE_BEAUTY_RESHAPE_EYE_SPACING;
            case "Internal_Deform_Eye_Move":
                return TYPE_BEAUTY_RESHAPE_EYE_MOVE;
            case "Internal_Deform_MovMouth":
                return TYPE_BEAUTY_RESHAPE_MOUTH_MOVE;
            case "Internal_Makeup_Lips":
                return TYPE_MAKEUP_LIP;
            case "Internal_Makeup_Blusher":
                return TYPE_MAKEUP_BLUSHER;
            case "Internal_Makeup_Pupil":
                return TYPE_MAKEUP_PUPIL;
            case "":
                return TYPE_MAKEUP_HAIR;
            case "Internal_Makeup_Eye":
                return TYPE_MAKEUP_EYESHADOW;
            case "Internal_Makeup_Brow":
                return TYPE_MAKEUP_EYEBROW;
            case "Internal_Makeup_Facial":
                return TYPE_MAKEUP_FACIAL;
            default:
                return -1;
        }
    }


}
