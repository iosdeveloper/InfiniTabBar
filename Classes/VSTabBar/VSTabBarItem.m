//
//  VSTabBarItem.m
//
//  Created by Vincent Saluzzo on 25/05/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "VSTabBarItem.h"

@implementation VSTabBarItem
@synthesize image;
@synthesize title;
@synthesize tag;

-(id)initWithImage:(UIImage *)anImage andTitle:(NSString *)aTitle andTag:(NSInteger)itemTag {
    self = [super init];
    if(self) {
        self.image = anImage;
        self.title = aTitle;
        self.tag = itemTag;
    }
    return self;
}

-(id)initWithImage:(UIImage *)anImage andTag:(NSInteger)itemTag {
    return [self initWithImage:anImage andTitle:nil andTag:itemTag];
}

-(id)initWithTitle:(NSString *)aTitle andTag:(NSInteger)itemTag {
    return [self initWithImage:nil andTitle:aTitle andTag:itemTag];
}
@end
