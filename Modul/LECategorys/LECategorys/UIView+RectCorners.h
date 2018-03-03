// This file is part of "PdSForUIKit"
//
// "PdSForUIKit" is free software: you can redistribute it and/or modify
// it under the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// "PdSMatrix" is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU LESSER GENERAL PUBLIC LICENSE for more details.
//
// You should have received a copy of the GNU LESSER GENERAL PUBLIC LICENSE
// along with "PdSForUIKit"  If not, see <http://www.gnu.org/licenses/>
//
//  UIView+RoundedRect.h
//  PdSForUIKit
//
//  Created by Benoit Pereira da Silva on 23/11/2013.
//  Copyright (c) 2013 http://pereira-da-silva.com  All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (RectCorners)

/**
 *  Sets the rect corners.
 *
 *  @param corners UIRectCornerAllCorners for all, bottom only (UIRectCornerBottomLeft|UIRectCornerBottomRight)
 *  @param radius  the corner radius
 */
- (void)setRectCorners:(UIRectCorner)corners
                withRadius:(CGFloat)radius;

/**
 *  Sets the rect corners.
 *
 *  @param corners UIRectCornerAllCorners for all, bottom only (UIRectCornerBottomLeft|UIRectCornerBottomRight)
 *  @param radius  the corner radius
 *  @param padding the padding
 */
- (void)setRectCorners:(UIRectCorner)corners
                withRadius:(CGFloat)radius
               andPadding:(UIEdgeInsets)padding;


/**
 *  For those that do not like the UIEdgeInsets syntax
 *
 *  @param corners UIRectCornerAllCorners for all, bottom only (UIRectCornerBottomLeft|UIRectCornerBottomRight)
 *  @param radius  the corner radius
 *  @param top     top padding mask
 *  @param bottom  bottom  padding mask
 *  @param left    left padding mask
 *  @param right   right padding mask
 */
- (void)setRectCorners:(UIRectCorner)corners
                withRadius:(CGFloat)radius
            top:(CGFloat)top
         bottom:(CGFloat)bottom
           left:(CGFloat)left
          right:(CGFloat)right;


/**
 *  Defines if the view has already been masked
 *
 *  @return YES if the view has a mask
 */
- (BOOL)hasBeenMasked;

/**
 *  Re-apply the mask if there one if the size of the view has changed.
 */
- (void)remaskIfNecessary;


/**
 *  Masks the current view to be circular
 *
 *  @param circular
 */
- (void)setCircular:(BOOL)circular;


/**
 *  You can add a border (if your set Rect corners)
 *
 *  @param color the border color
 *  @param width the border width
 */
- (void)setBorderColor:(UIColor*)color
              andWidth:(CGFloat)width;


#pragma mark - UI_APPEARANCE_SELECTOR

- (UIRectCorner)rectCorners UI_APPEARANCE_SELECTOR;
- (void)setRectCorners:(UIRectCorner)aRectCorners UI_APPEARANCE_SELECTOR;
- (UIEdgeInsets)padding UI_APPEARANCE_SELECTOR;
- (void)setPadding:(UIEdgeInsets)aPadding UI_APPEARANCE_SELECTOR;
- (CGFloat)radius UI_APPEARANCE_SELECTOR;
- (void)setRadius:(CGFloat)aRadius UI_APPEARANCE_SELECTOR;
- (UIColor *)borderColor UI_APPEARANCE_SELECTOR;
- (void)setBorderColor:(UIColor *)aBorderColor UI_APPEARANCE_SELECTOR;
- (CGFloat)borderWidth UI_APPEARANCE_SELECTOR;
- (void)setBorderWidth:(CGFloat)aBorderWidth UI_APPEARANCE_SELECTOR;

#pragma mark - experimental

/*
 
 CAShapeLayer *__weak weakShape=[CAShapeLayer layer];
 weakShape.strokeStart=0.0f;
 weakShape.strokeColor=kAZUIGreenColor.CGColor; // We don not use the bordercolor
 weakShape.lineCap=kCALineCapRound;
 weakShape.lineJoin=kCALineJoinRound;
 weakShape.lineWidth=3.f;
 weakShape.lineDashPhase=3.f;
 weakShape.lineDashPattern=@[@(7),@(3),@(5),@(2)];
 weakShape.fillColor=nil;
 [cell applyShapeLayerPrototype:weakShape];

[cell setRectCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight
              radius:8.f
                 top:5.f
              bottom:0.f
                left:20.f
               right:20.f];
 */


/**
 *  Advanced shape addition, all the shapeLayer properties will be applied  to the current bezier path
 *  The shapeLayerPrototype will be retained so you need to pass a Weak reference.
 *  CAShapeLayer*__weak weakShape=[CAShapeLayer layer];
 *  Use strokeColor
 *  
 *
 *  @param shapeLayer the shapeLayer prototype that will be applyied to the current bezier path
 */
- (void)applyShapeLayerPrototype:(CAShapeLayer*)shapeLayerPrototype;


@end
