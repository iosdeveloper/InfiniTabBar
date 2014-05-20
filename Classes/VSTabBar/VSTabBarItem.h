//
//  VSTabBarItem.h
//
//  Created by Vincent Saluzzo on 25/05/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSTabBarItem : NSObject {
    UIImage* _image;
    NSString* _title;
}
@property(nonatomic,retain) UIImage* image;
@property(nonatomic,retain) NSString* title;
@property (nonatomic) NSInteger tag;

-(id) initWithImage:(UIImage*)anImage andTitle:(NSString*)aTitle andTag:(NSInteger)itemTag;
-(id) initWithImage:(UIImage*)anImage andTag:(NSInteger)itemTag;
-(id) initWithTitle:(NSString*)aTitle andTag:(NSInteger)itemTag;

@end
