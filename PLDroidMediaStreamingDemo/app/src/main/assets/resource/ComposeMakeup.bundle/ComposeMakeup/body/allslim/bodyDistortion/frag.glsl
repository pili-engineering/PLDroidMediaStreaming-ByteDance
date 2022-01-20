#define PI 3.1415926

precision highp float;

varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;



// uniform float height;
// uniform float width;
// uniform int orient;
uniform float ratio_flag;
uniform vec2 resolution;
uniform vec2 resolution_inv;
uniform int orient;


// uniform vec2 face_left_bottom_point;
// uniform vec2 face_right_bottom_point;

// uniform vec2 face_point1;
// uniform vec2 face_point2;
// uniform vec2 face_point3;
// uniform vec2 face_point4;

// LegsSlim
uniform mat4 legs_param;
uniform vec4 legs_centre_n_scale;

// #define legs_x_vec legs_param[0].xy
// #define legs_y_vec legs_param[0].zw

#define legs_cross_point_param_x legs_param[0]
#define legs_cross_point_param_y legs_param[3]

#define legs_left legs_param[1][0]
#define legs_right legs_param[1][1]
#define legs_top legs_param[1][2]
#define legs_bottom legs_param[1][3]

#define legs_x_min legs_param[2][0]
#define legs_x_max legs_param[2][1]
#define legs_y_min legs_param[2][2]
#define legs_y_max legs_param[2][3]

// #define legs_center_point legs_param[3].xy
// #define legs_scale legs_param[3][2]
// #define stretch_legs_waist_scale legs_param[3][3]

#define legs_center_point legs_centre_n_scale.xy
#define legs_scale legs_centre_n_scale.z



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


// HeadSlim

uniform mat4 head_param;
uniform vec4 head_centre_n_scale;

#define head_cross_point_param_x head_param[0]
#define head_cross_point_param_y head_param[3]

// #define head_x_vec head_param[0].xy
// #define head_y_vec head_param[0].zw

#define head_left head_param[1][0]
#define head_right head_param[1][1]
#define head_top head_param[1][2]
#define head_bottom head_param[1][3]

#define head_x_min head_param[2][0]
#define head_x_max head_param[2][1]
#define head_y_min head_param[2][2]
#define head_y_max head_param[2][3]

#define head_center_point head_centre_n_scale.xy
#define head_scale head_centre_n_scale.z

// #define head_center_point head_param[3].xy
// #define head_scale head_param[3][2]


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

// #define whole_body_center_point whole_body_param[3].xy
// #define whole_body_scale whole_body_param[3][2]




// WaistSlim
uniform mat4 waist_param;
uniform vec4 waist_centre_n_scale;

#define waist_cross_point_param_x waist_param[0]
#define waist_cross_point_param_y waist_param[3]

// #define waist_x_vec waist_param[0].xy
// #define waist_y_vec waist_param[0].zw

#define waist_left waist_param[1][0]
#define waist_right waist_param[1][1]
#define waist_top waist_param[1][2]
#define waist_bottom waist_param[1][3]

#define waist_x_min waist_param[2][0]
#define waist_x_max waist_param[2][1]
#define waist_y_min waist_param[2][2]
#define waist_y_max waist_param[2][3]

#define waist_center_point waist_centre_n_scale.xy
#define waist_scale waist_centre_n_scale.z

// #define waist_center_point waist_param[3].xy
// #define waist_scale waist_param[3][2]



// BreastSlim

uniform mat4 breast_param1;
uniform vec4 breast_centre_n_scale1;
uniform mat4 breast_param2;
uniform vec4 breast_centre_n_scale2;

// #define breast_x_vec breast_param1[0].xy
// #define breast_y_vec breast_param1[0].zw

#define breast_cross_point_param_x1 breast_param1[0]
#define breast_cross_point_param_y1 breast_param1[3]

#define breast_left1 breast_param1[1][0]
#define breast_right1 breast_param1[1][1]
#define breast_top1 breast_param1[1][2]
#define breast_bottom1 breast_param1[1][3]

#define breast_x_min1 breast_param1[2][0]
#define breast_x_max1 breast_param1[2][1]
#define breast_y_min1 breast_param1[2][2]
#define breast_y_max1 breast_param1[2][3]

#define breast_center_point1 breast_centre_n_scale1.xy
#define breast_scale_hori1 breast_centre_n_scale1.z
#define breast_scale_hori2 breast_centre_n_scale1.w
// #define breast_center_point1 breast_param1[3].xy
// #define breast_scale breast_param1[3][2]

#define breast_cross_point_param_x2 breast_param2[0]
#define breast_cross_point_param_y2 breast_param2[3]

#define breast_left2 breast_param2[1][0]
#define breast_right2 breast_param2[1][1]
#define breast_top2 breast_param2[1][2]
#define breast_bottom2 breast_param2[1][3]

#define breast_x_min2 breast_param2[2][0]
#define breast_x_max2 breast_param2[2][1]
#define breast_y_min2 breast_param2[2][2]
#define breast_y_max2 breast_param2[2][3]

#define breast_center_point2 breast_centre_n_scale2.xy
#define breast_scale_ver1 breast_centre_n_scale2.z
#define breast_scale_ver2 breast_centre_n_scale2.w

// #define breast_center_point2 breast_param2[3].xy
// #define breast_scale2 breast_param2[3][2]



// HipSlim

uniform mat4 hip_param;
uniform vec4 hip_centre_n_scale;

// #define hip_x_vec hip_param[0].xy
// #define hip_y_vec hip_param[0].zw

#define hip_cross_point_param_x hip_param[0]
#define hip_cross_point_param_y hip_param[3]

#define hip_left hip_param[1][0]
#define hip_right hip_param[1][1]
#define hip_top hip_param[1][2]
#define hip_bottom hip_param[1][3]

#define hip_x_min hip_param[2][0]
#define hip_x_max hip_param[2][1]
#define hip_y_min hip_param[2][2]
#define hip_y_max hip_param[2][3]

#define hip_center_point hip_centre_n_scale.xy
#define hip_scale hip_centre_n_scale.z

// #define hip_center_point hip_param[3].xy
// #define hip_scale hip_param[3][2]



//Stretch Hip Slim
uniform mat4 stretch_hip_param;
uniform vec4 stretch_hip_centre_n_scale;

// #define stretch_hip_x_vec stretch_hip_param[0].xy
// #define stretch_hip_y_vec stretch_hip_param[0].zw

#define stretch_hip_cross_point_param_x stretch_hip_param[0]
#define stretch_hip_cross_point_param_y stretch_hip_param[3]

#define stretch_hip_left stretch_hip_param[1][0]
#define stretch_hip_right stretch_hip_param[1][1]
#define stretch_hip_top stretch_hip_param[1][2]
#define stretch_hip_bottom stretch_hip_param[1][3]

#define stretch_hip_x_min stretch_hip_param[2][0]
#define stretch_hip_x_max stretch_hip_param[2][1]
#define stretch_hip_y_min stretch_hip_param[2][2]
#define stretch_hip_y_max stretch_hip_param[2][3]

#define stretch_hip_center_point stretch_hip_centre_n_scale.xy
#define stretch_hip_scale stretch_hip_centre_n_scale.z

// #define stretch_hip_center_point stretch_hip_param[3].xy
// #define stretch_hip_scale stretch_hip_param[3][2]


// arm
uniform mat4 arm_param1;
#define arm_2_vec2 arm_param1[0].xy
#define arm_3_vec2 arm_param1[0].zw
#define arm_4_vec2 arm_param1[1].xy
#define arm_5_vec2 arm_param1[1].zw
#define arm_6_vec2 arm_param1[2].xy
#define arm_7_vec2 arm_param1[2].zw

#define arm_is_detect1 arm_param1[3][0]
#define arm_is_detect2 arm_param1[3][1]
#define arm_scale1 arm_param1[3][2]
#define arm_scale2 arm_param1[3][3]

uniform mat4 arm_param2;
#define arm_x_min1 arm_param2[0][0]
#define arm_x_max1 arm_param2[0][1]
#define arm_y_min1 arm_param2[0][2]
#define arm_y_max1 arm_param2[0][3]
#define arm_x_min2 arm_param2[1][0]
#define arm_x_max2 arm_param2[1][1]
#define arm_y_min2 arm_param2[1][2]
#define arm_y_max2 arm_param2[1][3]
#define arm_part_ratio arm_param2[2].xyzw
#define ra arm_param2[3][0]


// Shoulder
uniform mat4 sho_param1;
uniform mat4 sho_param2;
uniform vec4 sho_centre_n_scale;
// uniform mat4 sho_cross_param_hori;

// uniform vec4 sho_left_right_top_bottom1_2;
// uniform vec4 sho_left_right_top_bottom2_2;
uniform float sho_target_x_ratio_1;
uniform float sho_target_x_ratio_2;
uniform float sho_scale;

// #define sho_x_vec sho_param1[0].xy
// #define sho_y_vec sho_param1[0].zw

#define sho_cross_point_param_x1 sho_param1[0]
#define sho_cross_point_param_y1 sho_param1[3]

// #define sho_cross_point_param_hori_x1 sho_cross_param_hori[0]
// #define sho_cross_point_param_hori_y1 sho_cross_param_hori[1]

#define sho_left1 sho_param1[1][0]
#define sho_right1 sho_param1[1][1]
#define sho_top1 sho_param1[1][2]
#define sho_bottom1 sho_param1[1][3]
#define sho_x_min1 sho_param1[2][0]
#define sho_x_max1 sho_param1[2][1]
#define sho_y_min1 sho_param1[2][2]
#define sho_y_max1 sho_param1[2][3]


#define sho_center_point1 sho_centre_n_scale.xy
// #define sho_center_hori_point1 sho_centre_n_scale1.zw

// #define sho_center_point1 sho_param1[3].xy
// #define sho_scale sho_param1[3][2]

#define sho_cross_point_param_x2 sho_param2[0]
#define sho_cross_point_param_y2 sho_param2[3]

// #define sho_cross_point_param_hori_x2 sho_cross_param_hori[2]
// #define sho_cross_point_param_hori_y2 sho_cross_param_hori[3]

#define sho_left2 sho_param2[1][0]
#define sho_right2 sho_param2[1][1]
#define sho_top2 sho_param2[1][2]
#define sho_bottom2 sho_param2[1][3]
#define sho_x_min2 sho_param2[2][0]
#define sho_x_max2 sho_param2[2][1]
#define sho_y_min2 sho_param2[2][2]
#define sho_y_max2 sho_param2[2][3]

#define sho_center_point2 sho_centre_n_scale.zw
// #define sho_dis_between_sho_and_hip_smooth_hard sho_centre_n_scale2.z
// #define sho_center_hori_point2 sho_centre_n_scale2.zw

// #define sho_left1_2 sho_left_right_top_bottom1_2.x
// #define sho_right1_2 sho_left_right_top_bottom1_2.y
// #define sho_top1_2 sho_left_right_top_bottom1_2.z
// #define sho_bottom1_2 sho_left_right_top_bottom1_2.w

// #define sho_left2_2 sho_left_right_top_bottom2_2.x
// #define sho_right2_2 sho_left_right_top_bottom2_2.y
// #define sho_top2_2 sho_left_right_top_bottom2_2.z
// #define sho_bottom2_2 sho_left_right_top_bottom2_2.w

// #define sho_center_point2 sho_param2[2].xy



vec4 get_box_param(vec2 point1, vec2 point2)
{
    vec4 box_params;
    // x_min
    box_params.x = min(point1.x, point2.x);
    box_params.y = max(point1.x, point2.x);
    box_params.z = min(point1.y, point2.y);
    box_params.w = max(point1.y, point2.y);
    if(box_params.y - box_params.x < 1.0)
    {
        box_params.x = box_params.x - 1.0;
        box_params.y = box_params.y + 1.0;
    }
    if(box_params.w - box_params.z < 1.0)
    {
        box_params.z = box_params.z - 1.0;
        box_params.w = box_params.w + 1.0;
    }
    return box_params;
}

vec2 get_orthogonal_vec(vec2 vector)
{
    vec2 res;
    res.x = vector.y;
    res.y = - vector.x;
    return res;
}

int is_in_box(vec4 box_params, vec2 point)
{
    if(point.x >= box_params.x && point.x <= box_params.y && point.y >= box_params.z && point.y <= box_params.w)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

float angel_between_vec(vec2 vec_1, vec2 vec_2)
{
    return acos(dot(normalize(vec_1), normalize(vec_2)));
}

vec2 get_inner_contour_point(vec2 circle_vec, vec2 contour_point, float angle, float r, float circle_radiu)
{
    float tmp_length;
    if(abs(angle) > 1e-10)
    {
        tmp_length = r / sin(angle);
    }
    else
    {
        return vec2(-1.0, -1.0);
    }
    return contour_point + tmp_length * circle_vec;
}

vec2 get_outer_contour_point(vec2 circle_vec, vec2 contour_point, float angle, float r, float circle_radiu)
{
    float tmp_length;
    if(abs(angle) > 1e-10)
    {
        tmp_length = r / sin(angle);
    }
    else
    {
        return vec2(-1.0, -1.0);
    }
    return contour_point - tmp_length * circle_vec;
}


vec4 get_inner_boundary_point(vec2 line1_vec, vec2 line2_vec, vec2 inner_contour_point, float angle, float r, float circle_radiu)
{
    float tmp_length;
    if(abs(angle) < 1e-10 || abs(abs(angle) - PI / 2.) < 1e-10 )
    {
        return vec4(-1.0, -1.0, -1.0, -1.0);
    }
    else
    {
        tmp_length = (circle_radiu - r) / tan(angle);
    }
    vec4 res;
    res.xy = inner_contour_point - tmp_length * line1_vec;
    res.zw = inner_contour_point + tmp_length * line2_vec;
    return res;
}

vec4 get_outer_boundary_point(vec2 line1_vec, vec2 line2_vec, vec2 outer_contour_point, float angle, float r, float circle_radiu)
{
    float tmp_length;
    if(abs(angle) < 1e-10 || abs(abs(angle) - PI / 2.) < 1e-10 )
    {
        return vec4(-1, -1.0, -1.0, -1.0);
    }
    else
    {
        tmp_length = (circle_radiu + r) / tan(angle);
    }
    vec4 res;
    res.xy = outer_contour_point - tmp_length * line1_vec;
    res.zw = outer_contour_point + tmp_length * line2_vec;
    return res;
}

vec2 get_circle_center_point(vec2 circle_vec, vec2 contour_point, float angle, float r, float circle_radiu)
{
    float tmp_length;
    if(abs(angle) < 1e-10 )
    {
        return vec2(-1.0, -1.0);
    }
    else
    {
        tmp_length = circle_radiu / sin(angle);
    }
    return contour_point + tmp_length * circle_vec;
}

int is_in_angle(vec2 query_point, vec2 center_point, vec2 point1, vec2 point2, int mode)
{
    vec2 line1_vec = point1 - center_point;
    vec2 line2_vec = point2 - center_point;
    if(mode != 3 && mode != 2) // 11 10
    {
        line1_vec = - line1_vec;
    }
    if(mode != 3 && mode != 1) // 11 01
    {
        line2_vec = - line2_vec;
    }
    vec2 point_vec = query_point - center_point;
    if(point_vec.x == 0. && point_vec.y == 0.)
    {
        return 0;
    }
    line1_vec = normalize(line1_vec);
    line2_vec = normalize(line2_vec);
    point_vec = normalize(point_vec);
    
    float angle1 = acos(dot(line1_vec, line2_vec));
    float angle2 = acos(dot(line1_vec, point_vec));
    float angle3 = acos(dot(point_vec, line2_vec));
    //    cross_product_vec2(line1_vec, point_vec) //    if(max(angle2, angle3) > angle1)
    if(angle2 < angle1 && angle3 < angle1 && dot(point_vec, line1_vec + line2_vec) > 0.)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

vec3 get_line_param(vec2 point1, vec2 point2)
{
    vec3 res;
    res.x = point1.y - point2.y;
    res.y = point2.x - point1.x;
    res.z = point1.x * point2.y - point2.x * point1.y;
    return res;
}

vec2 get_cross_point(vec4 line1, vec4 line2)
{
    vec3 param1 = get_line_param(line1.xy, line1.zw);
    vec3 param2 = get_line_param(line2.xy, line2.zw);
    vec2 res = vec2(-1.0, -1.0);
    float tmp_d = param1.x * param2.y - param2.x * param1.y;
    if(tmp_d != 0.)
    {
        res.x = (param1.y * param2.z - param2.y * param1.z) / tmp_d;
        res.y = (param1.z * param2.x - param2.z * param1.x) / tmp_d;
    }
    return res;
}

vec2 get_vertical_cross_point_by_vec(vec2 point, vec2 vec, vec2 target_point)
{
    vec2 res;
    vec2 other_point = point + vec;
    
    vec3 ABC = get_line_param(point, other_point);
    float A = ABC.x;
    float B = ABC.y;
    float C = ABC.z;
    float A2 = A * A;
    float B2 = B * B;
    float A2plusB2 = A2 + B2;
    
    if(A2plusB2 != 0.)
    {
        float AB = A * B;
        float AC = A * C;
        float BC = B * C;
        float inv_A2plusB2 = 1.0 / A2plusB2;
        res.x = (B2 * target_point.x - AB * target_point.y - AC) * inv_A2plusB2;
        res.y = (A2 * target_point.y - AB * target_point.x - BC) * inv_A2plusB2;
        return res;
    }
    else
    {
        return res;
    }
}


vec2 get_vertical_cross_point_by_vec_simplify(vec4 cross_point_param, vec2 target_point)
{
    vec2 res = vec2(-1., -1.);
    
    
    // float A = cross_point_param.x;
    // float B = cross_point_param.y;
    // float C = cross_point_param.z;
    // float inv_A2plusB2 = cross_point_param.w;
    
    // float A2 = A * A;
    // float B2 = B * B;
    
    // float AB = A * B;
    // float AC = A * C;
    // float BC = B * C;
    
    // res.x = (B2 * target_point.x - AB * target_point.y - AC) * inv_A2plusB2;
    // res.y = (A2 * target_point.y - AB * target_point.x - BC) * inv_A2plusB2;
    
    if(cross_point_param.x < 0.)
    {
        return res;
    }
    
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

vec2 processing_v2(vec2 coor, float ori_target_x_ratio, float ori_max_x_ratio, float ori_target_y_ratio, float ori_max_y_ratio, float left, float right, float top, float bottom, float x_min, float x_max, float y_min, float y_max, vec2 center_point, vec4 cross_point_param_x, vec4 cross_point_param_y, int mode, float height, float width, int direction, int line_type, int transition_type, float ratio_flag)
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
    else
    {
        if(coor.x <= x_min || coor.x >= x_max)
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
        // if(ratio_flag == 1.)
        // {
        //     return hehe;
        // }
        // else
        // {
        return coor;
        // }
    }
    
    float offset_x = x_cross_point.x - center_point.x;
    
    // vec2 y_cross_point = get_vertical_cross_point_by_vec(center_point, y_vec, coor);
    vec2 y_cross_point = get_vertical_cross_point_by_vec_simplify(cross_point_param_y, coor);
    if(y_cross_point.x == -1.0)
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
    
     if(ratio_flag == 1.)
     {
         if(max_x_ratio != 1.0)
         {
             res.x = 1.0 - (1.0 - x_ratio) / (1.0 - max_x_ratio);
         }
         else
         {
             res.x = 1.0;
         }
         if(max_y_ratio != 1.0)
         {
             res.y = 1.0 - (1.0 - y_ratio) / (1.0 - max_y_ratio);
         }
         else
         {
             res.y = 1.0;
         }
     }
    
    return res;
}

vec2 stretch_processing(vec2 coor, float ori_target_y_ratio, float top, float bottom, vec2 center_point, float stretch_ratio, float height, float width)
{
    vec2 res = coor;
    float top_pos = center_point.y - top;
    if(coor.y < top_pos)
    {
        return res;
    }
    
    //    float bottom_pos = center_point.y + bottom;
    //    float middle = center_point.y;
    
    float target_y_ratio = ori_target_y_ratio;
    float top_bottom_stretch_ratio = stretch_ratio / (stretch_ratio + 1.0);
    float total_ori_num = bottom + top;
    float total_tmp_num = total_ori_num * target_y_ratio;
    float add_num = total_tmp_num - total_ori_num;
    
    float top_region_ori_num = top;
    float bottom_region_ori_num = bottom;
    float accum;
    
    
    float top_region_tmp_num = add_num * top_bottom_stretch_ratio + top_region_ori_num;
    float bottom_region_tmp_num = add_num * (1.0 - top_bottom_stretch_ratio) + bottom_region_ori_num;
    
    float top_region_gap = 1., bottom_region_gap = 1., y_pos = 0.;
    top_region_gap = (top_region_tmp_num != 0.) ? top_region_ori_num / top_region_tmp_num : 0.;
    
    bottom_region_gap = (bottom_region_tmp_num != 0.) ? bottom_region_ori_num / bottom_region_tmp_num : 0.;
    
    
    float state_1 = (top_region_tmp_num + top_pos) < coor.y ? 1.0 : 0.;
    float state_2 = (top_region_tmp_num + bottom_region_tmp_num + top_pos) < coor.y ? 1.0 : 0.;
    accum = top_pos + top_region_ori_num * state_1 + bottom_region_ori_num * state_2;
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
    
    y_pos = tmp_gap * (coor.y - start_region) + accum;
    
    res.y = y_pos;
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

// vec2 whole_body_processing(vec2 coor, float ori_target_x_ratio, float ori_max_x_ratio, float ori_target_y_ratio, float ori_max_y_ratio, float left, float right, float top, float bottom, float x_min, float x_max, float y_min, float y_max,
//     vec2 center_point, vec4 cross_point_param_x, vec4 cross_point_param_y, vec2 top_point, vec2 bottom_point , int mode, float height, float width, float ratio_flag)
// {
//     if(ori_target_x_ratio == 1.)
//     {
//         return coor;
//     }
//     float target_x_ratio = ori_target_x_ratio;
//     float target_y_ratio = ori_target_y_ratio;
//     float max_x_ratio = ori_max_x_ratio;
//     float max_y_ratio = ori_max_y_ratio;
//     vec2 res = coor;

//      //Note: left_point,right_point not using
//     // vec2 left_point = center_point - left * x_vec;
//     // vec2 right_point = center_point + right * x_vec;

//     // vec2 top_point = center_point - top * y_vec;
//     // vec2 bottom_point = center_point + bottom * y_vec;

//     float retain_ratio = 0., offset_y, offset_y_ratio, offset_y_ratio2, retain_radiu, retain_num, max_retain_num;

//     //Note: x_cross_point not using
//     // vec2 x_cross_point = get_vertical_cross_point_by_vec(center_point, x_vec, coor);

//     // vec2 y_cross_point = get_vertical_cross_point_by_vec(center_point, y_vec, coor);
//      vec2 y_cross_point = get_vertical_cross_point_by_vec_simplify(cross_point_param_y, coor);

//     if(!(coor.y > top_point.y && coor.y < bottom_point.y))
//     {
//         retain_ratio = 0.;
//     }
//     else
//     {
//         offset_y = distance(y_cross_point, center_point);
//         offset_y_ratio = (y_cross_point.y < center_point.y) ? offset_y / top: offset_y / bottom;
//         retain_ratio =  1. - offset_y_ratio;
//         retain_ratio = min(retain_ratio, 1.); //
//         // retain_ratio = retain_ratio > 0.45 ? 0.45 : retain_ratio;
//     }

//     float length = (left > right) ? right : left;

//     float left_ori_num = center_point.x;
//     float right_ori_num = width - center_point.x;

//     float ori_half_length = min(left_ori_num, right_ori_num);
//     int left_or_right;
//     if(left_ori_num > right_ori_num)
//     {
//         left_or_right = 1;
//     }
//     else
//     {
//         left_or_right = 0;
//     }
//     float enlarge_ratio = 1.5;
//     length = length * enlarge_ratio;
//     retain_radiu = length * 1. / enlarge_ratio;
//     retain_num = retain_radiu * retain_ratio;
//     max_retain_num = retain_radiu;

//     float split_ratio = 0.5;
//     float left1_ori_num, left2_ori_num, right1_ori_num, right2_ori_num;
//     float left1_tmp_num, left2_tmp_num, right1_tmp_num, right2_tmp_num;

//     // float left_ratio, right_ratio;
//     // left_ratio = (left != 0.) ? (left_ori_num - left) / left : 0.;
//     // right_ratio = (right != 0.) ? (right_ori_num - right) / right : 0.;
//     // float final_ratio = clamp(min(left_ratio, right_ratio) * 1.5, 0., 1.);
//     // final_ratio = 1.;
//     // target_x_ratio = (target_x_ratio - 1.) * final_ratio + 1.;

//     // left2_ori_num = left - retain_num;
//     // left1_ori_num = left_ori_num - left2_ori_num - retain_num;

//     // right2_ori_num = right - retain_num;
//     // right1_ori_num = right_ori_num - right2_ori_num - retain_num;

//     // left2_tmp_num = left * target_x_ratio - retain_num;
//     // left1_tmp_num = left_ori_num - left2_tmp_num - retain_num;

//     // right2_tmp_num = right * target_x_ratio - retain_num;
//     // right1_tmp_num = right_ori_num - right2_tmp_num - retain_num;
//     float left2_ori_num_min, right2_ori_num_min, left2_tmp_num_min, right2_tmp_num_min;
//     if(left_or_right == 0)
//     {
//         left2_ori_num_min = (ori_half_length - max_retain_num) * split_ratio;
//         left2_ori_num_min = min(length, left2_ori_num_min);

//         left1_ori_num = ori_half_length - left2_ori_num_min - max_retain_num;
//         left2_ori_num = left_ori_num - left1_ori_num - retain_num;

//         right2_ori_num = left2_ori_num;
//         right1_ori_num = right_ori_num - right2_ori_num - retain_num;


//         left2_tmp_num_min = left2_ori_num_min * target_x_ratio; // 0.9 * 0.5

//         left1_tmp_num = ori_half_length - left2_tmp_num_min - max_retain_num;
//         left2_tmp_num = left_ori_num - left1_tmp_num - retain_num;

//         right2_tmp_num = left2_tmp_num; // 0.9 * 0.5
//         right1_tmp_num = right_ori_num - right2_tmp_num - retain_num;
//     }
//     else
//     {
//         right2_ori_num_min = (ori_half_length - max_retain_num) * split_ratio;
//         right2_ori_num_min = min(length, right2_ori_num_min);

//         right1_ori_num =  ori_half_length - right2_ori_num_min - max_retain_num;
//         right2_ori_num =  right_ori_num - right1_ori_num - retain_num;

//         left2_ori_num =  right2_ori_num;
//         left1_ori_num =  left_ori_num - left2_ori_num - retain_num;

//         right2_tmp_num_min = right2_ori_num_min * target_x_ratio;

//         right1_tmp_num = ori_half_length - right2_tmp_num_min - max_retain_num;
//         right2_tmp_num = right_ori_num - right1_tmp_num - retain_num;

//         left2_tmp_num = right2_tmp_num; // 0.9 * 0.5
//         left1_tmp_num = left_ori_num - left2_tmp_num - retain_num;
//     }





//     // float left1_tmp_num = left1_ori_num * (1. + 1. - target_x_ratio);
//     // float left2_tmp_num = left_ori_num - left1_tmp_num - retain_num; // 0.9 * 0.5

//     // float left2_tmp_num = (left2_ori_num + retain_num) * target_x_ratio - retain_num; // 0.9 * 0.5
//     // float left1_tmp_num = left_ori_num - left2_tmp_num - retain_num;
//     // float left2_tmp_num = left2_ori_num * target_x_ratio; // 0.9 * 0.5
//     // float left1_tmp_num = left_ori_num - left2_tmp_num - retain_num;

//     // float right1_tmp_num = right1_ori_num * (1. + 1. - target_x_ratio);
//     // float right2_tmp_num = right_ori_num - right1_tmp_num - retain_num; // 0.9 * 0.5

//     // float right2_tmp_num = (right2_ori_num + retain_num)* target_x_ratio - retain_num;
//     // float right1_tmp_num = right_ori_num - right2_tmp_num - retain_num;
//     // float right2_tmp_num = right * target_x_ratio;
//     // float right1_tmp_num = right_ori_num - right2_tmp_num - retain_num;

//     float left1_gap = (left1_tmp_num != 0.) ? left1_ori_num / left1_tmp_num : 1.;
//     float left2_gap = (left2_tmp_num != 0.) ? left2_ori_num / left2_tmp_num : 1.;
//     float right1_gap = (right1_tmp_num != 0.) ? right1_ori_num / right1_tmp_num : 1.;
//     float right2_gap = (right2_tmp_num != 0.) ? right2_ori_num / right2_tmp_num : 1.;

//     //    left2_gap = target_x_ratio != 0. ? 1. / target_x_ratio : 1.;
//     float sp_gap = target_x_ratio != 0. ? 1. / target_x_ratio : 1.;

//     float add_num, sp_ratio = 0.65; // 1 区域分成 1 2
//     add_num = left1_tmp_num - left1_ori_num;
//     //    (left1_tmp_num * sp_ratio * (x + 1.)) / 2 + (left1_tmp_num * (1. - sp_ratio) * (left2_gap + 1.)) / 2 = left1_ori_num
//     float left_end_gap = (2. * left1_ori_num - left1_tmp_num * (1. - sp_ratio) * (sp_gap + 1.)) / (left1_tmp_num * sp_ratio) - 1.;

//     float right_end_gap = (2. * right1_ori_num - right1_tmp_num * (1. - sp_ratio) * (sp_gap + 1.)) / (right1_tmp_num * sp_ratio) - 1.;

//     float left1_tmp_num_phase1 = left1_tmp_num * sp_ratio;
//     float left1_tmp_num_phase2 = left1_tmp_num - left1_tmp_num_phase1;

//     float right1_tmp_num_phase1 = right1_tmp_num * sp_ratio;
//     float right1_tmp_num_phase2 = right1_tmp_num - right1_tmp_num_phase1;

//     float accum_sum, u, v;


//     float tmp_float, my_tmp = 0.33;
//     tmp_float = left1_tmp_num;
//     float state_1 = tmp_float < coor.x ? 1. : 0.;
//     tmp_float += left2_tmp_num;
//     float state_2 = tmp_float < coor.x ? 1. : 0.;//step(left1_tmp_num + left2_tmp_num, coor.x);
//     tmp_float = left_ori_num;
//     float state_3 = tmp_float < coor.x ? 1. : 0.;
//     tmp_float += retain_num;
//     float state_4 = tmp_float < coor.x ? 1. : 0.;
//     tmp_float += right2_tmp_num;
//     float state_5 = tmp_float <  coor.x ? 1. : 0.;

//     if(state_5 == 1.)
//     {
//         my_tmp = 0.33;
//     }
//     else if(state_4 == 1.)
//     {
//         my_tmp = 0.5;
//     }
//     else if(state_3 == 1.)
//     {
//         my_tmp = 0.75;
//     }
//     else if(state_2 == 1.)
//     {
//         my_tmp = 0.75;
//     }
//     else if(state_1 == 1.)
//     {
//         my_tmp = 0.5;
//     }

//     // float middle_ratio = 0.5;
//     accum_sum = state_1 * left1_ori_num + state_2 * left2_ori_num + state_3 * retain_num + state_4 * retain_num + state_5 * right2_ori_num;
//     float start_region = state_1 * left1_tmp_num + state_2 * left2_tmp_num + state_3 * retain_num + state_4 * retain_num + state_5 * right2_tmp_num;
//     float tmp_shift;
//     if(state_5 == 1.)
//     {
//         if(start_region + right1_tmp_num_phase2 < coor.x)
//         {
//             float tmp_num = right1_tmp_num_phase2 * (sp_gap + 1.) * 0.5;
//             //            float tmp_num = right1_tmp_num_phase2;
//             float tmp_gap = (right1_tmp_num_phase1 != 0.) ? ((right_end_gap - 1.) / right1_tmp_num_phase1 * (coor.x - start_region - right1_tmp_num_phase2) + 1.): 1.;
//             tmp_shift = tmp_num + (coor.x - start_region - right1_tmp_num_phase2) * (1. + tmp_gap) * 0.5;
//         }
//         else
//         {
//             float tmp_num = 0.;
//             float tmp_gap = (right1_tmp_num_phase2 != 0.) ? ((1. - sp_gap) / right1_tmp_num_phase2 * (coor.x - start_region - tmp_num) + sp_gap) : 1.;
//             tmp_shift = tmp_num + (coor.x - start_region - tmp_num) * (sp_gap + tmp_gap) * 0.5;
//         }
//         //        tmp_shift = right1_gap * (coor.x - start_region);
//     }
//     else if(state_4 == 1.)
//     {
//         tmp_shift = (coor.x - start_region) * right2_gap;
//     }
//     else if(state_3 == 1.)
//     {
//         tmp_shift = 1. * (coor.x - start_region);
//     }
//     else if(state_2 == 1.)
//     {
//         tmp_shift = 1. * (coor.x - start_region);
//     }
//     else if(state_1 == 1.)
//     {
//         tmp_shift = left2_gap * (coor.x - start_region);
//     }
//     else
//     {
//         //        tmp_shift = left1_gap;
//         if(start_region + left1_tmp_num_phase1 < coor.x)
//         {
//             float tmp_num = left1_tmp_num_phase1 * (left_end_gap + 1.) * 0.5;
//             //            float tmp_num = left1_tmp_num_phase1;
//             float tmp_gap = (left1_tmp_num_phase2 != 0.) ? ((sp_gap - 1.) / left1_tmp_num_phase2 * (coor.x - start_region - left1_tmp_num_phase1) + 1.): 1.;
//             tmp_shift = tmp_num + (coor.x - start_region - left1_tmp_num_phase1) * (1. + tmp_gap) * 0.5;
//         }
//         else
//         {
//             float tmp_num = 0.;
//             float tmp_gap = (left1_tmp_num_phase1 != 0.) ? ((1. - left_end_gap) / left1_tmp_num_phase1 * (coor.x - start_region - tmp_num) + left_end_gap) : 1.;
//             tmp_shift = tmp_num + (coor.x - start_region - tmp_num) * (left_end_gap + tmp_gap) * 0.5;
//         }
//         //        tmp_shift = left1_gap * (coor.x - start_region);
//     }
//     res.x = tmp_shift + accum_sum;
//     // res.x = my_tmp;
//     return res;
// }

vec2 whole_body_processing(vec2 coor, float ori_target_x_ratio, float ori_max_x_ratio, float ori_target_y_ratio, float ori_max_y_ratio, float left, float right, float top, float bottom, float x_min, float x_max, float y_min, float y_max, vec2 center_point, vec4 cross_point_param_x, vec4 cross_point_param_y, vec2 top_point, vec2 bottom_point , int mode, float height, float width, float ratio_flag)
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
    
    float split_ratio = 0.5;
    float left1_ori_num, left2_ori_num, right1_ori_num, right2_ori_num;
    float left1_tmp_num, left2_tmp_num, right1_tmp_num, right2_tmp_num;
    
    float left_ratio, right_ratio;
    left_ratio = (left != 0.) ? (left_ori_num - left) / left : 0.;
    right_ratio = (right != 0.) ? (right_ori_num - right) / right : 0.;
    float final_ratio = clamp(min(left_ratio, right_ratio) * 1.5, 0., 1.);
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
    float left2_ori_num_min, right2_ori_num_min, left2_tmp_num_min, right2_tmp_num_min;
    if(left_or_right == 0)
    {
        left2_ori_num_min = (ori_half_length - max_retain_num) * split_ratio;
        left2_ori_num_min = min(length, left2_ori_num_min);
        
        left1_ori_num = ori_half_length - left2_ori_num_min - max_retain_num;
        left2_ori_num = left_ori_num - left1_ori_num - retain_num;
        
        right2_ori_num = left2_ori_num;
        right1_ori_num = right_ori_num - right2_ori_num - retain_num;
        
        
        left2_tmp_num_min = left2_ori_num_min * target_x_ratio; // 0.9 * 0.5
        
        left1_tmp_num = ori_half_length - left2_tmp_num_min - max_retain_num;
        left2_tmp_num = left_ori_num - left1_tmp_num - retain_num;
        
        right2_tmp_num = left2_tmp_num; // 0.9 * 0.5
        right1_tmp_num = right_ori_num - right2_tmp_num - retain_num;
    }
    else
    {
        right2_ori_num_min = (ori_half_length - max_retain_num) * split_ratio;
        right2_ori_num_min = min(length, right2_ori_num_min);
        
        right1_ori_num =  ori_half_length - right2_ori_num_min - max_retain_num;
        right2_ori_num =  right_ori_num - right1_ori_num - retain_num;
        
        left2_ori_num =  right2_ori_num;
        left1_ori_num =  left_ori_num - left2_ori_num - retain_num;
        
        right2_tmp_num_min = right2_ori_num_min * target_x_ratio;
        
        right1_tmp_num = ori_half_length - right2_tmp_num_min - max_retain_num;
        right2_tmp_num = right_ori_num - right1_tmp_num - retain_num;
        
        left2_tmp_num = right2_tmp_num; // 0.9 * 0.5
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
    
    float add_num, sp_ratio = 0.65; // 1 区域分成 1 2
    add_num = left1_tmp_num - left1_ori_num;
    //    (left1_tmp_num * sp_ratio * (x + 1.)) / 2 + (left1_tmp_num * (1. - sp_ratio) * (left2_gap + 1.)) / 2 = left1_ori_num
    float left_end_gap = (2. * left1_ori_num - left1_tmp_num * (1. - sp_ratio) * (sp_gap + 1.)) / (left1_tmp_num * sp_ratio) - 1.;
    
    float right_end_gap = (2. * right1_ori_num - right1_tmp_num * (1. - sp_ratio) * (sp_gap + 1.)) / (right1_tmp_num * sp_ratio) - 1.;
    
    float left1_tmp_num_phase1 = left1_tmp_num * sp_ratio;
    float left1_tmp_num_phase2 = left1_tmp_num - left1_tmp_num_phase1;
    
    float right1_tmp_num_phase1 = right1_tmp_num * sp_ratio;
    float right1_tmp_num_phase2 = right1_tmp_num - right1_tmp_num_phase1;
    
    float accum_sum, u, v;
    
    
    float tmp_float;// my_tmp = 0.33;//my_tmp = 0.33;
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
    
    // float middle_ratio = 0.5;
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


// vec2 line_processing(vec2 coor,float ori_target_x_ratio, float max_x_ratio, float ori_target_y_ratio, float max_y_ratio, float x_min, float x_max, float y_min, float y_max, vec2 point1, vec2 point2, vec2 point3, float r, float ratio_flag, float add_scale, vec2 ori_arm_part_ratio, int mode)
// {
//     vec2 hehe = vec2(1., 1.0);
// //    || (ori_target_x_ratio == 1.0 && ori_target_y_ratio == 1.0) || point1.x == -1.0 || point2.x == -1.0
// //     if(coor.x < x_min || coor.x > x_max || coor.y < y_min || coor.y > y_max || (ori_target_x_ratio == 1.0 && ori_target_y_ratio == 1.0) || point1.x == -1.0 || point2.x == -1.0)
// // //    if(coor.x < x_min || coor.x > x_max || coor.y < y_min || coor.y > y_max)
// //     {
// //         if(ratio_flag == 1.)
// //         {
// //                 return hehe;
// //         }
// //         else
// //         {
// //                 return coor;
// //         }
// //     }
// //    point3 = normalize(point2 - point1) * r + point2;
//     vec2 ex_point1 = normalize(point1 - point2) * r + point1;
//     vec2 ex_point2 = normalize(point2 - point1) * r + point2;
//     vec2 ex_point3 = normalize(point3 - point2) * r + point3;
//     vec2 test_inner_point;
// //    left_top_point.x = x_min;
// //    left_top_point.y = y_min;
// //    if(length(normalize(vec2(0., 2.))) < 0.99 || length(normalize(vec2(0., 3.))) < 0.99 || length(normalize(vec2(2., 0.))) < 0.99)
// //    {
// //        return vec2(0.5, 0.5);
// //    }

// //    else
// //    {
// //        return vec2(0., 0.);
// //    }
//     float max_circle_radiu = 1.5 * r, offset_x_ratio, dis1, dis2, angle, circle_radiu, ref_dis, tmp_dis, end_point_dis, tmp_contour_dis;
//     int is_in_box1 = 0, is_in_box1_sp = 0, is_in_box2 = 0, add_circle_out_and_in_area = 0, circle_out_and_in_area = 0, one_or_two, is_in_angle_region;
//     vec2 end_point, anchor_point, mapped_vec = vec2(0., 0.);
//     vec2 tmp_center_line_vec1, tmp_center_line_vec2, tmp_cross_point1, tmp_cross_point2, tmp_vec, contour_point, tmp_center_line_vec1_norm, tmp_center_line_vec2_norm, circle_vec, inner_contour_point, outer_contour_point, inner_boundary_point1, inner_boundary_point2, outer_boundary_point1, outer_boundary_point2, circle_center_point, tmp_cross_point, inner_point, outer_point, inner_cross_point, center_cross_point, outer_cross_point, tmp_end_point;
//     vec4 tmp_vec4, tmp_center_line, inner_line, outer_line, tmp_line;


//     tmp_center_line_vec1 = point2 - point1;
//     float arm_distance = distance(point1, point2);
//     float arm_center_ratio = 0.3333;
//     float default_ratio = 0.9;
//     float tmp_default_ratio = default_ratio;
//     tmp_cross_point1 = get_vertical_cross_point_by_vec(point1, tmp_center_line_vec1, coor);

//     vec2 tmp_orthogonal_vec = get_orthogonal_vec(tmp_center_line_vec1);
//     test_inner_point = point1 + 1.0 * normalize(tmp_orthogonal_vec);

// //    if(tmp_cross_point1.x == -1.0 )
// //    {
// //        return vec2(0.5, 0.5);
// //    }
//     int my_flag = 0, inner_or_outer;
//     if(tmp_cross_point1.x == -1.0)
//     {
//         return vec2(0., 0.);
//     }
//     dis1 = distance(tmp_cross_point1, coor);
//     vec4 box_params = get_box_param(ex_point1, point2);

//     is_in_box1 = is_in_box(box_params, tmp_cross_point1);
//     int is_in_box1_other = is_in_box(get_box_param(point1, point2), tmp_cross_point1);
//     vec2 arm_center_point = point1 + (point2 - point1) * arm_center_ratio;

//     if(point3.x != -1.0)
//     {
//         tmp_center_line_vec2 = point3 - point2;
//         tmp_cross_point2 = get_vertical_cross_point_by_vec(point3, tmp_center_line_vec2, coor);
// //        if(tmp_cross_point2.x == -1.0 )
// //        {
// //            return vec2(0.5, 0.5);
// //        }
//         box_params = get_box_param(point2, ex_point3);
//         is_in_box2 = is_in_box(box_params, tmp_cross_point2);
//         dis2 = distance(tmp_cross_point2, coor);
//         max_circle_radiu = 2. * r;
//         contour_point = point2;
//         is_in_angle_region = is_in_angle(coor, contour_point, point1, point3, 3);


//         if(is_in_angle(test_inner_point, contour_point, point1, point3, 3) == is_in_angle_region)
//         {
//             inner_or_outer = 0;
//         }
//         else
//         {
//             inner_or_outer = 1;
//         }


//         tmp_center_line_vec2 = point3 - point2;
//         angle = (PI - angel_between_vec(tmp_center_line_vec1, tmp_center_line_vec2)) * 0.5;
//         tmp_center_line_vec1_norm = normalize(tmp_center_line_vec1);
//         tmp_center_line_vec2_norm = normalize(tmp_center_line_vec2);
//     }
//     else
//     {
//         if(dot(coor - tmp_cross_point1, tmp_orthogonal_vec) > 0.)
//         {
//             inner_or_outer = 0;
//         }
//         else
//         {
//             inner_or_outer = 1;
//         }
//     }

//     if(mode == 1)
//     {
//         inner_or_outer = 1 - inner_or_outer;
//     }
//     //  || abs(angle - PI * 0.5) < 1e3 || length(tmp_center_line_vec2_norm - tmp_center_line_vec1_norm) < 1e-4 || 1==1
//     if(point3.x == -1.0 || abs(angle - PI * 0.5) < 1e-4)// || angle < PI / 3.6 / 2.)
//     {
//         if(abs(angle - PI * 0.5) < 1e-4)
//         {
//             vec4 box_params = get_box_param(ex_point1, ex_point3);
//             is_in_box1_sp = is_in_box(box_params, tmp_cross_point1);
//             tmp_end_point = point3;
//         }
//         else
//         {
//             vec4 box_params = get_box_param(ex_point1, ex_point2);
//             is_in_box1_sp = is_in_box(box_params, tmp_cross_point1);
//             tmp_end_point = point2;
//         }
//         if(dis1 < r) // 过渡外点 过渡内点 区域圈外点
//         {
//             my_flag = 1;
//             if(is_in_box1_sp == 1) // 区域圈外
//             {

//                 anchor_point = tmp_cross_point1;
//                 if(dot(tmp_end_point - tmp_cross_point1, point1 - tmp_cross_point1) > 0.)
//                 {
//                     if(dot(tmp_end_point - point1, tmp_cross_point1 - point1) > 0.)
//                     {
//                         end_point = tmp_end_point;
//                     }
//                     else
//                     {
//                         end_point = point1;
//                     }
//                     offset_x_ratio = 1.0 - (1.0 - length(end_point - tmp_cross_point1) / r) * (1.0 - dis1 / r);
//                 }
//                 else
//                 {
//                     offset_x_ratio = dis1 / r;
//                     if(dot(arm_center_point - tmp_cross_point1, point1 - tmp_cross_point1) > 0.)
//                     {
//                          tmp_default_ratio = default_ratio + (1.0 - default_ratio) * (1.0 - distance(tmp_cross_point1, arm_center_point) / (arm_distance * (1.0 - arm_center_ratio)));
//                     }
//                     else
//                     {
//                         tmp_default_ratio = default_ratio + (1.0 - default_ratio) * (1.0 - distance(tmp_cross_point1, arm_center_point) / (arm_distance *  arm_center_ratio));
//                     }
//                 }
// //                else if(dot(point2 - tmp_cross_point1, point1 - tmp_cross_point1) > 0)
// //                tmp_vec = coor - point1;
// //                end_point = mix(point1, point2, step(0., dot(tmp_vec, tmp_center_line_vec1)));
//             }
//             else // 过渡外点 过渡内点
//             {
// //                tmp_vec = coor - point1;
// //                end_point = mix(point1, point2, step(0., dot(tmp_vec, tmp_center_line_vec1)));
// //                end_point_dis = distance(tmp_cross_point1, end_point);
// //
// //                if(end_point_dis < r) // 过渡内点
// //                {
// //                    offset_x_ratio = 1.0 - (1.0 - end_point_dis / r) * (1.0 - dis1 / r);
// //                }
// //                else
// //                {
//                 offset_x_ratio = 1.0;
// //                }
//                 anchor_point = tmp_cross_point1;
//             }
//         }
//         else // 绝对外点
//         {

//             my_flag = 0;
//             offset_x_ratio = 1.0;
//             anchor_point = tmp_cross_point1;
//         }
//     }

//     else
//     {
//         my_flag = 1;

//         circle_vec = normalize(tmp_center_line_vec2_norm - tmp_center_line_vec1_norm);
// //        if(abs(angle) < 1e-10 )
// //        {
// //            return vec2(0.5, 0.5);
// //        }
//         circle_radiu = min(min(length(tmp_center_line_vec1), length(tmp_center_line_vec2)) * tan(angle), max_circle_radiu);
//         ref_dis = circle_radiu / tan(angle);
//         inner_contour_point = get_inner_contour_point(circle_vec, contour_point, angle, r, circle_radiu);
// //        if(inner_contour_point.x == -1.0)
// //        {
// //            return vec2(0.5, 0.5);
// //        }
//         outer_contour_point = get_outer_contour_point(circle_vec, contour_point, angle, r, circle_radiu);

//         tmp_vec4 = get_inner_boundary_point(tmp_center_line_vec1_norm, tmp_center_line_vec2_norm, inner_contour_point, angle, r, circle_radiu);
//         inner_boundary_point1 = tmp_vec4.xy;
//         inner_boundary_point2 = tmp_vec4.zw;

//         tmp_vec4 = get_outer_boundary_point(tmp_center_line_vec1_norm, tmp_center_line_vec2_norm, outer_contour_point, angle, r, circle_radiu);
//         outer_boundary_point1 = tmp_vec4.xy;
//         outer_boundary_point2 = tmp_vec4.zw;

//         circle_center_point = get_circle_center_point(circle_vec, contour_point, angle, r, circle_radiu);


//         add_circle_out_and_in_area = 0;
//         circle_out_and_in_area = 0;
//         if((is_in_box1 == 1 && dis1 < r) && (is_in_box2 == 1 && dis2 < r)) // 区域圈外点 区域圈内点
//         {
//             if(dis1 < dis2)
//             {
//                 circle_out_and_in_area = 1;
//             }
//             else
//             {
//                 circle_out_and_in_area = 2;
//             }
//         }
//         else if((is_in_box1 == 1 && dis1 < r))
//         {
//             circle_out_and_in_area = 1;
//         }
//         else if((is_in_box2 == 1 && dis2 < r))
//         {
//             circle_out_and_in_area = 2;
//         }
//         else if(is_in_box1 == 0 && is_in_box2 == 0 && length(coor - contour_point) < r && dis1 < r && dis2 < r && is_in_angle(coor, circle_center_point, outer_boundary_point1, outer_boundary_point2, 3) == 1) // 不在绝对区域内，但是dis在范围内   小角度哪
//         {
// //            my_flag = 1;
//             if(dis1 > dis2)
//             {
//                 add_circle_out_and_in_area = 1;
//             }
//             else
//             {
//                 add_circle_out_and_in_area = 2;
//             }
//         }
//         tmp_center_line.xy = contour_point;
//         if(circle_out_and_in_area > 0 || add_circle_out_and_in_area > 0) // 区域圈内 区域圈外
//         {
//             if(circle_out_and_in_area == 1 || add_circle_out_and_in_area == 1)
//             {
//                 one_or_two = 1;
//             }
//             else
//             {
//                 one_or_two = 2;
//             }

// //            if(circle_out_and_in_area > 0)
// //            {
// //                one_or_two = (dis1 > dis2) ? 2:1;
//             tmp_end_point = (one_or_two == 2) ? ex_point3 : ex_point1;
//             tmp_center_line.zw = (one_or_two == 2) ? point3 : point1;
//             tmp_cross_point = (one_or_two == 2) ? tmp_cross_point2 : tmp_cross_point1;
//             tmp_contour_dis = length(contour_point - tmp_cross_point);

//             tmp_dis = (one_or_two == 2) ? dis2 : dis1;
//             inner_point = (one_or_two == 2) ? inner_boundary_point2 : inner_boundary_point1;
//             outer_point = (one_or_two == 2) ? outer_boundary_point2 : outer_boundary_point1;

// //            }
// //            else
// //            {
// ////                one_or_two = (dis1 > dis2) ? 1:2;
// //                tmp_center_line.zw = (one_or_two == 2) ? point1:point3;
// //                tmp_cross_point = (one_or_two == 2) ? tmp_cross_point1 : tmp_cross_point2;
// //                tmp_contour_dis = length(contour_point - tmp_cross_point);
// //                tmp_dis = (one_or_two == 2) ? dis1 : dis2;
// //                inner_point = (one_or_two == 2) ? inner_boundary_point1 : inner_boundary_point2;
// //                outer_point = (one_or_two == 2) ? outer_boundary_point1 : outer_boundary_point2;
// //            }
//             if(one_or_two == 1 && is_in_box1_other == 1)
//             {
//                 if(dot(arm_center_point - tmp_cross_point1, point1 - tmp_cross_point1) > 0.)
//                 {
//                     tmp_default_ratio = default_ratio + (1.0 - default_ratio) * (1.0 - distance(tmp_cross_point1, arm_center_point) / (arm_distance * (1.0 - arm_center_ratio)));
//                 }
//                 else
//                 {
//                     tmp_default_ratio = default_ratio + (1.0 - default_ratio) * (1.0 - distance(tmp_cross_point1, arm_center_point) / (arm_distance *  arm_center_ratio));
//                 }
//             }
//             if(ref_dis < tmp_contour_dis && dot(tmp_cross_point - contour_point, tmp_end_point - contour_point) > 0.) // 区域圈外 ref_dis < tmp_contour_dis &&
//             {
//                 anchor_point = tmp_cross_point;

//                 if(dot(contour_point - tmp_cross_point, tmp_center_line.zw - tmp_cross_point) > 0.)
//                 {
//                     offset_x_ratio = 1.0 - (1.0 - length(tmp_center_line.zw - tmp_cross_point) / r) * (1.0 - tmp_dis / r);
//                 }
//                 else
//                 {
//                     offset_x_ratio = tmp_dis / r;

//                 }
// //                offset_x_ratio = 1.0;
// //                offset_x_ratio = tan((PI- angel_between_vec(tmp_center_line_vec1, tmp_center_line_vec2)) / 4.) / 2.;
// //                offset_x_ratio = test_count / 10.
//             }
//             else //区域圈内
//             {
//                 tmp_line.xy = circle_center_point;
//                 tmp_line.zw = coor;

//                 inner_line.xy = inner_contour_point;
//                 inner_line.zw = inner_point;

//                 outer_line.xy = outer_contour_point;
//                 outer_line.zw = outer_point;

//                 inner_cross_point = get_cross_point(tmp_line, inner_line);
//                 center_cross_point = get_cross_point(tmp_line, tmp_center_line);
//                 outer_cross_point = get_cross_point(tmp_line, outer_line);
//                 if(is_in_angle_region == 1)
//                 {
//                     offset_x_ratio = length(coor - center_cross_point) / r; //length(inner_cross_point - center_cross_point);
//                     anchor_point = center_cross_point;
// //                    offset_x_ratio = 0.;
//                 }
//                 else
//                 {
//                     if(circle_out_and_in_area > 0)
//                     {
//                         offset_x_ratio = length(coor - tmp_cross_point) / r;
//                         anchor_point = tmp_cross_point;
//                     }
//                     else if(add_circle_out_and_in_area > 0)
//                     {
//                         offset_x_ratio = length(coor - contour_point) / r;
//                         anchor_point = contour_point;
//                     }

//                 }




// //                offset_x_ratio = 1.0;

//             }
//         }
//         else // 过渡外点 过度内点 绝对外部点
//         {

// //            if(dis1 < r && dot(-tmp_center_line_vec1, tmp_cross_point1 - contour_point) > 0.) // 第一条线前面
// //            {
// //                end_point_dis = length(tmp_cross_point1 - point1);
// //                if(end_point_dis > r) // 过渡外点
// //                {
// //                    offset_x_ratio = 1.0;
// //                }
// //                else
// //                {
// //                    offset_x_ratio = 1.0 - (1.0 - end_point_dis / r) * (1.0 - dis1 / r);
// //                }
// //                anchor_point = tmp_cross_point1;
// //                offset_x_ratio = 1.0;
// //            }
// //            else if(dis2 < r && dot(tmp_center_line_vec2, tmp_cross_point2 - contour_point) > 0.) // 看第二条线后面
// //            {
// //                end_point_dis = length(tmp_cross_point2 - point3);
// //                if(end_point_dis > r) //过度外点
// //                {
// //                    offset_x_ratio = 1.0;
// //                }
// //                else // 过度内点
// //                {
// //                    offset_x_ratio = 1.0 - (1.0 - end_point_dis / r) * (1.0 - dis2 / r);
// //                }
// //                anchor_point = tmp_cross_point2;
// //                offset_x_ratio = 1.0;
// //            }
// //            else // 绝对外点
// //            {
//             offset_x_ratio = 1.0;
//             anchor_point = tmp_cross_point1;
// //            }
//         }
//     }
//     if(offset_x_ratio > 1.0)
//     {
//         offset_x_ratio = 1.0;
//     }
//     if(offset_x_ratio < 0.)
//     {
//         offset_x_ratio = 0.;
//     }
//     float offset_x_ratio2 = offset_x_ratio * offset_x_ratio;

//     float tmp_max_x_ratio;
//     tmp_max_x_ratio = ori_target_x_ratio * tmp_default_ratio;
// //    if(add_scale != ori_target_x_ratio && my_flag == 1)
// //    {
// //        tmp_max_x_ratio = add_scale;
// //    }
//     float normal_ratio = 1.0;
//     float x_ratio;
//     x_ratio = tmp_max_x_ratio - (tmp_max_x_ratio - normal_ratio) * (offset_x_ratio2 * (1.0 - offset_x_ratio) + offset_x_ratio);
// //    x_ratio = tmp_max_x_ratio - (tmp_max_x_ratio - normal_ratio) * offset_x_ratio;

// //    x_ratio = mix(max(x_ratio, max_x_ratio), min(x_ratio, max_x_ratio), step(1., max_x_ratio));

//     if(inner_or_outer == 0)
//     {
//         x_ratio = (x_ratio - 1.0) * ori_arm_part_ratio.x + 1.0;
//     }
//     else
//     {
//         x_ratio = (x_ratio - 1.0) * ori_arm_part_ratio.y + 1.0;
//     }
//     float u = x_ratio * (coor.x - anchor_point.x) + anchor_point.x;
//     float v = x_ratio * (coor.y - anchor_point.y) + anchor_point.y;
//     mapped_vec.x = mapped_vec.x + (u - coor.x);
//     mapped_vec.y = mapped_vec.y + (v - coor.y);
//     // if(ratio_flag == 1.)
//     // {
//     //     if(x_ratio != 1.0)
//     //     {
//     //         return vec2(abs((x_ratio - 1.3) / (normal_ratio - 1.3)), 1.0);
//     //     }
//     //     else
//     //     {
//     //         return vec2(1., 1.0);
//     //     }
//     // }
//     // else
//     // {
//         return mapped_vec + coor;
//     // }
// }



vec2 line_processing(vec2 coor,float ori_target_x_ratio, float max_x_ratio, float ori_target_y_ratio, float max_y_ratio, float x_min, float x_max, float y_min, float y_max, vec2 point1, vec2 point2, vec2 point3, float r, float ratio_flag, float add_scale, vec2 ori_arm_part_ratio, int mode)
{
    vec2 hehe = vec2(1., 1.);
    //    || (ori_target_x_ratio == 1. && ori_target_y_ratio == 1.) || point1.x == -1. || point2.x == -1.
    if(coor.x < x_min || coor.x > x_max || coor.y < y_min || coor.y > y_max || (ori_target_x_ratio == 1. && ori_target_y_ratio == 1.) || point1.x == -1. || point2.x == -1.)
        //    if(coor.x < x_min || coor.x > x_max || coor.y < y_min || coor.y > y_max)
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
    //    point3 = normalize(point2 - point1) * r + point2;
    // float line1_ex_len = r;
    // float line2_ex_len = r;
    if(point3.x != -1.)
    {
        point3 = point2 + normalize(point3 - point2) * length(point3 - point2) * 0.8;
    }
    point1 = point2 + normalize(point1 - point2) * length(point1 - point2) * 0.88;
    vec2 ex_point1 = normalize(point1 - point2) * r + point1;
    vec2 ex_point2 = normalize(point2 - point1) * r + point2;
    vec2 ex_point3 = normalize(point3 - point2) * r + point3;
    vec2 test_inner_point;
    //    left_top_point.x = x_min;
    //    left_top_point.y = y_min;
    //    if(length(normalize(vec2(0., 2.))) < 0.99 || length(normalize(vec2(0., 3.))) < 0.99 || length(normalize(vec2(2., 0.))) < 0.99)
    //    {
    //        return vec2(0.5, 0.5);
    //    }
    
    //    else
    //    {
    //        return vec2(0., 0.);
    //    }
    float max_circle_radiu = 1.5 * r, offset_x_ratio, dis1, dis2, angle, circle_radiu, ref_dis, ref_dis_overlap, tmp_dis, end_point_dis, tmp_contour_dis;
    int is_in_box1 = 0, is_in_box1_sp = 0, is_in_box2 = 0, add_circle_out_and_in_area = 0, circle_out_and_in_area = 0, one_or_two, is_in_angle_region;
    vec2 end_point, anchor_point, mapped_vec = vec2(0., 0.);
    vec2 tmp_center_line_vec1, tmp_center_line_vec2, tmp_cross_point1, tmp_cross_point2, tmp_vec, contour_point, tmp_center_line_vec1_norm, tmp_center_line_vec2_norm, circle_vec, inner_contour_point, outer_contour_point, inner_boundary_point1, inner_boundary_point2, outer_boundary_point1, outer_boundary_point2, circle_center_point, tmp_cross_point, inner_point, outer_point, inner_cross_point, center_cross_point, outer_cross_point, tmp_end_point;
    vec4 tmp_vec4, tmp_center_line, inner_line, outer_line, tmp_line;
    
    tmp_center_line_vec1 = point2 - ex_point1;
    float arm_distance = distance(point1, point2);
    float arm_center_ratio = 0.25;
    float default_ratio = 0.8;
    float sp_default_ratio = 0.5;
    float tmp_default_ratio = default_ratio;
    tmp_cross_point1 = get_vertical_cross_point_by_vec(point1, tmp_center_line_vec1, coor);
    
    vec2 tmp_orthogonal_vec = get_orthogonal_vec(tmp_center_line_vec1);
    test_inner_point = point1 + 0.5 * normalize(tmp_orthogonal_vec);
    
    int my_flag = 0, inner_or_outer, end_flag = 0;
    if(tmp_cross_point1.x == -1.)
    {
        return vec2(0., 0.);
    }
    dis1 = distance(tmp_cross_point1, coor);
    vec4 box_params = get_box_param(ex_point1, point2);
    
    is_in_box1 = is_in_box(box_params, tmp_cross_point1);
    int is_in_box1_other = is_in_box(get_box_param(point1, point2), tmp_cross_point1);
    vec2 arm_center_point = point1 + (point2 - point1) * arm_center_ratio;
    
    
    if(point3.x != -1.)
    {
        tmp_center_line_vec2 = ex_point3 - point2;
        tmp_cross_point2 = get_vertical_cross_point_by_vec(point3, tmp_center_line_vec2, coor);
        
        box_params = get_box_param(point2, ex_point3);
        is_in_box2 = is_in_box(box_params, tmp_cross_point2);
        dis2 = distance(tmp_cross_point2, coor);
        max_circle_radiu = 2. * r;
        contour_point = point2;
        is_in_angle_region = is_in_angle(coor, contour_point, point1, point3, 3);
        
        if(is_in_angle(test_inner_point, contour_point, point1, point3, 3) == is_in_angle_region)
        {
            inner_or_outer = 0;
        }
        else
        {
            inner_or_outer = 1;
        }
        
        tmp_center_line_vec2 = point3 - point2;
        angle = (PI - angel_between_vec(tmp_center_line_vec1, tmp_center_line_vec2)) * 0.5;
        tmp_center_line_vec1_norm = normalize(tmp_center_line_vec1);
        tmp_center_line_vec2_norm = normalize(tmp_center_line_vec2);
    }
    else
    {
        if(dot(coor - tmp_cross_point1, tmp_orthogonal_vec) > 0.)
        {
            inner_or_outer = 0;
        }
        else
        {
            inner_or_outer = 1;
        }
    }
    if(mode == 1)
    {
        inner_or_outer = 1 - inner_or_outer;
    }
    if(point3.x == -1. || abs(angle - PI * 0.5) < 1e-4)// || angle < PI / 3.6 / 2.)
    {
        if(abs(angle - PI * 0.5) < 1e-4)
        {
            vec4 box_params = get_box_param(ex_point1, ex_point3);
            is_in_box1_sp = is_in_box(box_params, tmp_cross_point1);
            tmp_end_point = point3;
        }
        else
        {
            vec4 box_params = get_box_param(ex_point1, ex_point2);
            is_in_box1_sp = is_in_box(box_params, tmp_cross_point1);
            tmp_end_point = point2;
        }
        if(dis1 < r) // 过渡外点 过渡内点 区域圈外点
        {
            my_flag = 1;
            if(is_in_box1_sp == 1) // 区域圈外
            {
                
                anchor_point = tmp_cross_point1;
                if(dot(tmp_end_point - tmp_cross_point1, point1 - tmp_cross_point1) > 0.)
                {
                    if(dot(tmp_end_point - point1, tmp_cross_point1 - point1) > 0.)
                    {
                        end_point = tmp_end_point;
                    }
                    else
                    {
                        end_point = point1;
                        tmp_default_ratio = sp_default_ratio;
                    }
                    offset_x_ratio = 1. - (1. - length(end_point - tmp_cross_point1) / r) * (1. - dis1 / r);
                    
                }
                else
                {
                    offset_x_ratio = dis1 / r;
                    if(dot(arm_center_point - tmp_cross_point1, point1 - tmp_cross_point1) > 0.) // 下半
                    {
                        tmp_default_ratio = default_ratio + (1. - default_ratio) * (1. - distance(tmp_cross_point1, arm_center_point) / (arm_distance * (1. - arm_center_ratio)));
                    }
                    else // 上半
                    {
                        tmp_default_ratio = sp_default_ratio + (1. - sp_default_ratio) * (1. - distance(tmp_cross_point1, arm_center_point) / (arm_distance *  arm_center_ratio));
                    }
                }
            }
            else // 过渡外点 过渡内点
            {
                offset_x_ratio = 1.;
                anchor_point = tmp_cross_point1;
            }
        }
        else // 绝对外点
        {
            
            my_flag = 0;
            offset_x_ratio = 1.;
            anchor_point = tmp_cross_point1;
        }
    }
    else
    {
        my_flag = 1;
        circle_vec = tmp_center_line_vec2_norm - tmp_center_line_vec1_norm;
        //        ref_dis_overlap = min(r / tan(angle), length(tmp_center_line_vec1));
        //        ref_dis_overlap = min(ref_dis_overlap, length(tmp_center_line_vec2));
        add_circle_out_and_in_area = 0;
        circle_out_and_in_area = 0;
        //        offset_x_ratio = 1.;
        if((is_in_box1 == 1 && dis1 < r) && (is_in_box2 == 1 && dis2 < r)) // 区域圈外点 区域圈内点
        {
            if(dis1 < dis2)
            {
                circle_out_and_in_area = 1;
            }
            else
            {
                circle_out_and_in_area = 2;
            }
        }
        else if((is_in_box1 == 1 && dis1 < r))
        {
            circle_out_and_in_area = 1;
            if(dis1 > dis2 && dot(tmp_cross_point1 - point2, ex_point1 - point2) > 0. && dot(tmp_cross_point2 - point2, ex_point3 - point2) > 0.)
            {
                end_flag = 1;
            }
        }
        else if((is_in_box2 == 1 && dis2 < r))
        {
            circle_out_and_in_area = 2;
            if(dis1 < dis2 && dot(tmp_cross_point1 - point2, ex_point1 - point2) > 0. && dot(tmp_cross_point2 - point2, ex_point3 - point2) > 0.)
            {
                end_flag = 1;
            }
            
        }
        else if(is_in_box1 == 0 && is_in_box2 == 0 && length(coor - contour_point) < r && dis1 < r && dis2 < r && is_in_angle_region == 0) // 不在绝对区域内，但是dis在范围内   小角度哪
        {
            if(dis1 > dis2)
            {
                add_circle_out_and_in_area = 1;
            }
            else
            {
                add_circle_out_and_in_area = 2;
            }
            //            offset_x_ratio = 0.;
        }
        tmp_center_line.xy = contour_point;
        if(circle_out_and_in_area > 0 || add_circle_out_and_in_area > 0) // 区域圈内 区域圈外
        {
            if(circle_out_and_in_area == 1 || add_circle_out_and_in_area == 1)
            {
                one_or_two = 1;
                
            }
            else
            {
                one_or_two = 2;
                
            }
            
            tmp_end_point = (one_or_two == 2) ? ex_point3 : ex_point1;
            tmp_center_line.zw = (one_or_two == 2) ? point3 : point1;
            tmp_cross_point = (one_or_two == 2) ? tmp_cross_point2 : tmp_cross_point1;
            ref_dis_overlap = (one_or_two == 2) ? min(r / tan(angle), length(ex_point3 - point2)) : min(r / tan(angle), length(ex_point1 - point2));
            tmp_contour_dis = length(contour_point - tmp_cross_point);
            
            tmp_dis = (one_or_two == 2) ? dis2 : dis1;
            
            if(one_or_two == 1 && is_in_box1_other == 1)
            {
                if(dot(arm_center_point - tmp_cross_point1, point1 - tmp_cross_point1) > 0.) // 下半
                {
                    tmp_default_ratio = default_ratio + (1. - default_ratio) * (1. - distance(tmp_cross_point1, arm_center_point) / (arm_distance * (1. - arm_center_ratio)));
                }
                else // 上半
                {
                    tmp_default_ratio = sp_default_ratio + (1. - sp_default_ratio) * (1. - distance(tmp_cross_point1, arm_center_point) / (arm_distance *  arm_center_ratio));
                }
            }
            
            if(dot(contour_point - tmp_cross_point, tmp_center_line.zw - tmp_cross_point) > 0.)
            {
                if(add_circle_out_and_in_area == 0)
                {
                    
                    float tmp_float = length(contour_point - tmp_cross_point);
                    float tmp_ratio;
                    
                    if(is_in_angle_region == 1 && ref_dis_overlap > tmp_float)
                    {
                        float angle_ratio = clamp(2. * (angle - PI / 4.) / (PI * 3. / 4.), 0., 1.);
                        // angle_ratio = angle_ratio * angle_ratio;
                        float tmp_r = tmp_float * tan(angle) * (1. - angle_ratio) + r * angle_ratio;
                        tmp_ratio = tmp_dis / tmp_r;
                        tmp_ratio = clamp(tmp_ratio, 0., 1.);
                        offset_x_ratio = 1. - (1. - length(tmp_center_line.zw - tmp_cross_point) / r) * (1. - tmp_ratio);
                        // offset_x_ratio = 0.;
                        if(one_or_two == 1)
                        {
                            tmp_default_ratio = sp_default_ratio;
                        }
                    }
                    else
                    {
                        if(end_flag == 0)
                        {
                            tmp_ratio = tmp_dis / r;
                            tmp_ratio = min(tmp_ratio, 1.);
                            offset_x_ratio = 1. - (1. - length(tmp_center_line.zw - tmp_cross_point) / r) * (1. - tmp_ratio);
                            if(one_or_two == 1)
                            {
                                tmp_default_ratio = sp_default_ratio;
                            }
                        }
                        else
                        {
                            offset_x_ratio = 1.;
                        }
                    }
                    anchor_point = tmp_cross_point;
                    // offset_x_ratio = 0.;
                }
                else
                {
                    float tmp_angle = abs(PI - angel_between_vec(circle_vec, coor - contour_point));
                    
                    float tmp_float = ((PI - 2. * angle) == 0.) ? 1. : 2. * tmp_angle / (PI - 2. * angle);
                    //                    (PI - angel_between_vec(tmp_center_line_vec1, tmp_center_line_vec2)) * 0.5;
                    offset_x_ratio = length(coor - contour_point) / r;
                    offset_x_ratio = min(offset_x_ratio, 1.);
                    //                    tmp_float = min(tmp_float, 1.);
                    float tmp_float2 = (PI - 2. * angle) / PI;
                    tmp_float2 = clamp(tmp_float2, 0., 1.);
                    offset_x_ratio = offset_x_ratio + (1. - offset_x_ratio) * tmp_float2 * tmp_float2 * (1. - tmp_float);
                    //                    offset_x_ratio = 0.;
                    anchor_point = contour_point;
                }
                //    offset_x_ratio = 0.;
            }
            else
            {
                
                float tmp_float = length(contour_point - tmp_cross_point);
                if(is_in_angle_region == 1 && ref_dis_overlap > tmp_float)
                {
                    float angle_ratio = clamp(2. * (angle - PI / 4.)  / (PI * 3. / 4.), 0., 1.);
                    // angle_ratio = angle_ratio * angle_ratio;
                    float tmp_r = tmp_float * tan(angle) * (1. - angle_ratio) + r * angle_ratio;
                    // float tmp_r = tmp_float * tan(angle);
                    // float tmp_ratio;
                    // tmp_ratio = tmp_dis / tmp_r;
                    // tmp_ratio = clamp(tmp_ratio, 0., 1.);
                    offset_x_ratio = tmp_dis / tmp_r;
                }
                else
                {
                    if(end_flag == 0)
                    {
                        offset_x_ratio = tmp_dis / r;
                    }
                    else
                    {
                        offset_x_ratio = 1.0;
                    }
                }
                anchor_point = tmp_cross_point;
                
            }
        }
        else // 过渡外点 过度内点 绝对外部点
        {
            offset_x_ratio = 1.;
            anchor_point = tmp_cross_point1;
            //            }
        }
    }
    // if(one_or_two == 2)
    // {
    //     offset_x_ratio = 0.;
    // }
    if(offset_x_ratio > 1.)
    {
        offset_x_ratio = 1.;
    }
    if(offset_x_ratio < 0.)
    {
        offset_x_ratio = 0.;
    }
    float offset_x_ratio2 = offset_x_ratio * offset_x_ratio;
    
    float tmp_max_x_ratio;
    tmp_max_x_ratio = (ori_target_x_ratio - 1.) * tmp_default_ratio + 1.;
    //    if(add_scale != ori_target_x_ratio && my_flag == 1)
    //    {
    //        tmp_max_x_ratio = add_scale;
    //    }
    float normal_ratio = 1.;
    float x_ratio;
    x_ratio = tmp_max_x_ratio - (tmp_max_x_ratio - normal_ratio) * (offset_x_ratio2 * (1. - offset_x_ratio) + offset_x_ratio);
    //    x_ratio = tmp_max_x_ratio - (tmp_max_x_ratio - normal_ratio) * offset_x_ratio;
    
    //    x_ratio = mix(max(x_ratio, max_x_ratio), min(x_ratio, max_x_ratio), step(1., max_x_ratio));
    
    float tmp_float1, tmp_float2;
    
    if(point3.x != -1.)
    {
        if(one_or_two == 2)
        {
            if(2. * angle < PI * 3. / 4. && 2. * angle > PI / 4.)
            {
                tmp_float2 = (2. * angle - PI / 4.) /  (PI / 2.);
            }
            else if(2. * angle >= PI * 3. / 4.)
            {
                tmp_float2 = 1.;
            }
            else
            {
                tmp_float2 = 0.;
            }
            
            tmp_float2 = clamp(tmp_float2, 0., 1.);
            if(inner_or_outer == 0)
            {
                tmp_float1 = tmp_float2 * ori_arm_part_ratio.x + (1. - tmp_float2) * ori_arm_part_ratio.y;
            }
            else
            {
                tmp_float1 = tmp_float2 * ori_arm_part_ratio.y + (1. - tmp_float2) * ori_arm_part_ratio.x;
                
            }
            x_ratio = (x_ratio - 1.) * tmp_float1 + 1.;
        }
        else
        {
            if(inner_or_outer == 0)
            {
                x_ratio = (x_ratio - 1.) * ori_arm_part_ratio.x + 1.;
            }
            else
            {
                x_ratio = (x_ratio - 1.) * ori_arm_part_ratio.y + 1.;
            }
        }
    }
    else
    {
        if(inner_or_outer == 0)
        {
            x_ratio = (x_ratio - 1.) * ori_arm_part_ratio.x + 1.;
        }
        else
        {
            x_ratio = (x_ratio - 1.) * ori_arm_part_ratio.y + 1.;
        }
    }
    
    
    //    if(inner_or_outer == 0)
    //    {
    //        x_ratio = (x_ratio - 1.) * ori_arm_part_ratio.x + 1.;
    //    }
    //    else
    //    {
    //        x_ratio = (x_ratio - 1.) * ori_arm_part_ratio.y + 1.;
    //    }
    float u = x_ratio * (coor.x - anchor_point.x) + anchor_point.x;
    float v = x_ratio * (coor.y - anchor_point.y) + anchor_point.y;
    mapped_vec.x = mapped_vec.x + (u - coor.x);
    mapped_vec.y = mapped_vec.y + (v - coor.y);
    
    if(ratio_flag == 1.)
    {
        if(x_ratio != 1.)
        {
            return vec2(abs((x_ratio - 1.5) / (normal_ratio - 1.5)), 1.);
        }
        else
        {
            return vec2(1., 1.);
        }
    }
    else
    {
        return mapped_vec + coor;
    }
}


void main() {
    
    //not debug//
    // int legs_debug = 0;
    // int breast_debug = 0;
    // int waist_debug = 0;
    // int whole_body_debug = 0;
    // int head_debug = 0;
    // int stretch_legs_debug = 0;
    // int hip_debug = 0;
    
    ///////////////////////
    // vec2 texToUse = textureCoordinate;
    // vec2 coor = vec2(0.0, 0.0);
    
    // if (deviceOrien == 0.0 )
    // {
    //     coor = vec2(texToUse.x, 1.0 - texToUse.y);
    //     // coor = coor * resolution;
    // }
    //  else if(deviceOrien == 90.0)
    // {
    //      coor = vec2(1.0 - texToUse.y , texToUse.x);
    //      // coor = coor * (resolution.yx);
    // }
    // else if (deviceOrien == 180.0 )
    // {
    //     coor = vec2(texToUse.x, texToUse.y);
    //     // coor = coor * resolution;
    // }
    // else if(deviceOrien == 270.0)
    // {
    //     coor = vec2( 1.0 -  texToUse.y ,  1.0 - texToUse.x);
    //     // coor = coor * (resolution.yx);
    // }
    ///////////////////////
    vec2 texToUse = textureCoordinate;
    vec2 coor;
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
    
    
     float factor = 1.0, factor1 = 1.0, factor2 = 1.0;
    
    // LegsSlim
    if(legs_scale != 1.0)
    {
        target_x_ratio = legs_scale;  // 1.3
        max_x_ratio = (1.0 - target_x_ratio) * 0.8 + target_x_ratio;
        target_y_ratio = 1.0;
        max_y_ratio = (1.0 - target_y_ratio) * 0.8 + target_y_ratio;
        center_point = legs_center_point;
        // x_vec = legs_x_vec;
        // y_vec = legs_y_vec;
        left = legs_left;
        right = legs_right;
        top = legs_top;
        bottom = legs_bottom;
        x_min = legs_x_min;
        x_max = legs_x_max;
        y_min = legs_y_min;
        y_max = legs_y_max;
        mode = 0;
        direction = 0;
        line_type = 1;
        
        coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max,
                                 center_point,legs_cross_point_param_x, legs_cross_point_param_y, mode, height, width, direction, line_type, transition_type, ratio_flag);
         if(ratio_flag == 1.)
         {
             factor = min(min(coor_res.x, coor_res.y), factor);
         }
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
    
    //StretchWaistSlim
    if(stretch_legs_waist_scale != 1.0)
    {
        bottom = stretch_legs_top - stretch_legs_waist_bottom;
        top = 0.;
        y_min = stretch_legs_y_min;
        y_max = y_min + bottom;
        center_point = stretch_legs_center_point;
        center_point.y = y_min;
        target_x_ratio = 1.0;
        max_x_ratio = (1.0 - target_x_ratio) * 0.7 + target_x_ratio;
        target_y_ratio = stretch_legs_waist_scale;// 1.4
        max_y_ratio = (1.0 - target_y_ratio) * 0. + target_y_ratio;
        // x_vec = vec2(1., 0.);
        // y_vec = vec2(0., 1.0);
        left = legs_left;
        right = legs_right;
        x_min = 0.;
        x_max = width;
        mode = 1;
        direction = 1;
        line_type = 0;
        transition_type = 1;
        coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max, center_point, stretch_legs_cross_point_param_x, stretch_legs_cross_point_param_y, mode, height, width, direction, line_type, transition_type, ratio_flag);
        vec_record += coor_res - coor;
         if(ratio_flag == 1.)
         {
             factor = min(min(coor_res.x, coor_res.y), factor);
         }
    }
    
    // HeadSlim
    if(head_scale != 1.0)
    {
        target_x_ratio = head_scale;// 1.4
        max_x_ratio = (1.0 - target_x_ratio) * 0.7 + target_x_ratio;
        target_y_ratio = head_scale;// 1.4
        max_y_ratio = (1.0 - target_y_ratio) * 0.7 + target_y_ratio;
        center_point = head_center_point;
        // x_vec = head_x_vec;
        // y_vec = head_y_vec;
        left = head_left;
        right = head_right;
        top = head_top;
        bottom = head_bottom;
        x_min = head_x_min;
        x_max = head_x_max;
        y_min = head_y_min;
        y_max = head_y_max;
        direction = 1; // 1
        line_type = 0;
        
        if(coor.x >= center_point.x - left && coor.x <= right + center_point.x)
        {
            mode = 2;
        }
        else
        {
            mode = 1;
        }
        // direction = 0;
        // mode = 2;
        coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max,
                                 center_point, head_cross_point_param_x, head_cross_point_param_y, mode, height, width, direction, line_type, transition_type, ratio_flag);
        vec_record += coor_res - coor;
         if(ratio_flag == 1.)
         {
             factor = min(min(coor_res.x, coor_res.y), factor);
         }
    }
    
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
        coor_res = whole_body_processing(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max, center_point, whole_body_cross_point_param_x, whole_body_cross_point_param_y,whole_body_top_point, whole_body_bottom_point , mode, height, width, 0.);
        vec_record += coor_res - coor;
         if(ratio_flag == 1.)
         {
             factor = min(min(coor_res.x, coor_res.y),  factor);
         }
    }
    
    
    // WaistSlim
    if(waist_scale != 1.0)
    {
        target_x_ratio = waist_scale;// 1.25
        max_x_ratio = (1.0 - target_x_ratio) * 0.4 + target_x_ratio;
        target_y_ratio = 1.0;// 1.0
        max_y_ratio = (1.0 - target_y_ratio) * 0.4 + target_y_ratio;
        center_point = waist_center_point;
        // x_vec = waist_x_vec;
        // y_vec = waist_y_vec;
        left = waist_left;
        right = waist_right;
        top = waist_top;
        bottom = waist_bottom;
        x_min = waist_x_min;
        x_max = waist_x_max;
        y_min = waist_y_min;
        y_max = waist_y_max;
        mode = 0;
        direction = 0;
        line_type = 1;
        coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max,
                                 center_point, waist_cross_point_param_x, waist_cross_point_param_y, mode, height, width, direction, line_type, transition_type, ratio_flag);
        vec_record += coor_res - coor;
        
         if(ratio_flag == 1.)
         {
             factor = min(min(coor_res.x, coor_res.y),  factor);
         }
        
        
    }
    
    // HipSlim
    if(hip_scale != 1.0)
    {
        target_x_ratio = hip_scale;// 1.25
        max_x_ratio = (1.0 - target_x_ratio) * 0.65 + target_x_ratio;
        target_y_ratio = 1.0;// 1.0
        max_y_ratio = (1.0 - target_y_ratio) * 0.65 + target_y_ratio;
        center_point = hip_center_point;
        // x_vec = hip_x_vec;
        // y_vec = hip_y_vec;
        left = hip_left;
        right = hip_right;
        top = hip_top;
        bottom = hip_bottom;
        x_min = hip_x_min;
        x_max = hip_x_max;
        y_min = hip_y_min;
        y_max = hip_y_max;
        mode = 0;
        direction = 0;
        line_type = 1;
        coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max,
                                 center_point,hip_cross_point_param_x, hip_cross_point_param_y, mode, height, width, direction, line_type, transition_type, ratio_flag);
        vec_record += coor_res - coor;
        
        // if(ratio_flag == 1.)
        // {
        //     factor = min(coor_res.x > coor_res.y ? coor_res.y : coor_res.x, factor);
        // }
    }
    
    // BreastSlim
    
    if(breast_scale_hori1 != 1.0 )
    {
        target_x_ratio = breast_scale_hori1;// 0.8
        max_x_ratio = (1.0 - target_x_ratio) * 0.6 + target_x_ratio;
        target_y_ratio = breast_scale_ver1;// 0.8
        max_y_ratio = (1.0 - target_y_ratio) * 0.6 + target_y_ratio;
        
        center_point = breast_center_point1;
        // x_vec = breast_x_vec;
        // y_vec = breast_y_vec;
        left = breast_left1;
        right = breast_right1;
        top = breast_top1;
        bottom = breast_bottom1;
        x_min = breast_x_min1;
        x_max = breast_x_max1;
        y_min = breast_y_min1;
        y_max = breast_y_max1;
        mode = 2;
        direction = 0;
        line_type = 0;
        coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max,
                                 center_point, breast_cross_point_param_x1, breast_cross_point_param_y1, mode, height, width, direction, line_type, transition_type, ratio_flag);
        // if(ratio_flag == 1.)
        // {
        //     factor1 = coor_res.x > coor_res.y ? coor_res.y : coor_res.x;
        // }
        vec_record += coor_res - coor;
    }
    
    if(breast_scale_hori2 != 1.)
    {
        
        target_x_ratio = breast_scale_hori2;// 0.8
        max_x_ratio = (1.0 - target_x_ratio) * 0.6 + target_x_ratio;
        target_y_ratio = breast_scale_ver2;// 0.8
        max_y_ratio = (1.0 - target_y_ratio) * 0.6 + target_y_ratio;
        
        center_point = breast_center_point2;
        // x_vec = breast_x_vec;
        // y_vec = breast_y_vec;
        left = breast_left2;
        right = breast_right2;
        top = breast_top2;
        bottom = breast_bottom2;
        x_min = breast_x_min2;
        x_max = breast_x_max2;
        y_min = breast_y_min2;
        y_max = breast_y_max2;
        mode = 2;
        direction = 0;
        line_type = 0;
        coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max,
                                 center_point, breast_cross_point_param_x2, breast_cross_point_param_y2, mode, height, width, direction, line_type, transition_type, ratio_flag);
        // if(ratio_flag == 1.)
        // {
        //     factor2 = coor_res.x > coor_res.y ? coor_res.y : coor_res.x;
        // }
        vec_record += coor_res - coor;
        // if(ratio_flag == 1.)
        // {
        //     factor2 = coor_res.x > coor_res.y ? coor_res.y : coor_res.x;
        // }
        
    }
    
    // if(ratio_flag == 1.)
    // {
    //     factor = min(factor1 > factor2 ? factor2 : factor1, factor);
    // }
    // if(ratio_flag == 1.)
    // {
    //     factor = min(factor1 > factor2 ? factor2 : factor1, factor);
    // }
    
    // stretch_hip
    
    if(stretch_hip_scale != 1.0)
    {
        target_x_ratio = 1.0;
        max_x_ratio = (1.0 - target_x_ratio) * 0.65 + target_x_ratio;
        target_y_ratio = stretch_hip_scale;// 1.0
        max_y_ratio = (1.0 - target_y_ratio) * 0.65 + target_y_ratio;
        center_point = stretch_hip_center_point;
        // x_vec = stretch_hip_x_vec;
        // y_vec = stretch_hip_y_vec;
        left = stretch_hip_left;
        right = stretch_hip_right;
        top = stretch_hip_top;
        bottom = stretch_hip_bottom;
        x_min = stretch_hip_x_min;
        x_max = stretch_hip_x_max;
        y_min = stretch_hip_y_min;
        y_max = stretch_hip_y_max;
        center_point.y = y_min;
        bottom  = y_max - y_min;
        top= 0.;
        mode = 1;
        direction = 1;
        line_type = 0;
        transition_type = 1;
        coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max,
                                 center_point, stretch_hip_cross_point_param_x, stretch_hip_cross_point_param_y, mode, height, width, direction, line_type, transition_type, ratio_flag);
        // if(ratio_flag == 1.)
        // {
        //     factor = min(min(coor_res.x, coor_res.y), factor);
        // }
        vec_record += coor_res - coor;
    }
    
    
    if(arm_scale1 != 1.0)
    {
        target_x_ratio = arm_scale1;
        max_x_ratio = (1.0 - target_x_ratio) * 0. + target_x_ratio;
        target_y_ratio = 1.0;
        max_y_ratio = (1.0 - target_y_ratio) * 0. + target_y_ratio;
        x_min = arm_x_min1;
        x_max = arm_x_max1;
        y_min = arm_y_min1;
        y_max = arm_y_max1;
        coor_res = line_processing(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, x_min, x_max, y_min, y_max, arm_2_vec2, arm_3_vec2, arm_4_vec2, ra, ratio_flag, arm_scale1, arm_part_ratio.xy, 0);
        vec_record += coor_res - coor;
         if(ratio_flag == 1.)
         {
             factor1 = coor_res.x > coor_res.y ? coor_res.y : coor_res.x;
         }
    }
    
    if(arm_scale2 != 1.0)
    {
        target_x_ratio = arm_scale2;
        max_x_ratio = (1.0 - target_x_ratio) * 0. + target_x_ratio;
        target_y_ratio = 1.0;
        max_y_ratio = (1.0 - target_y_ratio) * 0. + target_y_ratio;
        x_min = arm_x_min2;
        x_max = arm_x_max2;
        y_min = arm_y_min2;
        y_max = arm_y_max2;
        
        coor_res = line_processing(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, x_min, x_max, y_min, y_max, arm_5_vec2, arm_6_vec2, arm_7_vec2, ra, ratio_flag, arm_scale2, arm_part_ratio.zw, 1);
        
        vec_record += coor_res - coor;
         if(ratio_flag == 1.)
         {
             factor2 = coor_res.x > coor_res.y ? coor_res.y : coor_res.x;
         }
    }
     if(ratio_flag == 1.)
     {
         factor = min(factor1 > factor2 ? factor2 : factor1, factor);
     }
    
    float tmp_float;
    //shoSlim
    if(sho_target_x_ratio_1 != 1.0)
    {
        target_x_ratio = sho_target_x_ratio_1;// 0.8
        
        max_x_ratio = (1.0 - target_x_ratio) * 0.6 + target_x_ratio;
        target_y_ratio = 1.0;// 0.8
        max_y_ratio = (1.0 - target_y_ratio) * 0.6 + target_y_ratio;
        
        center_point = sho_center_point1;
        // x_vec = sho_x_vec;
        // y_vec = sho_y_vec;
        left = sho_left1;
        right = sho_right1;
        top = sho_top1;
        bottom = sho_bottom1;
        
        x_min = sho_x_min1;
        x_max = sho_x_max1;
        y_min = sho_y_min1;
        y_max = sho_y_max1;
        mode = 0;
        direction = 0;
        line_type = 0;
        transition_type = 0;
        coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max, center_point, sho_cross_point_param_x1, sho_cross_point_param_y1, mode, height, width, direction, line_type, transition_type, ratio_flag);
         if(ratio_flag == 1.)
         {
             factor1 = min(min(coor_res.x, coor_res.y), factor1);
         }
        vec_record += coor_res - coor;
    }
    
    if(sho_target_x_ratio_2 != 1.0)
    {
        target_x_ratio = sho_target_x_ratio_2;// 0.8
        
        max_x_ratio = (1.0 - target_x_ratio) * 0.6 + target_x_ratio;
        target_y_ratio = 1.0;// 0.8
        max_y_ratio = (1.0 - target_y_ratio) * 0.6 + target_y_ratio;
        
        center_point = sho_center_point2;
        // x_vec = sho_x_vec;
        // y_vec = sho_y_vec;
        left = sho_left2;
        right = sho_right2;
        top = sho_top2;
        bottom = sho_bottom2;
        
        // tmp_float = (top + bottom) / sho_dis_between_sho_and_hip_smooth_hard;
        // if(tmp_float < 0.2)
        // {
        //     target_x_ratio = (target_x_ratio - 1.) * tmp_float / 0.2 + 1.;
        // }
        
        x_min = sho_x_min2;
        x_max = sho_x_max2;
        y_min = sho_y_min2;
        y_max = sho_y_max2;
        mode = 0;
        direction = 0;
        line_type = 0;
        transition_type = 0;
        coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max,
                                 center_point, sho_cross_point_param_x2, sho_cross_point_param_y2, mode, height, width, direction, line_type, transition_type, ratio_flag);
        
         if(ratio_flag == 1.)
         {
             factor2 = coor_res.x > coor_res.y ? coor_res.y : coor_res.x;
         }
        vec_record += coor_res - coor;
    }
     if(ratio_flag == 1.)
     {
         factor = min(factor1 > factor2 ? factor2 : factor1, factor);
     }
    
    
    // if(sho_scale != 1.0)
    // {
    //     target_x_ratio = sho_scale;// 0.8
    //     max_x_ratio = (1.0 - target_x_ratio) * 0.6 + target_x_ratio;
    //     target_y_ratio = 1.;// 0.8
    //     max_y_ratio = (1.0 - target_y_ratio) * 0.6 + target_y_ratio;
    
    //     // center_point = sho_center_point1 + sho_x_vec * sho_right1;
    //     // x_vec = sho_x_vec;
    //     // y_vec = sho_y_vec;
    
    //     center_point = sho_center_hori_point1;
    //     left = sho_left1_2;
    //     right = sho_right1_2;
    //     top = sho_top1_2;
    //     bottom = sho_bottom1_2;
    //     x_min = sho_x_min1;
    //     x_max = sho_x_max1;
    //     y_min = sho_y_min1;
    //     y_max = sho_y_max1;
    
    //     mode = 0;
    //     direction = 0;
    //     line_type = 0;
    //     transition_type = 0;
    //     coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max,
    //         center_point, sho_cross_point_param_hori_x1, sho_cross_point_param_hori_y1, mode, height, width, direction, line_type, transition_type, ratio_flag);
    //     //coor_res = vec2(0., 0.);
    
    //     // if(ratio_flag == 1.)
    //     // {
    //     //     factor1 = coor_res.x > coor_res.y ? coor_res.y : coor_res.x;
    //     // }
    //     vec_record += coor_res - coor;
    
    //     // center_point = sho_center_point2 - sho_x_vec * sho_left2;
    //     // x_vec = sho_x_vec;
    //     // y_vec = sho_y_vec;
    
    //     center_point = sho_center_hori_point2;
    //     left = sho_left2_2;
    //     right = sho_right2_2;
    //     top = sho_top2_2;
    //     bottom = sho_bottom2_2;
    //     x_min = sho_x_min2;
    //     x_max = sho_x_max2;
    //     y_min = sho_y_min2;
    //     y_max = sho_y_max2;
    //     mode = 0;
    //     direction = 0;
    //     line_type = 0;
    //     transition_type = 0;
    //     coor_res = processing_v2(coor, target_x_ratio, max_x_ratio, target_y_ratio, max_y_ratio, left, right, top, bottom, x_min, x_max, y_min, y_max,
    //         center_point, sho_cross_point_param_hori_x2, sho_cross_point_param_hori_y2, mode, height, width, direction, line_type, transition_type, ratio_flag);
    
    //     // if(ratio_flag == 1.)
    //     // {
    //     //     factor2 = coor_res.x > coor_res.y ? coor_res.y : coor_res.x;
    //     // }
    //     // if(ratio_flag == 1.)
    //     // {
    //     //     factor = min(factor1 > factor2 ? factor2 : factor1, factor);
    //     // }
    //     vec_record += coor_res - coor;
    // }
    
    
    
    
    
    coor_res = coor + vec_record;
    
     if(ratio_flag == 1.)
     {
         coor_res = coor;
     }
    // if(ratio_flag == 1.)
    // {
    //     coor_res = coor;
    // }
    //
    
    
    
    
    
    // if(width != 0. && height != 0.)
    // {
    // coor_res = coor_res * resolution_inv;
    // if (deviceOrien == 0.0 )
    // {
    //     texToUse.x = coor_res.x;
    //     texToUse.y = 1.0 - coor_res.y;
    // }
    // else if (deviceOrien == 180.0 )
    // {
    //     texToUse.x = coor_res.x;
    //     texToUse.y = coor_res.y;
    // }
    // else if(deviceOrien == 90.0)
    // {
    //     texToUse.x = coor_res.y;
    //     texToUse.y = 1.0 - coor_res.x;
    // }
    // else if(deviceOrien == 270.0)
    // {
    //     texToUse.x = 1.0 - coor_res.y;
    //     texToUse.y = 1.0 - coor_res.x;
    // }
    // } else {
    //     texToUse.y = coor_res.x;
    //     texToUse.x = 1.0 - coor_res.y;
    // }
    
    
    coor_res = coor_res * resolution_inv;
    // texToUse.x = coor_res.x;
    
    
    // texToUse.y = 1.0 - coor_res.y;
    // if(deviceOrien == 0.0 )
    // {
    //     texToUse.x = coor_res.x;
    //     texToUse.y = 1. - coor_res.y;
    // }
    // else if(deviceOrien == 180.0 )
    // {
    //     texToUse.x = 1. - coor_res.x;
    //     texToUse.y = coor_res.y;
    // }
    // else if(deviceOrien == 270.0 )
    // {
    //     texToUse.x = 1. - coor_res.y;
    //     texToUse.y = 1. - coor_res.x;
    // }
    // else
    // {
    //     texToUse.x = coor_res.y;
    //     texToUse.y = coor_res.x;
    // }
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
    
    //int debug = 1;
    
    
     if(factor != 1.)
     {
         color.x  = factor;
         color.y = factor;
         color.z = factor;
     }
    
    
    //if(abs(coor.x - width / 2.) / width < 0.01 && abs(coor.y - height / 2.) / height < 0.01)
    // if(abs(coor.x - stretch_hip_x_min) / width < 0.01 && abs(coor.y - stretch_hip_y_min) / height < 0.01)
    // {
    // color.x = 1.0;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    // if(abs(coor.x - stretch_hip_x_min) / width < 0.01 && abs(coor.y - stretch_hip_y_max) / height < 0.01)
    // {
    // color.x = 0.;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    // if(abs(coor.x - stretch_hip_x_max) / width < 0.01 && abs(coor.y - stretch_hip_y_min) / height < 0.01)
    // {
    // color.x = 1.0;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    // if(abs(coor.x - stretch_hip_x_max) / width < 0.01 && abs(coor.y - stretch_hip_y_max) / height < 0.01)
    // {
    // color.x = 1.0;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    
    // if(abs(coor.x - face_left_bottom_point.x) / width < 0.005 && abs(coor.y - face_left_bottom_point.y) / height < 0.005)
    // {
    // color.x = 0.;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    // if(abs(coor.x - face_right_bottom_point.x) / width < 0.005 && abs(coor.y - face_right_bottom_point.y) / height < 0.005)
    // {
    // color.x = 0.;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    
    
    // if(abs(coor.x - face_point1.x) / width < 0.005 && abs(coor.y - face_point1.y) / height < 0.005)
    // {
    // color.x = 1.;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    // if(abs(coor.x - face_point2.x) / width < 0.005 && abs(coor.y - face_point2.y) / height < 0.005)
    // {
    // color.x = 0.;
    // color.y = 1.;
    // color.z = 1.0;
    // }
    // if(abs(coor.x - face_point3.x) / width < 0.005 && abs(coor.y - face_point3.y) / height < 0.005)
    // {
    // color.x = 0.;
    // color.y = 1.;
    // color.z = 1.0;
    // }
    // if(abs(coor.x - face_point4.x) / width < 0.005 && abs(coor.y - face_point4.y) / height < 0.005)
    // {
    // color.x = 1.;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    
    // if(abs(coor.x - face_left_bottom_point.x) / width < 0.005 && abs(coor.y - face_left_bottom_point.y) / height < 0.005)
    // {
    // color.x = 0.;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    // if(abs(coor.x - face_right_bottom_point.x) / width < 0.005 && abs(coor.y - face_right_bottom_point.y) / height < 0.005)
    // {
    // color.x = 0.;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    
    
    // if(abs(coor.x - face_point1.x) / width < 0.005 && abs(coor.y - face_point1.y) / height < 0.005)
    // {
    // color.x = 1.;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    // if(abs(coor.x - face_point2.x) / width < 0.005 && abs(coor.y - face_point2.y) / height < 0.005)
    // {
    // color.x = 0.;
    // color.y = 1.;
    // color.z = 1.0;
    // }
    // if(abs(coor.x - face_point3.x) / width < 0.005 && abs(coor.y - face_point3.y) / height < 0.005)
    // {
    // color.x = 0.;
    // color.y = 1.;
    // color.z = 1.0;
    // }
    // if(abs(coor.x - face_point4.x) / width < 0.005 && abs(coor.y - face_point4.y) / height < 0.005)
    // {
    // color.x = 1.;
    // color.y = 0.;
    // color.z = 1.0;
    // }
    
    
    // if(abs(coor.x) / width < 0.2 && abs(coor.y) / height < 0.2)
    // {
    //     if(1. == 1.)
    //     {
    //         color.x = 1.;
    //         color.z = 0.;
    //         color.y = 0.;
    //     }
    //     else if(0. == 1.)
    //     {
    //         color.x = 0.;
    //         color.z = 1.;
    //         color.y = 0.;
    //     }
    //     else
    //     {
    //         color.x = 0.;
    //         color.z = 0.;
    //         color.y = 1.;
    //     }
    // }
    
    
    gl_FragColor = color;
}
