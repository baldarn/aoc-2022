import sys; xs, x = [], 1
for l in (l.rstrip() for l in sys.stdin if l.rstrip()):
    xs.append(x)
    if l != "noop": xs.append(x); x += int(l.split(" ")[1])
print(sum(i*x for i, x in enumerate(xs, 1) if i == 20 or ((i-20)%40) == 0))
print("".join(
    ("" if i%40 else "\n") + ("█" if i%40 in (x,x+1,x-1) else"·")
    for i,x in enumerate(xs)
))