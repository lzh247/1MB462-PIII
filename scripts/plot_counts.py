# -*- coding: utf-8 -*-
"""
Created on Mon May 16 14:19:15 2022

@author: Linn
"""

#Genome analysis project 
#Plot the contig counts from htseq

# Load modules
import pandas as pd 
import matplotlib.pyplot as plt


# Read the input file of the htseq count data
with open(r"C:\Users\Linn\OneDrive - Uppsala universitet\UU\Period4\1MB462\D3_concat.counts") as file:
    data_D1 = file.read()
data_D1 = data_D1.split('\n')
data_D1 = [line.split('\t') for line in data_D1]
df_D1 = pd.DataFrame(data_D1)
#print(df_D1)

# Remove uninformative lines from file
df = df_D1[df_D1[0].str.contains('__ambiguous') == False]
df = df[df[0].str.contains('__no_feature') == False]
df = df[df[0].str.contains('__too_low_aQual') == False]
df = df[df[0].str.contains('__not_aligned') == False]
df = df[df[0].str.contains('__alignment_not_unique') == False]
df = df.drop([17943])
#print(df)

# Count the occurances of the counts
occur = df.groupby(df[1]).size()
# print(occur)
dfo = pd.DataFrame(occur)
dfo['index'] = dfo.index
dfo['index'] = pd.to_numeric(dfo['index'], downcast='integer')
dfo['index'] = dfo['index'].sort_values(ascending=True)
#print(dfo)

# Create scatter plot
plt.scatter(dfo[0], dfo['index'])
plt.xlabel('Counts')
plt.ylabel('Number of genes')
plt.title('Scatter plot of htseq count data of sample D3, displaying the distribution of counts over number of genes')

