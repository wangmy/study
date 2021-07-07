
######################### pandas #########################
import pandas as pd
# 创建 Series 对象
surname = pd.Series(['赵', '钱', '孙', '李'])
# 查看surname
surname

surname = pd.Series(['赵', '钱', '孙', '李'], index = ['学生1', '学生2', '学生3', '学生4'])
surname
    
    
import numpy as np

test_s1 = pd.Series({'key1':109, '2':'12'})
print(test_s1)
    
test_s2 = pd.Series(5)
print(test_s2)
    
test_s3 = pd.Series('hello')
print(test_s3)
    

test_s4 = pd.Series(np.array([1,2]))
print(test_s4)

temp_list1 = [1, 2, 3, 4]
temp_list2 = [5, 6, 2, 3]
temp_s = pd.Series(temp_list1) + pd.Series(temp_list2)
temp_s


# 创建 DataFrame 对象
new_df = pd.DataFrame({'年龄': [23, 22, 21],
                       '岗位': ['客服', '运营', '公关'],
                       '年购买量': [10, 15, 8]})
# 查看 new_df
new_df

import numpy as np
class_df2 = pd.DataFrame(np.array([[25, '女'],
                                   [18, '女'],
                                   [23, '女'],
                                   [18, '男']]),
                         columns = ['年龄', '性别'],
                         index = [1, 2, 3, 4])
# 查看 class_df2
class_df2
class_df2['年龄']
# 提取出来的年龄这一列数据是一个 Series 对象！
type(class_df['年龄'])

# 导入 csv 数据
my_data = pd.read_csv('./工作/mask_data.csv', encoding = 'utf-8')

# 可以使用 isna() 方法来查找 DataFrame 对象以及 Series 对象中的缺失值
my_data.isna()

# 查看数据前/后 5（默认） 行
my_data.head()
my_data.head(6)
my_data.tail()

# 删除所有缺失值
# 代码返回的是一个删掉所有缺失数据的 DataFrame 对象，但这并不意味着它修改了 mask_data 数据。
# mask_data.dropna() 的运行结果重新赋值给 mask_data 
mask_data = mask_data.dropna()

# 查看数据基本信息总结
mask_data.info()

test_data = pd.read_csv('./工作/test_data.csv', encoding = 'utf-8')
# 查看 test_data
test_data.info()
# 删除指定的列
test_data = test_data.dropna(subset=['品牌', '上牌时间', '里程数(km)', '保值率'])


# df.duplicated() 重复值
# 查看 mask_data 中的重复数据
test_data[test_data.duplicated()]

# df.drop_duplicates() 直接删除重复出现的整行数据
# df.drop_duplicates() 方法删除的也都是重复再次出现的行，也就是说保留每组相同数据的第一行。
# 直接删除所有重复值
mask_data = mask_data.drop_duplicates()
# 查看 mask_data 中的重复数据
mask_data[mask_data.duplicated()]


# pandas 库中 describe() 方法则可以查看 Series 对象或者 DataFrame 对象的描述性统计信息
mask_data.describe()
# 抽取数据范围 - 布尔索引
# 相当于给单价中每一个数据都进行了一次比较运算，然后将运算结果以 Series 对象的形式进行返回
# mask_data[mask_data.duplicated()] 就是基于布尔索引的
mask_data[mask_data['单价'] <= 200]
# 筛选单价小于等于 200 的数据
mask_data = mask_data[mask_data['单价'] <= 200]
# 查看 mask_data 的描述性统计信息
mask_data.describe()


# 在 pandas 库中我们可以使用 pd.to_datetime(arg, format) 来将 DataFrame 对象或者 Series 对象的数据类型转换成 datetime 类型。
# 转换日期数据，并设置对应的日期格式
date_data = pd.to_datetime(mask_data['日期'], format = '%Y-%m-%d')
# 查看 date_data
date_data

# Series.dt.month
date_data.dt.year
date_data.dt.month
date_data.dt.day

# 转换日期数据，并设置对应的日期格式
date_data = pd.to_datetime(mask_data['日期'], format = '%Y-%m-%d')
# 提取日期数据中的月份信息
month_data = date_data.dt.month
# 查看 month_data
month_data

# df['colname'] = Series 对象 的方式来为原数据添加新的一列。mask_data['月份'] = month_data
# 将月份数据添加到原数据中
mask_data['月份'] = month_data
# 查看原数据
mask_data


# df.to_csv() 方法，将清洗好的数据写入 csv 文件中
mask_data.to_csv('path', encoding = 'utf-8')
# pandas 库将 csv 文件读取为 DataFrame对象 时都会自动生成行索引
# 可以使用 df.to_csv() 方法的 index（默认是true） 参数来限制 DataFrame 对象的行索引是否写入到 csv 文件
mask_data.to_csv('path', index = False)


