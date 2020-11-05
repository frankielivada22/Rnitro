import random
import time
import sys
import os
import threading
import string
import requests

with open('token.txt', 'r') as file:
    global token
    token = file.read()

times = 0

def get_random_string():
    letters = string.ascii_letters
    result_str = ''.join(random.choice(letters) for i in range(16))
    
    discom = "https://discord.gift/"
    nitrolink = discom+result_str

    print("Generating link:", nitrolink)
    

    r = requests.get('https://ptb.discordapp.com/api/v6/entitlements/gift-codes/'+ result_str)
    checkifworks = r.text
    print(checkifworks)
    if checkifworks == '{"message": "Unknown Gift Code", "code": 10038}':
        print(nitrolink, "Didnt work")
    else:
        print(nitrolink, "Works!")
        time.sleep(100)



if __name__ == '__main__':
  for _ in iter(int, 1):
    t = threading.Thread(target=get_random_string)
    print("Loop:", times)
    times = times + 1
    t.start()
