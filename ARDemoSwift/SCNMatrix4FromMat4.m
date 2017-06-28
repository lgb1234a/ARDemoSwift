//
//  SCNMatrix4FromMat4.m
//  ARDemoSwift
//
//  Created by chenyn on 2017/6/27.
//  Copyright © 2017年 chenyn. All rights reserved.
//

#import "SCNMatrix4FromMat4.h"

@implementation SCNMatrix4FromMat4Class

+ (SCNMatrix4)SCNMatrix4FromMat4Mth:(matrix_float4x4)originMatrix
{
    return SCNMatrix4FromMat4(originMatrix);
}

@end
