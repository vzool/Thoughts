startPoint = 1
finishPoint = 62

"""
v1i1th (a) = a

v2i1th (a, _) = a
v2i2th (_, a) = a

v3i1th (a, _, _) = a
v3i2th (_, a, _) = a
v3i3th (_, _, a) = a
"""

code = ""
for i in range(startPoint, finishPoint+1):
    for j in range(1, i+1):
        # Index 
        print(f"v{i}i{j}th(", end='')
        isA = False
        for k in range(1, i):
         if j == k:
          print("a,", end='')
          isA = True
         else:
          print("_,", end='')
        if isA:
         print("_", end='')
        else:
         print("a", end='')
        print(") = a")