//
//  ViewUtils.swift
//  iService
//
//  Created by Admin on 9/15/21.
//

//+(void)borderView: (UIView *)view thickness: (CGFloat)thickness corner: (CGFloat)corner borderColor: (NSString *)borderColor bodyColor: (NSString *)bodyColor;
//+(void)borderViewWithColor: (UIView *)view thickness: (CGFloat)thickness corner: (CGFloat)corner borderColor: (UIColor *)borderColor bodyColor: (UIColor *)bodyColor;
//+(void)setupCornerView: (UIView *)view corner: (CGSize)corner bodyColor: (UIColor *)bodyColor thickness:(CGFloat)thickness borderColor: (UIColor *)borderColor rectCorner: (UIRectCorner)rectConer;


import Foundation
import UIKit

enum ViewUtils {
    static func borderView(view: UIView?, thickness: Float, corner: Float, boderColor: UIColor?, bodyColor: UIColor?){
        view?.layer.cornerRadius = CGFloat(corner);
        view?.layer.masksToBounds = true;
        view?.layer.borderWidth = CGFloat(thickness);
        view?.layer.borderColor = boderColor?.cgColor;
        view?.layer.backgroundColor = bodyColor?.cgColor;
    }
}

