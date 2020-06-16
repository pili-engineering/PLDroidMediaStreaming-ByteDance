precision highp float;

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;


uniform vec2 resolution;
uniform vec2 resolution_inv;
uniform int orient;

// HeadSlim

// debug 
uniform float ratio_flag;
// uniform mat4 head_param;
// uniform vec4 head_centre_n_scale;

// #define head_cross_point_param_x head_param[0]
// #define head_cross_point_param_y head_param[3]

// #define head_x_vec head_param[0].xy
// #define head_y_vec head_param[0].zw

// #define head_left head_param[1][0]
// #define head_right head_param[1][1]
// #define head_top head_param[1][2]
// #define head_bottom head_param[1][3]

// #define head_x_min head_param[2][0]
// #define head_x_max head_param[2][1]
// #define head_y_min head_param[2][2]
// #define head_y_max head_param[2][3]

// #define head_center_point head_centre_n_scale.xy
// #define head_scale head_centre_n_scale.z


// WholeBodySlim
uniform mat4 whole_body_param;
uniform mat4 whole_body_centre_n_scale;

// #define whole_body_x_vec whole_body_param[0].xy
// #define whole_body_y_vec whole_body_param[0].zw

#define whole_body_cross_point_param_x whole_body_param[0] 
#define whole_body_cross_point_param_y whole_body_param[3]

#define whole_body_left whole_body_param[1][0]
#define whole_body_right whole_body_param[1][1]
#define whole_body_top whole_body_param[1][2]
#define whole_body_bottom whole_body_param[1][3]

#define whole_body_x_min whole_body_param[2][0]
#define whole_body_x_max whole_body_param[2][1]
#define whole_body_y_min whole_body_param[2][2]
#define whole_body_y_max whole_body_param[2][3]

#define whole_body_top_point whole_body_centre_n_scale[1].xy
#define whole_body_bottom_point whole_body_centre_n_scale[1].zw

#define whole_body_center_point whole_body_centre_n_scale[2].xy
#define whole_body_scale whole_body_centre_n_scale[2][2]

// StretchLegsSlim
uniform mat4 stretch_legs_param;
uniform vec4 stretch_legs_centre_n_scale;
uniform vec4 stretch_legs_process_param;

#define stretch_legs_cross_point_param_x stretch_legs_param[0]
#define stretch_legs_cross_point_param_y stretch_legs_param[3]

// #define stretch_legs_x_vec stretch_legs_param[0].xy
// #define stretch_legs_y_vec stretch_legs_param[0].zw

#define stretch_legs_left stretch_legs_param[1][0]
#define stretch_legs_right stretch_legs_param[1][1]
#define stretch_legs_top stretch_legs_param[1][2]
#define stretch_legs_bottom stretch_legs_param[1][3]

#define stretch_legs_x_min stretch_legs_param[2][0]
#define stretch_legs_x_max stretch_legs_param[2][1]
#define stretch_legs_y_min stretch_legs_param[2][2]
#define stretch_legs_y_max stretch_legs_param[2][3]


// #define stretch_legs_center_point stretch_legs_param[3].xy
// #define stretch_legs_scale stretch_legs_param[3][2]
// #define stretch_legs_waist_bottom stretch_legs_param[3][3]



#define stretch_legs_center_point stretch_legs_centre_n_scale.xy
#define stretch_legs_scale stretch_legs_centre_n_scale.z
#define stretch_legs_waist_bottom stretch_legs_centre_n_scale.w
#define stretch_legs_waist_scale legs_centre_n_scale.w

vec2 get_vertical_cross_point_by_vec_simplify(vec4 cross_point_param, vec2 target_point)
{
    vec2 res = vec2(0.0, 0.0);

    //A2 * inv_A2plusB2 
    float a = cross_point_param.x;
    //AB * inv_A2plusB2 
    float b = cross_point_param.y;
    //AC * inv_A2plusB2 
    float c = cross_point_param.z;
    //BC * inv_A2plusB2 
    float d = cross_point_param.w;
    //B2 * inv_A2plusB2 
    float e = 1.0 - a;


     res.x  =  e * target_point.x - b * target_point.y - c ;
     res.y  =  a * target_point.y - b * target_point.x - d ;

    return res;
}

vec2 processing_v2(vec2 coor, float ori_target_x_ratio, float ori_max_x_ratio, float ori_target_y_ratio, float ori_max_y_ratio, float left, float right, float top, float bottom, float x_min, float x_max, float y_min, float y_max, 
                    vec2 center_point, vec4 cross_point_param_x, vec4 cross_point_param_y, int mode, float height, float width, int direction, int line_type, int transition_type, float ratio_flag)
{
    // mode 0 x 方向; 1 y方向; 2 x y 方向
    // direction 0 什么都不做。 1 x方向全部受到最大影响， 2 y方向全部受到最大影响
    // line_type 0 线性 1 非线性
    // transition_type 0 线性 1非线性
    // ratio_flag 画图用
    //#ifdef DEBUG_FLAG
    vec2 hehe = vec2(1., 1.0);
    vec2 res = vec2(-1.0, -1.0);
    
    if(ori_target_x_ratio == 1.0 && ori_target_y_ratio == 1.0)
    {
        return coor;
    }
    float coor_x = coor.x, coor_y = coor.y;
    
    
    if(direction == 0)
    {
        /*if(!(coor.x > x_min && coor.x < x_max && coor.y > y_min && coor.y < y_max))    
         if((step(x_min, coor.x) * step(coor.x, x_max) * step(y_min, coor.y) * step(coor.y, y_max)) != 1.0)*/
        if(coor.x <= x_min || coor.x >= x_max || coor.y <= y_min || coor.y >= y_max)
        {
            // if(ratio_flag == 1.)
            // {
            //     return hehe;
            // }
            // else
            // {
                return coor;
            // }
        }
    }
    else if(direction == 1)
    {
        if(coor.y <= y_min || coor.y >= y_max)
        {
                return coor;
        }
    }
    else
    {
        if(coor.x <= x_min || coor.x >= x_max)
        {
           return coor;
        }
    }
    float target_x_ratio = ori_target_x_ratio;
    float target_y_ratio = ori_target_y_ratio;
    float max_x_ratio = ori_max_x_ratio;
    float max_y_ratio = ori_max_y_ratio;
    
    float top_height = top;
    float bottom_height = bottom;
    float left_width = left;
    float right_width = right;
    float x_length = -1.0;
    float y_length = -1.0;
    float normal_ratio = 1.0;
    
    float offset_x_ratio, offset_y_ratio, offset_x_ratio2, offset_y_ratio2;
    
    // vec2 x_cross_point = get_vertical_cross_point_by_vec(center_point, x_vec, coor);
    vec2 x_cross_point = get_vertical_cross_point_by_vec_simplify(cross_point_param_x, coor);
    if(x_cross_point.x == -1.0)
    {
      return coor;
    }
    
    float offset_x = x_cross_point.x - center_point.x;
    
    // vec2 y_cross_point = get_vertical_cross_point_by_vec(center_point, y_vec, coor);
    vec2 y_cross_point = get_vertical_cross_point_by_vec_simplify(cross_point_param_y, coor);
    if(y_cross_point.x == -1.0)
    {
        return coor;
    }
    
    float offset_y = y_cross_point.y - center_point.y;
    
    vec2 mapped_vec;
    mapped_vec.x = 0.;
    mapped_vec.y = 0.;
    
    float tmp_width = (offset_x <= 0.) ? left_width : right_width;
    offset_x = distance(x_cross_point, center_point);
    offset_x_ratio = (tmp_width == 0.) ? 1.0 : offset_x / tmp_width;
    x_length = tmp_width;
    offset_x_ratio = offset_x_ratio > 1.0 ? 1.0 : offset_x_ratio;
    offset_x_ratio2 = offset_x_ratio * offset_x_ratio;
    
    float tmp_height = (offset_y <= 0.) ? top_height : bottom_height;
    offset_y = distance(y_cross_point, center_point);
    offset_y_ratio = (tmp_height == 0.) ? 1.0 : offset_y / tmp_height;
    y_length = tmp_height;
    offset_y_ratio = offset_y_ratio > 1.0 ? 1.0 : offset_y_ratio;
    offset_y_ratio2 = offset_y_ratio * offset_y_ratio;
    
    float tmp_max_x_ratio, tmp_max_y_ratio, x_ratio, y_ratio, length_ratio, u, v;
    vec2 uv;
    
    if(mode == 0 || mode == 2)
    {
        if(direction == 2)
        {
            offset_y_ratio = 0.;
            offset_y_ratio2 = 0.;
        }
        if(transition_type == 1)
        {
            tmp_max_x_ratio = target_x_ratio - (target_x_ratio - normal_ratio) * offset_y_ratio2;
        }
        else
        {
            tmp_max_x_ratio = target_x_ratio - (target_x_ratio - normal_ratio) * offset_y_ratio;
        }
        if(line_type == 1)
        {
            x_ratio = tmp_max_x_ratio - (tmp_max_x_ratio - normal_ratio) * mix(offset_x_ratio2, 1., offset_x_ratio); //
        }
        else
        {
            x_ratio = tmp_max_x_ratio - (tmp_max_x_ratio - normal_ratio) * offset_x_ratio;
        }
        x_ratio = (max_x_ratio > 1.0) ? ((x_ratio > max_x_ratio) ? max_x_ratio : x_ratio)  : ((x_ratio > max_x_ratio) ? x_ratio : max_x_ratio);
        uv = x_ratio * (coor - y_cross_point) + y_cross_point;
    }
    else
    {
        x_ratio = 1.0;
        uv = coor;
    }
    mapped_vec += uv - coor; 
    
    if(mode == 1 || mode == 2)
    {
        if(direction == 1)
        {
            offset_x_ratio = 0.;
            offset_x_ratio2 = 0.;
        }
        if(transition_type == 1)
        {
            tmp_max_y_ratio = target_y_ratio - (target_y_ratio - normal_ratio) * offset_x_ratio2;
        }
        else
        {
            tmp_max_y_ratio = target_y_ratio - (target_y_ratio - normal_ratio) * offset_x_ratio;
        }
        if(line_type == 1)
        {
            y_ratio = tmp_max_y_ratio - (tmp_max_y_ratio - normal_ratio) * mix(offset_y_ratio2, 1., offset_y_ratio);
        }
        else
        {
            y_ratio = tmp_max_y_ratio - (tmp_max_y_ratio - normal_ratio) * offset_y_ratio;
        }
        y_ratio = (max_y_ratio > 1.0) ? ((y_ratio > max_y_ratio) ? max_y_ratio : y_ratio)  : ((y_ratio > max_y_ratio) ? y_ratio : max_y_ratio);
        uv = y_ratio * (coor - x_cross_point) + x_cross_point;
    }
    else
    {
        y_ratio = 1.0;
        uv = coor;
    }
    
    mapped_vec += uv - coor;
    
    res = mapped_vec + coor;

    
    // if(ratio_flag == 1.)
    // {
    //     if(max_x_ratio != 1.0)
    //     {
    //         res.x = 1.0 - (1.0 - x_ratio) / (1.0 - max_x_ratio);
    //     }
    //     else
    //     {
    //         res.x = 1.0;
    //     }
    //     if(max_y_ratio != 1.0)
    //     {
    //         res.y = 1.0 - (1.0 - y_ratio) / (1.0 - max_y_ratio);
    //     }
    //     else
    //     {
    //         res.y = 1.0;
    //     }
    //     //res.x = 0.5;
    //     //res.y = 0.5;
    // }
    return res;
}


vec2 whole_body_processing(vec2 coor, float ori_target_x_ratio, float ori_max_x_ratio, float ori_target_y_ratio, float ori_max_y_ratio, float left, float right, float top, float bottom, float x_min, float x_max, float y_min, float y_max, 
    vec2 center_point, vec4 cross_point_param_x, vec4 cross_point_param_y, vec2 top_point, vec2 bottom_point , int mode, float height, float width, float ratio_flag)
{
    if(ori_target_x_ratio == 1.)
    {
        return coor;
    }
    float target_x_ratio = ori_target_x_ratio;
    float target_y_ratio = ori_target_y_ratio;
    float max_x_ratio = ori_max_x_ratio;
    float max_y_ratio = ori_max_y_ratio;
    vec2 res = coor;
    
     //Note: left_point,right_point not using
    // vec2 left_point = center_point - left * x_vec;
    // vec2 right_point = center_point + right * x_vec;

    // vec2 top_point = center_point - top * y_vec;
    // vec2 bottom_point = center_point + bottom * y_vec;

    float retain_ratio = 0., offset_y, offset_y_ratio, offset_y_ratio2, retain_radiu, retain_num, max_retain_num;
    
    //Note: x_cross_point not using
    // vec2 x_cross_point = get_vertical_cross_point_by_vec(center_point, x_vec, coor);

    // vec2 y_cross_point = get_vertical_cross_point_by_vec(center_point, y_vec, coor);
     vec2 y_cross_point = get_vertical_cross_point_by_vec_simplify(cross_point_param_y, coor);
    
    if(!(coor.y > top_point.y && coor.y < bottom_point.y))
    {
        retain_ratio = 0.;
    }
    else
    {
        offset_y = distance(y_cross_point, center_point);
        offset_y_ratio = (y_cross_point.y < center_point.y) ? offset_y / top: offset_y / bottom;
        retain_ratio =  1. - offset_y_ratio;
        retain_ratio = min(retain_ratio, 1.); // 
        // retain_ratio = retain_ratio > 0.45 ? 0.45 : retain_ratio;
    }
    
    float length = (left > right) ? right : left;

    float left_ori_num = center_point.x;
    float right_ori_num = width - center_point.x;

    float ori_half_length = min(left_ori_num, right_ori_num);
    int left_or_right;
    if(left_ori_num > right_ori_num)
    {
        left_or_right = 1;
    }
    else
    {
        left_or_right = 0;
    }
    float enlarge_ratio = 1.5;
    length = length * enlarge_ratio;
    retain_radiu = length * 1. / enlarge_ratio;
    retain_num = retain_radiu * retain_ratio;
    max_retain_num = retain_radiu;
    
    float split_ratio = 0.6; // 0.5
    float left1_ori_num, left2_ori_num, right1_ori_num, right2_ori_num;
    float left1_tmp_num, left2_tmp_num, right1_tmp_num, right2_tmp_num;

    float left_ratio, right_ratio;
    left_ratio = (left != 0.) ? (left_ori_num - left) / left : 0.;
    right_ratio = (right != 0.) ? (right_ori_num - right) / right : 0.;
    float final_ratio = clamp(min(left_ratio, right_ratio), 0., 1.);
    final_ratio = 1.;
    target_x_ratio = (target_x_ratio - 1.) * final_ratio + 1.;

    // left2_ori_num = left - retain_num;
    // left1_ori_num = left_ori_num - left2_ori_num - retain_num;
    
    // right2_ori_num = right - retain_num;
    // right1_ori_num = right_ori_num - right2_ori_num - retain_num;

    // left2_tmp_num = left * target_x_ratio - retain_num;
    // left1_tmp_num = left_ori_num - left2_tmp_num - retain_num;

    // right2_tmp_num = right * target_x_ratio - retain_num;
    // right1_tmp_num = right_ori_num - right2_tmp_num - retain_num;

    if(left_or_right == 0)
    {
        left1_ori_num = (ori_half_length - max_retain_num) * split_ratio;
        left2_ori_num = left_ori_num - left1_ori_num - retain_num;
        
        right2_ori_num = left1_ori_num + max_retain_num - retain_num;
        right1_ori_num = right_ori_num - right2_ori_num - retain_num;

        left2_tmp_num = left2_ori_num - left1_ori_num * (1. - target_x_ratio) ; // 0.9 * 0.5
        left1_tmp_num = left_ori_num - left2_tmp_num - retain_num;

        right2_tmp_num = right2_ori_num - left1_ori_num * (1. - target_x_ratio); // 0.9 * 0.5
        right1_tmp_num = right_ori_num - right2_tmp_num - retain_num;
    }
    else
    {
        right1_ori_num =  (ori_half_length - max_retain_num) * split_ratio;
        right2_ori_num =  right_ori_num - right1_ori_num - retain_num;

        left2_ori_num =  right1_ori_num + max_retain_num - retain_num;
        left1_ori_num =  left_ori_num - left2_ori_num - retain_num;

        right2_tmp_num = right2_ori_num - right1_ori_num * (1. - target_x_ratio) ; // 0.9 * 0.5
        right1_tmp_num = right_ori_num - right2_tmp_num - retain_num;

        left2_tmp_num = left2_ori_num - right1_ori_num * (1. - target_x_ratio) ; // 0.9 * 0.5
        left1_tmp_num = left_ori_num - left2_tmp_num - retain_num;
    }




    
    // float left1_tmp_num = left1_ori_num * (1. + 1. - target_x_ratio);
    // float left2_tmp_num = left_ori_num - left1_tmp_num - retain_num; // 0.9 * 0.5

    // float left2_tmp_num = (left2_ori_num + retain_num) * target_x_ratio - retain_num; // 0.9 * 0.5
    // float left1_tmp_num = left_ori_num - left2_tmp_num - retain_num;
    // float left2_tmp_num = left2_ori_num * target_x_ratio; // 0.9 * 0.5
    // float left1_tmp_num = left_ori_num - left2_tmp_num - retain_num;

    // float right1_tmp_num = right1_ori_num * (1. + 1. - target_x_ratio);
    // float right2_tmp_num = right_ori_num - right1_tmp_num - retain_num; // 0.9 * 0.5

    // float right2_tmp_num = (right2_ori_num + retain_num)* target_x_ratio - retain_num;
    // float right1_tmp_num = right_ori_num - right2_tmp_num - retain_num;
    // float right2_tmp_num = right * target_x_ratio;
    // float right1_tmp_num = right_ori_num - right2_tmp_num - retain_num;

    float left1_gap = (left1_tmp_num != 0.) ? left1_ori_num / left1_tmp_num : 1.;
    float left2_gap = (left2_tmp_num != 0.) ? left2_ori_num / left2_tmp_num : 1.;
    float right1_gap = (right1_tmp_num != 0.) ? right1_ori_num / right1_tmp_num : 1.;
    float right2_gap = (right2_tmp_num != 0.) ? right2_ori_num / right2_tmp_num : 1.;

    //    left2_gap = target_x_ratio != 0. ? 1. / target_x_ratio : 1.;
    float sp_gap = target_x_ratio != 0. ? 1. / target_x_ratio : 1.;

    float add_num, sp_ratio = 0.85; // 1 区域分成 1 2 0.5
    add_num = left1_tmp_num - left1_ori_num;
    //    (left1_tmp_num * sp_ratio * (x + 1.)) / 2 + (left1_tmp_num * (1. - sp_ratio) * (left2_gap + 1.)) / 2 = left1_ori_num
    float left_end_gap = (2. * left1_ori_num - left1_tmp_num * (1. - sp_ratio) * (sp_gap + 1.)) / (left1_tmp_num * sp_ratio) - 1.;
    
    float right_end_gap = (2. * right1_ori_num - right1_tmp_num * (1. - sp_ratio) * (sp_gap + 1.)) / (right1_tmp_num * sp_ratio) - 1.;
    
    float left1_tmp_num_phase1 = left1_tmp_num * sp_ratio;
    float left1_tmp_num_phase2 = left1_tmp_num - left1_tmp_num_phase1;
    
    float right1_tmp_num_phase1 = right1_tmp_num * sp_ratio;
    float right1_tmp_num_phase2 = right1_tmp_num - right1_tmp_num_phase1;
    
    float accum_sum, u, v;
    
    
    float tmp_float, my_tmp = 0.33;
    tmp_float = left1_tmp_num;
    float state_1 = tmp_float < coor.x ? 1. : 0.;
    tmp_float += left2_tmp_num;
    float state_2 = tmp_float < coor.x ? 1. : 0.;//step(left1_tmp_num + left2_tmp_num, coor.x);
    tmp_float = left_ori_num;
    float state_3 = tmp_float < coor.x ? 1. : 0.;
    tmp_float += retain_num;
    float state_4 = tmp_float < coor.x ? 1. : 0.;
    tmp_float += right2_tmp_num;
    float state_5 = tmp_float <  coor.x ? 1. : 0.;
    
    // if(state_5 == 1.)
    // {
    //     my_tmp = 0.33;
    // }
    // else if(state_4 == 1.)
    // {
    //     my_tmp = 0.5;
    // }
    // else if(state_3 == 1.)
    // {
    //     my_tmp = 0.75;
    // }
    // else if(state_2 == 1.)
    // {
    //     my_tmp = 0.75;
    // }
    // else if(state_1 == 1.)
    // {
    //     my_tmp = 0.5;
    // }


    accum_sum = state_1 * left1_ori_num + state_2 * left2_ori_num + state_3 * retain_num + state_4 * retain_num + state_5 * right2_ori_num;
    float start_region = state_1 * left1_tmp_num + state_2 * left2_tmp_num + state_3 * retain_num + state_4 * retain_num + state_5 * right2_tmp_num;
    float tmp_shift;
    if(state_5 == 1.)
    {
        if(start_region + right1_tmp_num_phase2 < coor.x)
        {
            float tmp_num = right1_tmp_num_phase2 * (sp_gap + 1.) * 0.5;
            //            float tmp_num = right1_tmp_num_phase2;
            float tmp_gap = (right1_tmp_num_phase1 != 0.) ? ((right_end_gap - 1.) / right1_tmp_num_phase1 * (coor.x - start_region - right1_tmp_num_phase2) + 1.): 1.;
            tmp_shift = tmp_num + (coor.x - start_region - right1_tmp_num_phase2) * (1. + tmp_gap) * 0.5;
        }
        else
        {
            float tmp_num = 0.;
            float tmp_gap = (right1_tmp_num_phase2 != 0.) ? ((1. - sp_gap) / right1_tmp_num_phase2 * (coor.x - start_region - tmp_num) + sp_gap) : 1.;
            tmp_shift = tmp_num + (coor.x - start_region - tmp_num) * (sp_gap + tmp_gap) * 0.5;
        }
        //        tmp_shift = right1_gap * (coor.x - start_region);
    }
    else if(state_4 == 1.)
    {
        tmp_shift = (coor.x - start_region) * right2_gap;
    }
    else if(state_3 == 1.)
    {
        tmp_shift = 1. * (coor.x - start_region);
    }
    else if(state_2 == 1.)
    {
        tmp_shift = 1. * (coor.x - start_region);
    }
    else if(state_1 == 1.)
    {
        tmp_shift = left2_gap * (coor.x - start_region);
    }
    else
    {
        //        tmp_shift = left1_gap;
        if(start_region + left1_tmp_num_phase1 < coor.x)
        {
            float tmp_num = left1_tmp_num_phase1 * (left_end_gap + 1.) * 0.5;
            //            float tmp_num = left1_tmp_num_phase1;
            float tmp_gap = (left1_tmp_num_phase2 != 0.) ? ((sp_gap - 1.) / left1_tmp_num_phase2 * (coor.x - start_region - left1_tmp_num_phase1) + 1.): 1.;
            tmp_shift = tmp_num + (coor.x - start_region - left1_tmp_num_phase1) * (1. + tmp_gap) * 0.5;
        }
        else
        {
            float tmp_num = 0.;
            float tmp_gap = (left1_tmp_num_phase1 != 0.) ? ((1. - left_end_gap) / left1_tmp_num_phase1 * (coor.x - start_region - tmp_num) + left_end_gap) : 1.;
            tmp_shift = tmp_num + (coor.x - start_region - tmp_num) * (left_end_gap + tmp_gap) * 0.5;
        }
        //        tmp_shift = left1_gap * (coor.x - start_region);
    }
    res.x = tmp_shift + accum_sum;
    // res.x = my_tmp;
    return res;
}

vec2 stretch_processing_simplify(vec2 coor, float top, float bottom, vec2 center_point, vec4 process_param)
{
    vec2 res = coor;
    float top_pos = center_point.y - top;
    if(coor.y < top_pos)
    {
        return res;
    }
    float top_region_ori_num = top;
    float bottom_region_ori_num = bottom;

    float top_region_tmp_num = process_param.x;
    float bottom_region_tmp_num = process_param.y;
    float top_region_gap  = process_param.z;
    float bottom_region_gap = process_param.w;
      
    float state_1 = (top_region_tmp_num + top_pos) < coor.y ? 1.0 : 0.;
    float state_2 = (top_region_tmp_num + bottom_region_tmp_num + top_pos) < coor.y ? 1.0 : 0.;
    float accum = top_pos + top_region_ori_num * state_1 + bottom_region_ori_num * state_2;
    float start_region = top_pos + top_region_tmp_num * state_1 + bottom_region_tmp_num * state_2;
    float tmp_gap;
    
    if(state_2 == 1.0)
    {
        tmp_gap = 1.0;
    }
    else if(state_1 == 1.0)
    {
        tmp_gap = bottom_region_gap;
    }
    else
    {
        tmp_gap = top_region_gap;
    }
    
    float y_pos = tmp_gap * (coor.y - start_region) + accum;
    
    res.y = y_pos;

    return res;
}

void main() {

    vec2 texToUse = textureCoordinate;
    vec2 coor = texToUse;
    
    // debug
    float factor = 1.0, factor1 = 1.0, factor2 = 1.0;
    if(orient == 0) {
        coor = texToUse;
    } else if (orient == 1) {
        coor = vec2(1.0 - texToUse.y, texToUse.x);
    } else if (orient == 2) {
        coor = vec2(1.0 - texToUse.x,1.0 - texToUse.y);
    } else {
        coor = vec2(texToUse.y,1.0 - texToUse.x);
    }

    float width = resolution.x;
    float height = resolution.y;
    // float ratio_flag = 1.0;

    coor = coor * resolution;
    // coor.x = coor.x * (width - 0.);
    // coor.y = coor.y * (height - 0.);
    vec2 center_point, coor_res;
    float target_x_ratio;
    float max_x_ratio;
    int direction = 0;
    int line_type = 1;
    float target_y_ratio = 1.0;
    float max_y_ratio = 1.0;
    float left, right, top, bottom, x_min, x_max, y_min, y_max;
    int mode = 0, transition_type = 1;
    
    vec2 vec_record = vec2(0., 0.);



    // WholeBody
    if(whole_body_scale != 1.0)
    {
        target_x_ratio = whole_body_scale; // 0.9
        max_x_ratio = (1.0 - target_x_ratio) * 1.0 + target_x_ratio;
        target_y_ratio = 1.0;
        max_y_ratio = (1.0 - target_y_ratio) * 1.0 + target_y_ratio;
        center_point = whole_body_center_point;
        // x_vec = whole_body_x_vec;
        // y_vec = whole_body_y_vec;
        left = whole_body_left;
        right = whole_body_right;
        top = whole_body_top;
        bottom = whole_body_bottom;
        x_min = whole_body_x_min;
        x_max = whole_body_x_max;
        y_min = whole_body_y_min;
        y_max = whole_body_y_max;
        coor_res = whole_body_processing(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max, 
            center_point, whole_body_cross_point_param_x, whole_body_cross_point_param_y,whole_body_top_point, whole_body_bottom_point , mode, height, width, 0.);
        vec_record += coor_res - coor;
    }

    // StretchLegsSlim
    if(stretch_legs_scale != 1.0)
    {
        // float stretch_ratio = 1.0;
        // target_y_ratio = stretch_legs_scale; // 1.16
        center_point = stretch_legs_center_point;
        top = stretch_legs_waist_bottom;
        bottom = stretch_legs_bottom;
        // coor_res = stretch_processing(coor, target_y_ratio, top, bottom, center_point, stretch_ratio, height, width);

        coor_res = stretch_processing_simplify(coor, top, bottom, center_point, stretch_legs_process_param);
        vec_record += coor_res - coor;
    }

    coor_res = coor + vec_record;  
    // coor_res = coor;
    // debug
    if(ratio_flag == 1.)
    {
        coor_res = coor;
    }

    coor_res = coor_res * resolution_inv;

    texToUse.x = coor_res.x;
    texToUse.y = 1.0 - coor_res.y;
    
    if(orient == 0){
        texToUse.x = coor_res.x;
        texToUse.y = coor_res.y;
    } else if(orient == 1){
        texToUse.x = coor_res.y;
        texToUse.y = 1.0 - coor_res.x;
    } else if(orient == 2){
        texToUse.x = 1.0 - coor_res.x;
        texToUse.y = 1.0 - coor_res.y;
    } else {
        texToUse.x = 1.0 - coor_res.y;
        texToUse.y = coor_res.x;
    }
        

    
    
    vec4 color = texture2D(inputImageTexture, texToUse);

    // debug
    // if(factor != 1.)
    // {
    //     color.x  = factor;
    //     color.y = factor;
    //     color.z = factor;
    // }

    
    gl_FragColor = color;
}