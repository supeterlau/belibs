# flex fb1-2.l && cc lex.yy.c

fb1-5: fb1-5.l fb1-5.y
	bison -d fb1-5.y
	flex fb1-5.l
	cc -o $@ fb1-5.tab.c lex.yy.c

clean:
	/bin/rm -f lex.yy.c \
		fb1-5 fb1-5.tab.c fb1-5.tab.h
