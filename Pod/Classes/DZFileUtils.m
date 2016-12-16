//
//  DZFileUtils.m
//  Pods
//
//  Created by stonedong on 16/3/6.
//
//

#import "DZFileUtils.h"
#import <Foundation/Foundation.h>
void DZEnsurePathExist(NSString* path)
{
    NSCParameterAssert(path);
    BOOL exist = [NSShareFileManager fileExistsAtPath:path];
    if (!exist) {
        NSError* error = nil;
        [NSShareFileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
}


BOOL DZFileExist(NSString* path) {
    return  [NSShareFileManager fileExistsAtPath:path];
}

NSString * DZApplicationDocumentsPath() {
    static NSString* documentsPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* urls =  [NSShareFileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL* url = urls[0];
        documentsPath = [url path];
    });
    return documentsPath;
}

NSString * DZApplicationLibaryPath()
{
    static NSString* documentsPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* urls =  [NSShareFileManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
        NSURL* url = urls[0];
        documentsPath = [url path];
    });
    return documentsPath;
}

NSString * DZApplicationDirectory()
{
    static NSString* documentsPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* urls =  [NSShareFileManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
        NSURL* url = urls[0];
        documentsPath = [url path];
        documentsPath = [documentsPath stringByDeletingLastPathComponent];
    });
    return documentsPath;
}
NSString * DZApplicationTempPath()
{
    return NSTemporaryDirectory();
}

NSString* DZDocumentsPath()
{
    static NSString* documentsPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* urls =  [NSShareFileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL* url = urls[0];
        documentsPath = [url path];
        documentsPath = [documentsPath stringByAppendingPathComponent:@"MainData"];
        DZEnsurePathExist(documentsPath);
    });
    return documentsPath;
}


NSString* DZSettingsFilePath()
{
    return [DZDocumentsPath() stringByAppendingPathComponent:@"settings.plist"];
}

NSString* DZAppendPath(NSString* parentPath, NSString* sub) {
    NSString* str = [parentPath stringByAppendingPathComponent:sub];
    DZEnsurePathExist(str);
    return str;
}

NSString* DZTempDir(){
    return NSTemporaryDirectory();
}

NSString* DZMKTempDirectory(){
    NSString* path = [[NSUUID UUID] UUIDString];
    return DZAppendPath(DZTempDir(), path);
}

NSString* DZDocumentsSubPath(NSString* str) {
    return DZAppendPath(DZDocumentsPath(), str);
}


NSString* DZPathJoin(NSString* a, NSString* b) {
    return [a stringByAppendingPathComponent:b];
}


NSString* DZTempFilePathWithExtension(NSString* extension){
    NSString* fileName = [NSUUID UUID].UUIDString;
    NSString* path = DZTempDir();
    path = [path stringByAppendingPathComponent:fileName];
    path = [path stringByAppendingPathExtension:extension];
    return path;
}

void DZRemoveFileByPath(NSString* path) {
    NSError* error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
}


NSString* DZFileInSubPath(NSString* subPath, NSString* fileName){
    NSString* sp = DZDocumentsSubPath(subPath);
    DZEnsurePathExist(sp);
    return [sp stringByAppendingPathComponent:fileName];
}

BOOL DZMoveFile(NSString* originPath, NSString* aimPath, NSError* __autoreleasing* error) {
   return  [[NSFileManager defaultManager] moveItemAtPath:originPath toPath:aimPath error:error];
}

int64_t DZDirectorySize(NSString * path, NSFileManager * fileManager) {

    BOOL  isDirectory = NO;
    BOOL  exist =[fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    if (!exist) {
        return 0;
    }

    if (!isDirectory){
        return 0;
    }

    int64_t  totalSize = 0;

    NSDirectoryEnumerator * itor = [fileManager enumeratorAtPath:path];
    NSString * file ;
    while (file = [itor nextObject]) {
        BOOL  isD;
        BOOL  isE;
        NSString * checkPath = [path stringByAppendingPathComponent:file];
        isE = [fileManager fileExistsAtPath:checkPath isDirectory:&isD];
        if (isE && !isD) {
            NSError * error;
            NSDictionary * attributes = [fileManager attributesOfItemAtPath:checkPath error:&error];
            if (!error && attributes ) {
                totalSize += [attributes fileSize];
            }
        }
    }
    return totalSize;
}


NSString * DZFilteLocalPath(NSString * originPath) {
    if (!originPath || originPath.length < DZApplicationDirectory().length) {
        return originPath;
    }
    NSRange range = [originPath rangeOfString:DZApplicationDirectory()];
    if (range.location != NSNotFound) {
        return [originPath substringFromIndex:range.location + range.length];
    }
    return originPath;
}

NSString * DZGenerateLocalPath(NSString * pathCompents) {
    return [DZApplicationDirectory() stringByAppendingPathComponent:pathCompents];
}


NSURL * DZMediaURL(NSString * path)
{
    if ([path hasPrefix:@"http"]) {
        return [NSURL URLWithString:path];
    } else {
        return [NSURL fileURLWithPath:DZGenerateLocalPath(path)];
    }
}