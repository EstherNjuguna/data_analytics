import pandas as pd
import matplotlib as plt
# Series are one dimentional arrays
s = pd.Series([11,12,23,23,24,25,30])
print("iNDEX loc:\n",s.iloc[2:5])
print("Using loc\n",s.loc[2:5])
print("Using multiply function\n:",s.multiply(2))
#apply used for series
def add_num(n):
    return n+2
print("Using apply\n:",s.apply(add_num))
r = pd.Series([1,2,3,4,5,6,7,8])
names = pd.Series(["Esther","Kim","Mon", "World"])
def count_s(n):
    return len(n)
print("Using map to return len in a string series:\n",names.map(count_s))
# if no ignore function is added the two series will each start from index 0
new = pd.concat([s,r], ignore_index = True)
print("Concat Strings:\n",new)
# DataFrame - two dimentional arrays
# df = pd.DataFrame()
# from list
df2 = pd.DataFrame([["Esther",100],["Njuguna", 98],["Kim", 45], ["Ton",56]], columns =["Name", "Marks"])
print(df2)
# From dict
df3 = pd.DataFrame({'Name': ['Esther', 'Kim', 'Kyie', 'Tee'],'Grade':[20,30,50,50],'Age':[10,12,9,13]})
#Add new column
df3['Gender'] = ['F','M','M','M']
print(df3)
#axis 1 - column, 0 - row
print(df3.drop('Gender', axis =1))
#merge - merge two or more dataframes based on a common key
print("Merge:", pd.merge(df2,df3, on = "Name"))
df = pd.read_csv("/home/esther/Downloads/Flavors.csv")

df.plot.hist()
df = pd.DataFrame(df)
print("DataFrame:\n", df)
print("Index:",df.index)
print("Columns:", df.columns)
print("Values:\n", df.values)
print("Shape:", df.shape)
print("Size:", df.size)
print("Data types:", df.dtypes)
print("Empty:", df.empty)
print("Number of dimensions:", df.ndim)
print("Columns:", df.columns)
print("\nName of Columns:", df.columns.name)
print("\nData Type of Index:", df.index.dtype)
# describe - generates descriptive statistics
print("Statisitcs:\n", df.describe())
#info - conscise summary of dataframe
print("Info:\n", df.info())
#groupby 
describe_df = df.groupby('Base Flavor').describe()
print(describe_df)
#sort_values - sorts by values
print("Sort values:\n", df.sort_values(by ="Total Rating"))
#pivot_table
# print("PivotTable:", df.pivot_table())
#fillna - fill missing values

#dropna
print("Drop NA:", df.dropna())
print("Is NA:\n", df.isna().sum())

# Elementwise function application
#Applymap for dataframe
def double(n):
    return (n *2)
print(df.applymap(double))
#map for series
# Columwise Functions
df_agg = df[["Flavor Rating", "Texture Rating", "Total Rating"]]
def avg_row(n):
    return n.mean()
print("Average Rating:\n",df_agg.apply(avg_row, axis = 0))
