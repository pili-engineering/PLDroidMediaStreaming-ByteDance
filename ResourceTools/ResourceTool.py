# -*- coding: UTF-8 -*-
# #!/usr/bin/python3
import json
import os
import shutil
import sys

# 下面的变量分别对应美颜、微整形、美体、美妆、滤镜特效的初始强度
beauty_intensity = 0.5
reshape_intensity = 0.5
body_intensity = 0.5
makeup_intensity = 0.5
filter_intensity = 0.5

filter_file_name_dict = {'Filter_28_Po6': 'soft', 'Filter_16_13': '胶片', 'Filter_19_37': '红唇', 'Filter_33_L1': '海岛',
                         'Filter_44_S2': '红色复古', 'Filter_29_Po7': '夕阳', 'Filter_02_14': '奶油', 'Filter_45_S3': '旅途',
                         'Filter_20_05': '橘蓝调', 'Filter_40_F3': '加州', 'Filter_35_L3': '浅夏', 'Filter_07_06': '马卡龙',
                         'Filter_10_11': '浅暖', 'Filter_25_Po3': '初见', 'Filter_05_10': '洛丽塔', 'Filter_34_L2': '黑白',
                         'Filter_38_F1': '自然2', 'Filter_27_Po5': '奶茶', 'Filter_43_S1': '美式胶片', 'Filter_26_Po4': '暗调',
                         'Filter_24_Po2': '恋爱超甜', 'Filter_12_08': '北海道', 'Filter_41_F4': '食色', 'Filter_01_38': '柔白',
                         'Filter_42_F5': '川味', 'Filter_37_L5': '红棕', 'Filter_11_09': '物语', 'Filter_21_01': '褪色',
                         'Filter_15_07': '静谧', 'Filter_22_16': '黑白', 'Filter_36_L4': '夜色', 'Filter_03_20': '氧气',
                         'Filter_17_04': '暖阳', 'Filter_13_02': '日杂', 'Filter_14_15': '西雅图', 'Filter_04_12': '桔梗',
                         'Filter_18_18': '旧日', 'Filter_32_Po10': '高级灰', 'Filter_39_F2': '苏打', 'Filter_08_17': '泡沫',
                         'Filter_46_S4': '暖黄', 'Filter_23_Po1': '温柔', 'Filter_09_19': '樱花', 'Filter_31_Po9': '海边人像',
                         'Filter_47_S5': '蓝调胶片', 'Filter_30_Po8': '冷氧', 'Filter_06_03': '蜜桃'}

makeup_file_name_dict = {'weixun': '微醺', 'richang': '日常', 'mitao': '蜜桃', 'tiancheng': '甜橙', 'qiaopi': '俏皮',
                         'xinji': '心机', 'shaishang': '晒伤', 'BR01': 'BRO1', 'BK01': 'BKO1', 'BK02': 'BKO2',
                         'BK03': 'BKO3', 'dadizong': '大地棕', 'wanxiahong': '晚霞红', 'shaonvfen': '少女粉',
                         'qizhifen': '气质粉', 'meizihong': '梅子红', 'jiaotangzong': '焦糖棕', 'yuanqiju': '元气橘',
                         'naichase': '奶茶色', 'xiurong01': '修容01', 'xiurong02': '修容02', 'xiurong03': '修容03',
                         'xiurong04': '修容04', 'anlan': '暗蓝', 'molv': '墨绿', 'shenzong': '深棕', 'fuguhong': '复古红',
                         'xiyouse': '西柚色', 'xiguahong': '西瓜红', 'sironghong': '丝绒红', 'zangjuse': '脏橘色',
                         'meizise': '梅子色', 'shanhuse': '珊瑚色', 'doushafen': '豆沙粉', 'hunxuezong': '混血棕',
                         'kekezong': '可可棕', 'mitaofen': '蜜桃粉', 'shuiguanghei': '水光黑', 'xingkonglan': '星空蓝',
                         'chujianhui': '初见灰'}

makeup_file_key_dict = {'blush': 'Internal_Makeup_Blusher', 'eyebrow': 'Internal_Makeup_Brow',
                        'eyeshadow': 'Internal_Makeup_Eye', 'facial': 'Internal_Makeup_Facial', 'hair': '',
                        'lip': 'Internal_Makeup_Lips', 'pupil': 'Internal_Makeup_Pupil'}

key_name_dict = {'smooth': '磨皮', 'whiten': '美白', 'sharp': '锐化', 'BEF_BEAUTY_BRIGHTEN_EYE': '亮眼',
                 'BEF_BEAUTY_WHITEN_TEETH': '白牙', 'BEF_BEAUTY_REMOVE_POUCH': '黑眼圈', 'BEF_BEAUTY_SMILES_FOLDS': '法令纹',
                 'Internal_Deform_Overall': '瘦脸', 'Internal_Deform_CutFace': '窄脸', 'Internal_Deform_Face': '小脸',
                 'Internal_Deform_Eye': '大眼', 'Internal_Deform_RotateEye': '眼角度',
                 'Internal_Deform_Zoom_Cheekbone': '瘦颧骨', 'Internal_Deform_Zoom_Jawbone': '下颌骨',
                 'Internal_Deform_Nose': '瘦鼻', 'Internal_Deform_MovNose': '长鼻',
                 'Internal_Deform_Chin': '下巴', 'Internal_Deform_Forehead': '额头', 'Internal_Deform_ZoomMouth': '嘴型',
                 'Internal_Deform_MouthCorner': '微笑', 'Internal_Eye_Spacing': '眼距', 'Internal_Deform_Eye_Move': '眼移动',
                 'Internal_Deform_MovMouth': '缩人中', 'Internal_Makeup_Blusher': '腮红', 'Internal_Makeup_Brow': '眉毛',
                 'Internal_Makeup_Eye': '眼影', 'Internal_Makeup_Facial': '修容', '': '染发', 'Internal_Makeup_Lips': '口红',
                 'Internal_Makeup_Pupil': '美瞳', 'BEF_BEAUTY_BODY_LONG_LEG': '长腿', 'BEF_BEAUTY_BODY_THIN': '瘦身'}

key_icon_dict = {'Internal_Deform_Overall': 'cheek.png', 'Internal_Deform_CutFace': 'cut_face.png',
                 'Internal_Deform_Face': 'small_face.png', 'Internal_Deform_Eye': 'eye.png',
                 'Internal_Deform_RotateEye': 'eye_rotate.png', 'Internal_Deform_Zoom_Cheekbone': 'sacrum.png',
                 'Internal_Deform_Zoom_Jawbone': 'jaw.png', 'Internal_Deform_Nose': 'lean_nose.png',
                 'Internal_Deform_MovNose': 'long_nose.png', 'Internal_Deform_Chin': 'chin.png',
                 'Internal_Deform_Forehead': 'forehead.png', 'Internal_Deform_ZoomMouth': 'mouth_zoom.png',
                 'Internal_Deform_MouthCorner': 'mouth_smile.png', 'Internal_Eye_Spacing': 'eye_rotate.png',
                 'Internal_Deform_Eye_Move': 'eye_rotate.png', 'Internal_Deform_MovMouth': 'mouth_zoom.png',
                 'BEF_BEAUTY_BODY_LONG_LEG': 'long_leg.png', 'BEF_BEAUTY_BODY_THIN': 'thin.png', 'smooth': 'smooth.png',
                 'whiten': 'whiten.png', 'sharp': 'sharpen.png', 'BEF_BEAUTY_BRIGHTEN_EYE': 'smooth.png',
                 'BEF_BEAUTY_WHITEN_TEETH': 'smooth.png', 'BEF_BEAUTY_REMOVE_POUCH': 'sharpen.png',
                 'BEF_BEAUTY_SMILES_FOLDS': 'sharpen.png', 'Internal_Makeup_Blusher': 'blush.png',
                 'Internal_Makeup_Brow': 'eyebrow.png', 'Internal_Makeup_Eye': 'eyeshadow.png',
                 'Internal_Makeup_Facial': 'facial.png', '': 'hair.png', 'Internal_Makeup_Lips': 'lip.png',
                 'Internal_Makeup_Pupil': 'pupil.png'}


def show_error_log(msg):
    print("\033[0;31m%s\033[0m" % msg)


def show_warning_log(msg):
    print("\033[0;33m%s\033[0m" % msg)


def show_info_log(msg):
    print("\033[0;32m%s\033[0m" % msg)


def show_verbose_log(msg):
    print("\033[0;37m%s\033[0m" % msg)


def get_filter_name_by_file_name(file_name):
    if file_name in filter_file_name_dict.keys():
        return filter_file_name_dict[file_name]
    show_warning_log('出现了一种未知名称的滤镜特效资源文件 ' + file_name + ' 已用默认名称命名，请稍后修改 FilterResource.bundle/config.json 文件')
    return "默认名称"


def get_makeup_key_by_file_name(file_name):
    if file_name in makeup_file_key_dict.keys():
        return makeup_file_key_dict[file_name]
    show_error_log('出现了一种未知 key 值的美妆特效资源文件 ' + file_name + ' 已用默认 key 值代替，请稍后修改 ComposeMakeup.bundle/config.json 文件')
    return '默认 key 值'


def get_makeup_effect_name_by_file_name(file_name):
    if file_name in makeup_file_name_dict.keys():
        return makeup_file_name_dict[file_name]
    show_error_log('出现了一种未知名称的美妆特效资源文件 ' + file_name + ' 已用默认名称命名，请稍后修改 ComposeMakeup.bundle/config.json 文件')
    return '默认名称'


def get_composer_effect_name_by_key(key):
    if key in key_name_dict.keys():
        return key_name_dict[key]
    show_warning_log('出现了一种未知名称的特效资源文件,已用默认名称命名，请稍后修改 ComposeMakeup.bundle/config.json 文件')
    return '默认名称'


def get_icon_name_by_key(key):
    if key in key_icon_dict.keys():
        return key_icon_dict[key]
    show_warning_log(
        '与 key = ' + key + ' 对应的 icon 没有找到，使用 none.png 代替，请稍后修改 ComposeMakeup.bundle/config.json 文件并在 icons 文件夹中添加正确的 icon')
    return 'none.png'


def deal_filter():
    filter_root_dir = './resource/FilterResource.bundle'
    if not os.path.exists(filter_root_dir):
        return
    show_verbose_log('开始配置滤镜资源文件。。。。。。')
    content = []
    filter_res_dir = filter_root_dir + '/Filter'
    filter_icon_dir = filter_root_dir + '/icons'
    filter_img_dir = './images/filter'
    default_icon_name = 'none.png'
    if not os.path.exists(filter_icon_dir):
        os.mkdir(filter_icon_dir)
    for file_name in os.listdir(filter_res_dir):
        if not file_name.startswith('Filter'):
            continue
        icon_name = file_name + '.png'
        if icon_name not in os.listdir(filter_img_dir):
            icon_name = default_icon_name
        src = filter_img_dir + '/' + icon_name
        dst = filter_icon_dir + '/' + icon_name
        shutil.copyfile(src, dst)
        filter_dict = {'filePath': 'Filter/' + file_name, 'iconName': icon_name,
                       'displayName': get_filter_name_by_file_name(file_name), 'defaultIntensity': filter_intensity}
        content.append(filter_dict)
    with open(filter_root_dir + '/config.json', 'w') as file:
        json.dump(content, file, ensure_ascii=False, indent=4)
    show_info_log('已完成滤镜资源文件的配置')


def deal_sticker():
    sticker_root_dir = './resource/StickerResource.bundle'
    if not os.path.exists(sticker_root_dir):
        return
    show_verbose_log('开始配置动态贴纸资源文件。。。。。。')
    content = []
    sticker_res_dir = sticker_root_dir + '/stickers'
    sticker_icon_dir = sticker_root_dir + '/icons'
    sticker_img_dir = './icons'
    default_icon_name = 'none.png'
    if not os.path.exists(sticker_icon_dir):
        os.mkdir(sticker_icon_dir)
    for file_name in os.listdir(sticker_res_dir):
        if file_name.startswith('.DS_Store'):
            continue
        is_success = False
        icon_name = '默认名称'
        tip = ''
        pinyin = ''
        for icon_dir_name in os.listdir(sticker_img_dir):
            if icon_dir_name.startswith('.DS_Store'):
                continue
            if icon_dir_name.split('（').__len__() > 1:
                icon_name = icon_dir_name.split('（')[0]
                tip = icon_dir_name.split('（')[1].replace('）', '')
            else:
                icon_name = icon_dir_name
                tip = icon_dir_name
            for item in lazy_pinyin(icon_name):
                pinyin += item
            if pinyin == file_name:
                is_success = True
                icon_dir = sticker_img_dir + '/' + icon_dir_name
                icon_file_name = os.listdir(icon_dir)[0]
                if not icon_file_name.endswith('.png'):
                    icon_file_name = os.listdir(icon_dir)[1]
                icon_path = icon_dir + '/' + icon_file_name
                dst = sticker_icon_dir + '/' + pinyin + '.png'
                shutil.copyfile(icon_path, dst)
                break
            else:
                icon_name = '默认贴纸名称'
                tip = ''
                pinyin = ''
        if not is_success:
            show_warning_log(
                file_name + ' 这个贴纸没有找到对应的图标,请自行前往 StickerResource.bundle/icons 中更换 '
                + file_name + '.png 文件并修改 StickerResource.bundle/config.json 中的贴纸名称')
            icon_dir = './images/sticker'
            icon_path = icon_dir + '/' + default_icon_name
            dst = sticker_icon_dir + '/' + file_name + '.png'
            shutil.copyfile(icon_path, dst)
        temp_dict = {'filePath': 'stickers/' + file_name, 'iconName': file_name + '.png',
                     'displayName': icon_name, 'tip': tip}
        content.append(temp_dict)
    with open(sticker_root_dir + '/config.json', 'w') as file:
        json.dump(content, file, ensure_ascii=False, indent=4)
    show_info_log('已完成动态贴纸资源文件的配置')


def deal_compose_makeup():
    compose_root_dir = './resource/ComposeMakeup.bundle'
    if not os.path.exists(compose_root_dir):
        return
    compose_icon_dir = compose_root_dir + '/icons'
    if not os.path.exists(compose_icon_dir):
        os.mkdir(compose_icon_dir)
    content = {}
    deal_beauty(compose_root_dir, content)
    deal_reshape(compose_root_dir, content)
    deal_body(compose_root_dir, content)
    deal_makeup(compose_root_dir, content)
    with open(compose_root_dir + '/config.json', 'w') as file:
        json.dump(content, file, ensure_ascii=False, indent=4)


def deal_beauty(compose_root_dir, content):
    show_verbose_log('开始配置美颜资源文件。。。。。。')
    compose_dir = compose_root_dir + '/ComposeMakeup'
    compose_icon_dir = compose_root_dir + '/icons'
    beauty = []
    for dir_name in os.listdir(compose_dir):
        if dir_name.lower().find('beauty') > -1 and dir_name.lower().find(system) > -1:
            config_path = compose_dir + '/' + dir_name + '/.config_file'
            with open(config_path) as file:
                json_keys = json.load(file)
            for key in json_keys:
                icon_name = get_icon_name_by_key(key)
                effect_name = get_composer_effect_name_by_key(key)
                icon_src_path = './images/beauty/' + icon_name
                icon_dst_path = compose_icon_dir + '/' + icon_name
                shutil.copyfile(icon_src_path, icon_dst_path)
                beauty_dict = {'filePath': 'ComposeMakeup/' + dir_name, 'iconName': icon_name,
                               'displayName': effect_name, 'key': key, 'defaultIntensity': beauty_intensity}
                beauty.append(beauty_dict)
    content['beauty'] = beauty
    show_info_log('已完成美颜资源文件的配置')


def deal_reshape(compose_root_dir, content):
    show_verbose_log('开始配置微整形资源文件。。。。。。')
    compose_dir = compose_root_dir + '/ComposeMakeup'
    compose_icon_dir = compose_root_dir + '/icons'
    reshape = []
    for dir_name in os.listdir(compose_dir):
        if dir_name.lower().find('reshape') > -1 or dir_name.lower().find('4items') > -1:
            config_path = compose_dir + '/' + dir_name + '/.config_file'
            with open(config_path) as file:
                json_keys = json.load(file)
            for key in json_keys:
                icon_name = get_icon_name_by_key(key)
                effect_name = get_composer_effect_name_by_key(key)
                icon_src_path = './images/reshape/' + icon_name
                icon_dst_path = compose_icon_dir + '/' + icon_name
                shutil.copyfile(icon_src_path, icon_dst_path)
                reshape_dict = {'filePath': 'ComposeMakeup/' + dir_name, 'iconName': icon_name,
                                'displayName': effect_name, 'key': key, 'defaultIntensity': reshape_intensity}
                reshape.append(reshape_dict)
    content['reshape'] = reshape
    show_info_log('已完成微整形资源文件的配置')


def deal_body(compose_root_dir, content):
    compose_dir = compose_root_dir + '/ComposeMakeup'
    compose_icon_dir = compose_root_dir + '/icons'
    allslimqy_path = compose_dir + '/body/allslimqy'
    config_path = allslimqy_path + '/.config_file'
    body = []
    if not os.path.exists(config_path):
        return
    show_verbose_log('开始配置美体资源文件。。。。。。')
    with open(config_path) as file:
        json_keys = json.load(file)
    for key in json_keys:
        icon_name = get_icon_name_by_key(key)
        effect_name = get_composer_effect_name_by_key(key)
        icon_src_path = './images/body/' + icon_name
        icon_dst_path = compose_icon_dir + '/' + icon_name
        shutil.copyfile(icon_src_path, icon_dst_path)
        body_dict = {'filePath': 'ComposeMakeup/body/allslimqy', 'iconName': icon_name,
                     'displayName': effect_name, 'key': key, 'defaultIntensity': body_intensity}
        body.append(body_dict)
    content['body'] = body
    show_info_log('已完成美体资源文件的配置')


def deal_makeup(compose_root_dir, content):
    compose_dir = compose_root_dir + '/ComposeMakeup'
    compose_icon_dir = compose_root_dir + '/icons'
    file_names = os.listdir(compose_dir)
    ignore_file_names = {'beauty_Android_live', 'beauty_Android_camera', 'beauty_4Items', 'beauty_IOS_live',
                         'beauty_IOS_camera', 'reshape_live', 'reshape_camera', 'body', 'composer'}
    makeup_file_names = [file_name for file_name in file_names if file_name not in ignore_file_names]
    makeup = {}
    if makeup_file_names.__len__() > 0:
        show_verbose_log('开始配置美妆资源文件。。。。。。')
    for makeup_file_name in makeup_file_names:
        effect_dir = compose_dir + '/' + makeup_file_name
        icon_name = makeup_file_name + '.png'
        icon_src_path = './images/makeup/' + icon_name
        icon_dst_path = compose_icon_dir + '/' + icon_name
        shutil.copyfile(icon_src_path, icon_dst_path)
        key = get_makeup_key_by_file_name(makeup_file_name)
        effect_class_name = get_composer_effect_name_by_key(key)
        effect_type = {'displayName': effect_class_name, 'iconName': icon_name}
        effect = []
        for name in os.listdir(effect_dir):
            file_name = 'ComposeMakeup/' + makeup_file_name + '/' + name
            icon_name = makeup_file_name + '_' + name + '.png'
            icon_dst_path = compose_icon_dir + '/' + icon_name
            shutil.copyfile(icon_src_path, icon_dst_path)
            effect_dict = {'filePath': file_name, 'iconName': icon_name,
                           'displayName': get_makeup_effect_name_by_file_name(name), 'key': key,
                           'defaultIntensity': makeup_intensity}
            effect.append(effect_dict)
        effect_type['effects'] = effect
        makeup[makeup_file_name] = effect_type
    content['makeup'] = makeup
    show_info_log('已完成美妆资源文件的配置')


system = 'android'

if __name__ == '__main__':
    file_descriptor = os.popen('pip list')
    if file_descriptor.read().find('pypinyin') == -1:
        os.system('pip install pypinyin')
    if sys.argv.__len__() > 1:
        system = sys.argv[1].lower()
    from pypinyin import lazy_pinyin

    show_verbose_log('开始配置资源文件。。。。。。')
    deal_filter()
    deal_sticker()
    deal_compose_makeup()
    show_info_log('已完成所有资源的配置！')
