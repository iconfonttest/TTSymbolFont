//
//  Created by CocoaPods on TODAYS_DATE.
//  Copyright (c) 2014 PROJECT_OWNER. All rights reserved.
//

#import "UIFont+TTSymbolFont.h"
@import CoreText;

@interface TTBundleKey : NSObject
@end
@implementation TTBundleKey
@end

NSString *const kTTSymbolFontFamilyName = @"icons";

@implementation UIFont (TTSymbolFont)

+ (instancetype)tt_symbolFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:kTTSymbolFontFamilyName size:size];
    if (!font) {
        NSBundle* bundle = [NSBundle bundleForClass:[TTBundleKey class]];
        NSString *fontPath = [bundle pathForResource:kTTSymbolFontFamilyName ofType:@"ttf"];
        NSData *inData = [NSData dataWithContentsOfFile:fontPath];
        CFErrorRef error;
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)inData);
        CGFontRef cgFont = CGFontCreateWithDataProvider(provider);
        if (! CTFontManagerRegisterGraphicsFont(cgFont, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        CFRelease(cgFont);
        CFRelease(provider);
        font = [UIFont fontWithName:kTTSymbolFontFamilyName size:size];
    }
    return font;
}

@end
