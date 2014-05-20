//
//  VSTabBar.m
//
//  Created by Vincent Saluzzo on 25/05/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "VSTabBar.h"


@interface VSTabBar()
@property (nonatomic,retain)  NSArray* _items;
@property (nonatomic) NSInteger _selectedItem;
@property (nonatomic,retain) NSMutableArray* _itemsView;
@property (nonatomic) NSInteger _currentItemViewed;

@end

@implementation VSTabBar
@synthesize drawTitle = _drawTitle;
@synthesize drawImage = _drawImage;
@synthesize showSeparationBetweenItems = _showSeparationBetweenItems;
@synthesize showSelectedItem = _showSelectedItem;
@synthesize showCurrentSelected = _showCurrentSelected;
@synthesize isTopBar = _isTopBar;
@synthesize backgroundColor = _backgroundColor;
@synthesize separatorColor = _separatorColor;
@synthesize selectionGradientColor = _selectionGradientColor;
@synthesize currentSelectionIndicatorColor = _currentSelectionIndicatorColor;
@synthesize foregroundColor = _foregroundColor;
@synthesize delegate;

@synthesize _items;
@synthesize _selectedItem;
@synthesize _itemsView;
@synthesize _currentItemViewed;


@synthesize itemList;
@synthesize selectedItem;


- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initTabBar];        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTabBar];
    }
    return self;
}

-(NSArray*) itemList
{
    return self._items;
}

-(VSTabBarItem*) selectedItem
{
    VSTabBarItem *result = nil;
    if (self._items.count > 0 && self._selectedItem > -1) {
        result = [self._items objectAtIndex:self._selectedItem];
    }
    return result;
}

-(void) initTabBar {
    self._selectedItem = -1;
    self._currentItemViewed = -1;
    self._itemsView = [[NSMutableArray alloc] init];
    self.drawImage = YES;
    self.drawTitle = YES;
    self.isTopBar = NO;
    self.showSelectedItem = YES;
    self.showCurrentSelected = YES;
    self.showSeparationBetweenItems = YES;
    self.currentSelectionIndicatorColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor blackColor];
    self.selectionGradientColor = [UIColor whiteColor];
    self.separatorColor = [UIColor whiteColor];
    self.foregroundColor = [UIColor whiteColor];
    
    self.userInteractionEnabled = YES;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    CGContextAddPath(currentContext, path);
    
    [_backgroundColor setFill];
    CGContextDrawPath(currentContext, kCGPathFill);
    
    for (UIView* subview in self.subviews) {
        [subview removeFromSuperview];
        [subview release];
    }
    
    if(self._items) {
        int count = [self._items count];
        float itemWidth = self.frame.size.width / count;
        float itemHeight = self.frame.size.height;
        
        [self._itemsView removeAllObjects];
        int indexOfCreation = 0;
        for (VSTabBarItem* anItem in self._items) {
            UIView* itemView = [[UIView alloc] initWithFrame:CGRectMake(itemWidth*indexOfCreation, 0, itemWidth, itemHeight)];
            
            if(_drawImage &&_drawTitle) {
                UIImageView* itemImage = [[UIImageView alloc] initWithImage:[anItem.image tintWithColor:_foregroundColor]];
                UILabel* itemLabel = [[UILabel alloc] init];
                if(_isTopBar) {
                    itemImage.frame = CGRectMake(0*indexOfCreation+10, 5, itemWidth-20, itemHeight/10*5 -5);
                    itemLabel.frame = CGRectMake(10, 5 + itemHeight/10*5, itemWidth-20, itemHeight/10*5 - 15);
                } else {
                    itemImage.frame = CGRectMake(0*indexOfCreation+10, 10, itemWidth-20, itemHeight/10*5 -5);
                    itemLabel.frame = CGRectMake(10, 5 + itemHeight/10*5, itemWidth-20, itemHeight/10*5 - 5);
                }
                [itemImage setContentMode:UIViewContentModeScaleAspectFit];
            
                
                [itemLabel setText:anItem.title];
                [itemLabel setContentMode:UIViewContentModeScaleAspectFit];
                [itemLabel setFont:[UIFont systemFontOfSize:12.0f]];
                [itemLabel setBackgroundColor:[UIColor clearColor]];
                [itemLabel setTextColor:_foregroundColor];
            
                [itemView addSubview:itemLabel];
                [itemView addSubview:itemImage];
            } else if(_drawImage && !_drawTitle) {
                UIImageView* itemImage = [[UIImageView alloc] initWithImage:anItem.image];
                if(_isTopBar) {
                    itemImage.frame = CGRectMake(0*indexOfCreation+10, 5, itemWidth-20, itemHeight - 15);
                } else {
                    itemImage.frame = CGRectMake(0*indexOfCreation+10, 10, itemWidth-20, itemHeight - 15);
                }
                [itemImage setContentMode:UIViewContentModeScaleAspectFit];
                [itemView addSubview:itemImage];
                
            } else if(!_drawImage && _drawTitle) {
                UILabel* itemLabel = [[UILabel alloc] init];
                itemLabel.frame = CGRectMake(10, 5, itemWidth-20, itemHeight - 5);
                [itemLabel setText:anItem.title];
                [itemLabel setContentMode:UIViewContentModeScaleAspectFit];
                [itemLabel setFont:[UIFont systemFontOfSize:12.0f]];
                [itemLabel setBackgroundColor:[UIColor clearColor]];
                [itemLabel setTextColor:_foregroundColor];
                
                [itemView addSubview:itemLabel];
                
            } else {
                
            }
            [self addSubview:itemView];
            [self._itemsView addObject:itemView];
            indexOfCreation++;
        }
    }
    
    if(self._selectedItem > -1 && _showSelectedItem) {
        float itemWidth = self.frame.size.width / [self._items count];
        float xPoint = _selectedItem * itemWidth + itemWidth/2;
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        UIColor* startColor = _selectionGradientColor;
        CGFloat* startColorComponents = (CGFloat*)CGColorGetComponents([startColor CGColor]);
        
        UIColor* endColor = _backgroundColor;
        CGFloat* endColorComponents = (CGFloat*)CGColorGetComponents([endColor CGColor]);
        
        CGFloat colorComponents[8] = {
            //Four components of the blue color
            startColorComponents[0],
            startColorComponents[1],
            startColorComponents[2],
            startColorComponents[3],
            
            //Four components of the green color
            endColorComponents[0],
            endColorComponents[1],
            endColorComponents[2],
            endColorComponents[3]
        };
        
        CGFloat colorIndices[2] = {
            0.0f, 1.0f
        };
        
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, &colorComponents, &colorIndices, 2);
        
        CGColorSpaceRelease(colorSpace);
        
        float centerOfRadial = (_isTopBar) ? 0.0f : self.frame.size.height;
        
        CGContextDrawRadialGradient(currentContext, gradient, CGPointMake(xPoint, centerOfRadial), 0.0f, CGPointMake(xPoint, centerOfRadial), itemWidth/2.0f, kCGGradientDrawsAfterEndLocation|kCGGradientDrawsBeforeStartLocation);
        
        CGGradientRelease(gradient);
        
        CGPathRelease(path);    
    }
    
    if(self._currentItemViewed > -1 && _showCurrentSelected) {
        float itemWidth = self.frame.size.width / [self._items count];
        CGMutablePathRef pathCurrentItemSelected = CGPathCreateMutable();
        if(_isTopBar) {
            float topArrow = _currentItemViewed * itemWidth + itemWidth/2;
            CGPathMoveToPoint(pathCurrentItemSelected, NULL, topArrow, self.frame.size.height-7);
            CGPathAddLineToPoint(pathCurrentItemSelected, NULL, topArrow-5, self.frame.size.height);
            CGPathAddLineToPoint(pathCurrentItemSelected, NULL, topArrow+5, self.frame.size.height);
        } else {
            float topArrow = _currentItemViewed * itemWidth + itemWidth/2;
            CGPathMoveToPoint(pathCurrentItemSelected, NULL, topArrow, 7);
            CGPathAddLineToPoint(pathCurrentItemSelected, NULL, topArrow-5, 0);
            CGPathAddLineToPoint(pathCurrentItemSelected, NULL, topArrow+5, 0);
        }
        
        [_currentSelectionIndicatorColor setFill];
        
        CGContextAddPath(UIGraphicsGetCurrentContext(), pathCurrentItemSelected);
        CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFill);
        
        CGPathRelease(pathCurrentItemSelected);
        
    }
    
    if(_showSeparationBetweenItems) {
        float itemWidth = self.frame.size.width / [self._items count];
        for(int i = 0; i < [self._items count]; i++) {
            [_separatorColor set];
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.1f);
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), itemWidth*(float)i, 0);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), itemWidth*(float)i, self.frame.size.height);
            CGContextStrokePath(UIGraphicsGetCurrentContext());
        }
    }
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if([touches count] == 1) {
        UITouch* aTouch = [[touches allObjects] objectAtIndex:0];
        float itemWidth = self.frame.size.width / [self._items count];
        CGPoint touchPoint = [aTouch locationInView:self];
        
        NSInteger itemTouched = touchPoint.x / itemWidth;
        
        self._selectedItem = itemTouched;
        self._currentItemViewed = _selectedItem;
        
    }
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _selectedItem = -1;
    [self setNeedsDisplay];
    if([delegate respondsToSelector:@selector(tabBar:selectedItemWithIndex:)]) {
        [delegate tabBar:self selectedItemWithIndex:_currentItemViewed];
    }
}

-(void)setItems:(NSArray *)itemsArray {
    if(self._items) {
        [self._items release];
    }
    self._items = [itemsArray retain];
    [self setNeedsDisplay];
}

-(void) selectItem:(NSInteger)index {
    _selectedItem = index;
    _currentItemViewed = _selectedItem;
    [self setNeedsDisplay];
}

@end
