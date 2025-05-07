b = bytearray(2)
b[0] = 1
b[1] = 2
print(b + bytearray(2))

b += bytearray(3)
print(b)

b.extend(bytearray(4))
print(b)

b = bytearray()
b += b""

b = bytearray(b"abcdefgh")
for _ in range(4):
    c = bytearray(b) 
    b.extend(b)
print(b)

try:
    bytearray()[:] = bytearray()
except TypeError:
    print("SKIP")
    raise SystemExit

x = bytearray(range(10))

l = bytearray(x)
l[1:3] = bytearray([10, 20])
print(l)
l = bytearray(x)
l[1:3] = bytearray([10])
print(l)
l = bytearray(x)
l[1:3] = bytearray()
print(l)
l = bytearray(x)
print(l)

l = bytearray(x)
l[:3] = bytearray([10, 20])
print(l)
l = bytearray(x)
l[:3] = bytearray()
print(l)
l = bytearray(x)
print(l)

l = bytearray(x)
l[:-3] = bytearray([10, 20])
print(l)
l = bytearray(x)
l[:-3] = bytearray()
print(l)
l = bytearray(x)
print(l)

b = bytearray(2)
b[2:] = bytearray(10)
print(b)

b = bytearray(10)
b[:-1] = bytearray(500)
print(len(b), b[0], b[-1])

b = bytearray(x)
b[4:] = b
print(b)

b = bytearray(2)
b[1:1] = b"12345"
print(b)

b = bytearray(b"12345678")
b.append(57) 
for i in range(400):
    b[-1:] = b"ab" 
print(len(b), b)

b = bytearray(b"1234567")
for i in range(3):
    b[-1:] = b
print(len(b), b)