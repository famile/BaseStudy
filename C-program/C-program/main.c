//
//  main.c
//  C-program
//
//  Created by 李涛 on 2018/10/23.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <stdarg.h>


#ifdef DEBUG

#else

#endif

int* twoSum(int* nums, int numsSize, int target);
int maxNum(int,int);
void getSeconds(unsigned long *par);
double getAverage(int *arr, int size);
void testPointer(void);
void writeFile(void);
void readFile(void);
int factorial(unsigned int i);
double average(int num,...);
void memoryAlloc(void);
void printArr(int arr[], int len);
void insert_sort(int arr[],int len);

void bubble_sort(int arr[], int len);
void selection_sort(int arr[], int len);

#pragma mark - struct

//struct Books {
//    char title[50];
//    char author[50];
//    int book_id;
//} book;


typedef struct {
    char title[50];
    char author[50];
    int book_id;
}Books;

int main(int argc, const char * argv[]) {
    // insert code here...

    
//    callBackFunc();
//    testPointer();
//    writeFile();
//    readFile();
//     printf("%d\n",factorial(5));
//    printf("%f\n",average(1,2,3));
//    memoryAlloc();
    
    int arr[] = {5,3,2,4,1};
//    bubble_sort(arr, 5);
//    selection_sort(arr, 5);
//    insert_sort(arr, 5);
    printArr(arr, 5);
    
    twoSum(arr, 5, 9);
    printf("");
    
    return 0;
}

int* twoSum(int* nums, int numsSize, int target) {
    static int res[2] = {};
    for (int i = 0; i<numsSize; i++) {
        for (int j = i+1; j < numsSize; j++) {
            if (nums[i] + nums[j] == target) {
                res[0] = i;
                res[1] = j;
                return res;
            }
        }
    }
    return 0;
}

int maxNum(int a,int b){
    if (a <= b) {
        return b;
    }else{
        return a;
    }
}

void getSeconds(unsigned long *par){
    *par = time(NULL);
    return;
}

double getAverage(int *arr, int size){
    
    double sum = 0;
    for (int i = 0; i < size; ++i) {
        sum += arr[i];
    }
    return sum / size;
}

double average(int num,...){
    va_list valist;
    double sum = 0.0;
    //为num个参数初始化valist
    va_start(valist,num);
    for (int i = 0; i < num; ++i) {
        sum += va_arg(valist,int);
    }
    va_end(valist);
    return sum/num;
}

void testPointer(){
    //指向指针的指针
    int var = 10;
    int *p = &var;
    int **pp = &p;
    printf("%d,%d,%d\n",var,*p,**pp);
}

/**
 函数指针(函数名其实就是指针，指向函数的首地址)
 */
void funcPointer(){
    int (*p)(int,int) = &maxNum;
    printf("%d\n",p(1,2));
}


void populate_array(int *array,size_t arraySize, int(*getNextValue)(void)){
    for (size_t i = 0; i<arraySize; ++i) {
        int temp = getNextValue();
        printf("%d\n",temp);
        array[i] = temp;
    }
}

int getNextRandomValue(void){
    return rand();
}

/**
 回调函数
 */
void callBackFunc(void){
    int arr1[10];
    populate_array(arr1, 10, getNextRandomValue);
}


void stringTest(void){
    //    char greeting[6] = {'H', 'e', 'l', 'l', 'o', '\0'};
    char greeting[] = "Hello";
    /*
     strlen() 返回字符串长度 找到'\0'结束
     sizeof() 变量或者类型的大小，单位字节
     */
    printf("%s %lu %lu\n",greeting,sizeof(greeting),strlen(greeting));

    /*
     char * 个char a[] 的本质区别
     当定义char a[10]时，编译器会给数组分配10个单元，每个单元的数据类型为字符
     char *s 这个是个指针变量，只占4个字节，32位，用来表示一个地址
     printf("%p",s); 这个表示s的单元中所表示的地址
     printf("%p",&s); 这个表示变量本身所在内存单元地址

     char ** 与 char *a[]
     char *a[] = {"China","French","America","German"}；
     ex: 由于[] 的优先级高于* 所以a先和 []结合，他还是一个数组，数组中的元素才是char * ，前面讲到char * 是一个变量，保存的地址。。

     char **s;
     char **为二级指针， s保存一级指针char *的地址

     */

}

/**
 结构体
 */
void structTest(void){
    Books book = {"book1","taotao",123};
    Books * book_pointer = &book;
    printf("%s\n",book_pointer->title);
    printf("%s\n",book.title);
}

void writeFile(void){
//    FILE *fp = NULL;
//    fp = fopen("/Users/litao/Desktop/file_test.txt", "w+");
////    fprintf(fp, "const char *restrict, ...\n");
//    fputs("const char *restrict, ...\n", fp);
//    fclose(fp);
    
    FILE *fp = NULL;
    fp = fopen("/Users/litao/Desktop/file_test.txt", "r+");
    fprintf(fp, "This is testing for fprintf...\n");
    /*
     int fseek(FILE *stream, long offset, int whence);
     whence 可以是 SEEK_SET,SEEK_CUR,SEEK_END 这些值决定是从文件头、当前点和文件尾计算偏移量 offset。
    */
    
    fseek(fp, 10, SEEK_SET);
    if (fputc(65, fp) == EOF) {
        printf("fputc fail");
    }
    fclose(fp);
}

void readFile(void){
    FILE *fp = NULL;
    char buff[255];
    fp = fopen("/Users/litao/Desktop/file_test.txt", "r");
    fscanf(fp, "%s",buff);
    printf("1: %s\n", buff );
    
    fgets(buff, 255, (FILE *)fp);
    printf("2:%s\n",buff);
    
}


/**
 n的阶乘（递归）

 @param i <#i description#>
 @return <#return value description#>
 */
int factorial(unsigned int i){
    if (i <= 1){
        return 1;
    }
    return i * factorial(i-1);
}

void memoryAlloc(void){
    char name[100];
    char *description;
    
    strcpy(name, "Zara Ali");
    
    /* 动态分配内存 */
    description = (char *)malloc( 30 * sizeof(char) );
    if( description == NULL )
    {
        fprintf(stderr, "Error - unable to allocate required memory\n");
    }
    else
    {
        strcpy( description, "Zara ali a DPS student.");
    }
    /* 假设您想要存储更大的描述信息 */
//    description = realloc( description, 100 * sizeof(char) );
    if( description == NULL )
    {
        fprintf(stderr, "Error - unable to allocate required memory\n");
    }
    else
    {
        strcat( description, "She is in class 10th");
    }
    
    printf("Name = %s\n", name );
    printf("Description: %s\n", description );
    
    /* 使用 free() 函数释放内存 */
    free(description);}


void printArr(int arr[], int len){
    for (int i = 0; i < len; ++i) {
        printf("%d\n",arr[i]);
    }
}
//冒泡排序
void bubble_sort(int arr[], int len){
    int temp;
    for (int i = 0; i < len - 1; ++i) {
        for (int j = 0; j < len - 1 - i; ++j) {
            temp = arr[j];
            if (arr[j] > arr[j+1]) {
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}
//选择排序
void selection_sort(int arr[], int len){
    for (int i = 0; i < len-1; ++i) {
        int min = i;
        for (int j = i+1; j<len; ++j) {
            if (arr[i] > arr[j]) {
                min = j;
            }
            int temp = arr[i];
            arr[i] = arr[min];
            arr[min] = temp;
        }
    }
}

void insert_sort(int arr[],int len){
    int temp;
    for (int i = 1; i < len; ++i) {
        for (int j = i; j>0&&arr[j]<arr[j-1]; --j) {
            temp = arr[j-1];
            arr[j-1] = arr[j];
            arr[j] = temp;
        }
    }
}

void shell_sort(int arr[], int len){
    //增量 gap，并逐步缩小增量
    for (int gap=len/2; gap>0; gap/=2) {
        
    }
}

