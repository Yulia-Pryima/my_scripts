#! /usr/bin/python3

import os
import random
	

class MonkeyTest():
		
	def my_monkey_test():

		def event_5():
			os.system("adb shell input keyevent 5")

		def event_25():
			os.system("adb shell input keyevent 25")

		def event_82():
			os.system("adb shell input keyevent 82")

		# to continue events

		m_dict = {
		'k_5': "KEYCODE_CALL",
		'k_25': "KEYCODE_VOLUME_DOWN",
		'k_82': "KEYCODE_MENU"
		# to continue keys
		}

		picked_key = random.choice(list(m_dict.items()))

		print(picked_key)

		for _ in m_dict:
			if m_dict['k_5'] in picked_key:
				return event_5()
			elif m_dict['k_25'] in picked_key:
				return event_25()
			elif m_dict['k_82'] in picked_key:
				return event_82()
			# to continue returns
			else:
				print('No pick')


for _ in range(1):
	MonkeyTest.my_monkey_test()