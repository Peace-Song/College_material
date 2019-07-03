#--------------------------------------------------------------
# 
#  4190.308 Computer Architecture (Spring 2019)
#
#  Project #1: Converting Fixed-Point to Floating-Point
#
#  March 20, 2019
#
#  Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
#  Systems Software & Architecture Laboratory
#  Dept. of Computer Science and Engineering
#  Seoul National University
#
#--------------------------------------------------------------

PREFIX		=
CC			= $(PREFIX)gcc
CXX			= $(PREFIX)g++
CFLAGS		= -g -O2 -Wall 
LIBS		= 
RM			= rm
TAR			= tar

TARGET		= pa1
CSRCS		= pa1-test.c pa1.c 
CXXSRCS		= 
HEADERS		= pa1.h
OBJS		= $(CSRCS:.c=.o) $(CXXSRCS:.cpp=.o)

all: $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LIBS) 

.c.o: $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

.cpp.o: $(HEADERS)
	$(CXX) $(CFLAGS) -c $< -o $@

tar:
	$(RM) -f $(TARGET).tgz
	$(TAR) cvzf $(TARGET).tgz $(CSRCS) $(HEADERS) Makefile
	ls -l $(TARGET).tgz

clean:
	$(RM) -f $(TARGET) $(TARGET).tgz $(OBJS) *~ a.out
