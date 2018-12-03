//
//  ViewController.m
//  XZSearchAlgorithm
//
//  Created by kkxz on 2018/12/3.
//  Copyright © 2018 kkxz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,assign)NSInteger searchType;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.searchType = 4;
    NSArray * arr = @[@1,@3,@6,@8,@9,@13];
    if(1==self.searchType){
        //二分查找 - 非递归方式
        NSInteger binary = [self binarySearch:arr target:9];
        NSLog(@"升序二分查找结果 - 非递归：%ld",binary);
    }
    else if(2==self.searchType){
        //二分查找 - 递归方式
        int binary = [self search:arr target:9 start:0 end:(int)(arr.count -1)];
        NSLog(@"升序二分查找结果 - 递归：%d",binary);
    }
    else if(3==self.searchType){
        //插值查找 - 非递归
        NSUInteger binary = [self insertSearch:arr number:@9];
        NSLog(@"插值查找结果 - 非递归：%ld",binary);
    }
    else if(4==self.searchType){
        //插值查找 - 递归
        NSUInteger binary = [self insertSearch:arr key:@9 low:0 high:(NSUInteger)(arr.count -1)];
        NSLog(@"插值查找结果 - 递归：%ld",binary);
    }
    else if(5==self.searchType){
        
    }
    else if(6==self.searchType){
        
    }
    else if(7==self.searchType){
        
    }
}

//TODO：二分查找
/*
 二分法查找:要求元素必须是有序的，如果是无序的则要先进行排序操作
 二分查找的基本思想是通过不断缩小查找的范围，每次将数据与数组中间的数据进行比较，从而一步一步进行比较并且缩小范围，进而找到目标数。
 给定一个排好序的数组，要确定该数组是否含有给定元素，可以先看中间元素是否等于给定元素，如果不等，那么根据数组的排序特性，我们可以确定，该数组要包含该元素的话，那么该元素肯定处于中间元素的左边部分或是右边部分，于是我们一下子可以把搜索范围缩小一半。于是每次查找都可以把范围缩小一半，因此无需多次操作，我们就可以确认数据是否含有给定元素。
 while循环  示例：给你一个数组，再给你个 target，找到 target 在数组中的位置，找不到就返回 - 1。
 */
//非递归方式
-(NSInteger)binarySearch:(NSArray*)arr target:(NSInteger)target {
    if(arr.count == 0){
        return -1;
    }
    NSInteger start = 0;
    NSInteger end = arr.count - 1;
    NSInteger mid = 0;
    
    while (start +1 < end) {
        mid = start + (end - start)/2;
        if([arr[mid] integerValue] == target){
            return mid;//相邻就退出
        }
        else if([arr[mid] integerValue] < target){
            //降序
            start = mid;
        }
        else{
            end = mid;
        }
    }
    
    if([arr[start] integerValue] == target){
        return start;
    }
    if([arr[end] integerValue] == target){
        return end;
    }
    return -1;
}

//递归方式
-(int)search:(NSArray*)array target:(int)target start:(int)start end:(int)end {
    if(start > end
       ||start > array.count-1
       ||end > array.count -1) {
        return -1;
    }
    int mid = start + (end - start)/2;
    if(target > [array[mid] intValue]){
        return [self search:array target:target start:mid+1 end:end];
    }
    else if(target < [array[mid] intValue]){
        return [self search:array target:target start:start end:mid-1];
    }
    else{
        return mid;
    }
}

//TODO: 插值查找
/*
 基于二分查找算法,将查找点的选择改进为自适应选择,可以提高查找效率。当然,差值查找也属于有序查找。
 */
/**
 * 插值查找循环实现
 */
- (NSUInteger)insertSearch:(NSArray *)srcArray number:(NSNumber *)des {
    NSUInteger low = 0;
    NSUInteger high = srcArray.count - 1;
    NSInteger middle = 0;
    while (low <= high
           && low <= srcArray.count - 1
           && high <= srcArray.count - 1) {
        middle = low + ([des integerValue] - [srcArray[low] integerValue])/([srcArray[high] integerValue] - [srcArray[low] integerValue]) * (high - low);
        // 防止middle越界
        if (middle > high || middle < low) {
            return-1;
        }
        if ([des integerValue] == [srcArray[middle] integerValue]) {
            return middle;
        }
        else if ([des integerValue] < [srcArray[middle] integerValue]) {
            high = middle - 1;
        }
        else {
            low = middle + 1;
        }
    }
    return -1;
}

/**
 * 插值查找递归实现
 */
- (NSUInteger)insertSearch:(NSArray *)srcArray key:(NSNumber *)des low:(NSUInteger)low high:(NSUInteger)high {
    // 防止low和high越界
    if (low > high
        || low > srcArray.count - 1
        || high > srcArray.count - 1) {
        return -1;
    }
    NSUInteger middle = low + ([des integerValue] - [srcArray[low] integerValue])/([srcArray[high] integerValue] - [srcArray[low] integerValue]) * (high - low);
    // 防止middle越界
    if (middle > high || middle < low) {
        return -1;
    }
    if ([srcArray[middle] integerValue]== [des integerValue]) {
        return middle;
    }
    else if ([srcArray[middle] integerValue]> [des integerValue]) {
        return [self insertSearch:srcArray key:des low:low high:middle - 1];
    }
    else {
        return [self insertSearch:srcArray key:des low:middle + 1 high:high];
    }
    return -1;
}

@synthesize searchType = _searchType;
@end
