//
//  DZFileUtils.h
//  Pods
//
//  Created by stonedong on 16/3/6.
//
//

#import <Foundation/Foundation.h>

#ifndef __DZFileUtils
#define __DZFileUtils

#define NSShareFileManager [NSFileManager defaultManager]
FOUNDATION_EXTERN void DZEnsurePathExist(NSString* path);
FOUNDATION_EXTERN NSString* DZDocumentsPath();
FOUNDATION_EXTERN NSString* DZDocumentsSubPath(NSString* name);
FOUNDATION_EXTERN NSString* DZSettingsFilePath();
FOUNDATION_EXTERN NSString* DZAppendPath();
FOUNDATION_EXTERN NSString* DZMKTempDirectory();
FOUNDATION_EXTERN NSString* DZPathJoin(NSString* a, NSString* b);
FOUNDATION_EXTERN NSString* DZTempDir();
FOUNDATION_EXTERN NSString* DZTempFilePathWithExtension(NSString* extension);
FOUNDATION_EXTERN void DZRemoveFileByPath(NSString* path);
FOUNDATION_EXTERN NSString* DZFileInSubPath(NSString* fileName, NSString* subPath);
#endif