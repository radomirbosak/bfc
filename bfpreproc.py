#python3 bfpreproc.py /co/zdroj.bf /kam/ciel.asm

import sys

# brafinfuck command	corresponding macro 	bracket level change
t = {
	ord('+'): ['plus' , 0],
	ord('-'): ['minus', 0],
	ord('<'): ['left' , 0],
	ord('>'): ['right', 0],
	ord('['): ['begin', 1],
	ord(']'): ['end'  ,-1],
	ord(','): ['read' , 0],
	ord('.'): ['write', 0]
}

def main():
	if len(sys.argv) != 3:
		print("bad arguments!", file=sys.stderr)
		print("usage: python3 bfpreproc.py /path/to/source.bf /path/to/dest.asm")
		exit(1)

	f2 = open(sys.argv[2], "w")
	f = open(sys.argv[1], 'rb')
	level, line = 0, 0
	i = 0
	x = f.read(1)
	while x:
		val = x[0]

		# printing output marcros
		if val in t:
			print(t[val][0], file=f2)
			level += t[val][1]

		#count lines
		if val == 10:
			line += 1

		# guard bracket nesting
		if level < 0:
			print("%s:%d: error: unexpected ']'" % (sys.argv[1], line), file=sys.stderr)
			f.close()
			f2.close()
			sys.exit(1)

		i += 1
		x = f.read(1)

	f.close()
	f2.close()
	if level != 0:
		print("%s:%d: error: expected ']', found EOF" % (sys.argv[1], line), file=sys.stderr)
		sys.exit(1)

if __name__=='__main__':
	main()
