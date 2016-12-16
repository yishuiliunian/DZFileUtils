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
FOUNDATION_EXTERN NSString* DZFileInSubPath(NSString* subPath, NSString* fileName);
FOUNDATION_EXTERN BOOL DZFileExist(NSString* path);
FOUNDATION_EXTERN BOOL DZMoveFile(NSString* originPath, NSString* aimPath, NSError* __autoreleasing* error) ;
FOUNDATION_EXTERN int64_t DZDirectorySize(NSString * path, NSFileManager * fileManager);

FOUNDATION_EXTERN  NSString * DZApplicationDocumentsPath();
FOUNDATION_EXTERN  NSString * DZApplicationLibaryPath();
FOUNDATION_EXTERN  NSString * DZApplicationTempPath();
FOUNDATION_EXTERN  NSString * DZFilteLocalPath(NSString * originPath);
FOUNDATION_EXTERN  NSString * DZGenerateLocalPath(NSString * pathCompents);
FOUNDATION_EXTERN  NSURL * DZMediaURL(NSString * path);
#endif