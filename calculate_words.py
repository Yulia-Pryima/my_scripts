#!/usr/bin/env python3

def count_words(word):
	
	file = open("/Users/yuliapryima/scripts/example_logcat.txt", "rt")
	data = file.read()
	count = data.count(word)
	print('Number of word "',word,'" in text file:', count)

count_words('errno')