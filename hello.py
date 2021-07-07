##列表
foods = [['虾饺1', '龟苓膏1', '薄荷冰粉1', '四川凉面', '草莓圣代'],['虾饺2', '龟苓膏2', '薄荷冰粉', '四川凉面', '草莓圣代'],['虾饺3', '龟苓膏3', '薄荷冰粉3', '四川凉面', '草莓圣代']]
print(foods[0][0])
print(foods[-1][0])

print("==========")
print(foods[0:1][1:2])
print("==========")
print(foods[1:3][1:2])

# 用切片的方法
foods = ['虾饺', '龟苓膏', '薄荷冰粉', '四川凉面', '草莓圣代']
# 用切片的方法，在下方写出代码使其打印出 ['龟苓膏', '薄荷冰粉', '四川凉面','草莓圣代']。
# 此处用 print(foods[1:5]) 代替，也可取到最后一个元素。
print(foods[1:])

# 用切片的方法，在下方写出代码使其打印出 ['虾饺', '龟苓膏', '薄荷冰粉', '四川凉面']。
# 此处  用 print(foods[0:4]) 代替，因为冒号左边不填相当于等于填了 0。
print(foods[:4])


############################### if
skills = ['英语六级', '吉他']

# 吉他在技能列表里吗
if '吉他' in skills:
    print('我会吉他。')

# 英语六级在技能列表里吗
if '英语六级' in skills:
    print('我英语水平有六级。')

# Python在技能列表里吗
if 'Python' in skills:
    print('我还学会了Python。')

# 吉他在技能列表里吗
if '吉他' not in skills:
    print('我不会吉他。')

print('############################### 函数 ###############################')
############################### 函数 ###############################
# 定义函数drive
def drive(color, speed):
    if 60 <= speed <= 120:
        print('车速满足要求，要求这辆{}色的汽车可以开进高速公路'.format(color))
    else:
        print('禁止通行')

# 调用函数并输入对应的参数值
drive('黑', 100)

print('############################### class ###############################')
############################### class ###############################
class Cars:
    def __init__(self, color, shape):
        self.color = color
        self.shape = shape
        print("您定制的汽车颜色{}, 形状{}".format(self.color, self.shape))
    
    # class def must have self
    def drive2(self, color, speed):
        if 60 <= speed <= 120:
            print('车速满足要求，这辆{}色的汽车可以开进高速公路'.format(color))
        else:
            print('禁止通行')

    def drive(self, color, shape, speed):
        print("您正在驾驶的汽车颜色{}, 形状{}, 车速{}".format(color, shape, speed))

car = Cars('red', 'small')
print('Color: {}, shape: {}'.format(car.color, car.shape))
car.drive('red', 'big', 100)


######################### 
#  搜索使用site(搜索内容 = 关键词1 + 关键词2 + Python + site：网址)，如list delete site stackoverflow.com/ 
# #########################



######################### 模块倒入和文件读写 #########################

import os
import csv

folder_path = '../'
file_list = os.listdir(folder_path)

head = ['姓名', '成绩']
row = []

# for file in file_list:
#     file_path = folder_path + file
    

 # 创建元组
army = ('炮兵', '步兵', '步兵', '步兵', '医疗兵', '步兵', '步兵', '炮兵', '步兵',
        '步兵', '医疗兵', '步兵', '步兵', '炮兵', '步兵', '步兵', '医疗兵', '步兵', '步兵')
list2 = list(army).append('教官')
print(list2) #结果为None

# 打印列表 army 查看结果
list3 = list(army)
list3.append('教官')
print(list3) #结果正常


# 皇家婴儿名单
baby_list = ['大公主', '二公主', ['三公主', '太子'], '小王爷', '小公主']

# 找到太子，并打印
i = 0
j = 0
for item in baby_list:
    if isinstance(item, list):
        print('3333')
        for itemItem in item:
            if itemItem == '太子':
                print("找到了")
                baby_list[i][j] = '狸猫'
            j += 1
                
    else:
        if item == '太子':
            print("找到了")
            baby_list[i] = '狸猫'
    i += 1
print(baby_list)


######################### 练习：判断是否是闰年 #########################
def isLeapyear():
    year = 1899
    while year <= 2021:
        year += 1
        if str(year)[-2:] == '00':
            if str(year/400)[-1] == '0':
                    print('是闰年{}'.format(year))
        else:
            if str(year/4)[-1] == '0':
                print('是闰年{}'.format(year))

def isLeapYear():
    # 设置起始年份
    year = 1899
    while year <= 2021:
        year +=1
        
        if (str(year)[2:] == '00' and str(year/400)[-1] == '0') or str(year/4)[-1] == '0':
            continue
        
        print('是平年{}'.format(year))

isLeapYear()
