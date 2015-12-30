//
//  foundLikeCarModel.h
//  Driving
//
//  Created by 黄欣 on 15/12/30.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface foundLikeCarModel : NSObject
/**
 *  id	string	品牌id
 */
@property (nonatomic , copy)NSString *id;
/**
*  name	string	品牌名
*/
@property (nonatomic , copy)NSString *name;
/**
*  imageSrc	string	图片链接地址，前缀为http://image.carzone.cn
*/
@property (nonatomic , copy)NSString *imageSrc;
@end
