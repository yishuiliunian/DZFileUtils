//
//  DZFileUtils.h
//  Pods
//
//  Created by stonedong on 16/3/6.
//
//

#import <Foundation/Foundation.h>

#define NSShareFileManager [NSFileManager defaultManager]

FOUNDATION_EXTERN void DZEnsurePathExist(NSString* path);
FOUNDATION_EXTERN NSString* DZDocumentsPath();
FOUNDATION_EXTERN NSString* DZDocumentsSubPath(NSString* name);
FOUNDATION_EXTERN NSString* DZSettingsFilePath();
FOUNDATION_EXTERN NSString* DZAppendPath();

FOUNDATION_EXTERN_INLINE NSString* DZPathJoin(NSString* a, NSString* b) {
    return [a stringByAppendingPathComponent:b];
}

