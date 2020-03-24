$(warning A begin ---)
# make -n > build.sh  # 不执行打印具体的调试信息

DIR_INC = ./include
DIR_SRC = ./src
DIR_OBJ = ./obj
DIR_BIN = ./bin

# the compiler: gcc for C program, define as g++ for C++
CC = g++

# compiler flags:
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings
CXXFLAGS  = -std=c++0x -g -Wall -I${DIR_INC}

# 如果是 gcc
#cc=gcc
#CFLAGS = -g -Wall -I${DIR_INC}

# define any libraries to link into executable:
#LIBS = -lpthread -lgtest
LIBS = -lpthread 

# define the C source files
#Put here the relative path to your .cpp
#SRCS = ../src/main.cpp\ 
#       ../src/exemple_second_file.cpp
SRCS = $(wildcard ${DIR_SRC}/*.cpp)  
$(info $$SRCS is [${SRCS}])

# define the C object files 
#
# This uses Suffix Replacement within a macro:
#   $(name:string1=string2)
#         For each word in 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .cc of all words in the macro SRCS
# with the .o suffix
#
#OBJ = $(SRCS)/main.cc
# Here you get the .o of every .cpp
#OBJS = $(SRCS:.cpp=.o) 

# 第二个参数是需要转唤的文件（notdir 去除目录）,前面一个是通配符转换
OBJS = $(patsubst %.cpp,${DIR_OBJ}/%.o,$(notdir ${SRCS})) 

# The executable name
TARGET = main 

BIN_TARGET = ${DIR_BIN}/${TARGET}

# define any directories containing header files other than /usr/include
#
INCLUDES = -I../include


all : $(BIN_TARGET)

# print all vars
#$(foreach v,                                        \
#  $(filter-out $(VARS_OLD) VARS_OLD,$(.VARIABLES)), \
#  $(info $(v) = $($(v))))

# This line will compile to .o every .cpp which need to be (which have been modified)
# Linking (no need to CXXFLAGS here, it's used when compiling on previous line
$(BIN_TARGET) : $(OBJS) 
			$(CC) -o $@ $(OBJS) $(LIBS) 
			
${DIR_OBJ}/%.o:${DIR_SRC}/%.cpp
	$(CC) $(CXXFLAGS) -c  $< -o $@


#main.o : $(DIR_SRC)/main.cpp


.PHONY : clean
clean :
	rm $(BIN_TARGET)\
	find ${DIR_OBJ} -name *.o -exec rm -rf {}
	
# if you want to print the variable value, exe: make print-VARIABLE
#print-% : $(info $* is a $(flavor $*) variable set to [$($*)]) @true

#display: 
#	$(foreach v, $(filter BR2_%,$(.VARIABLES)), $(info $(v) = $($(v))))

$(warning end] )
$(info  ----------------------------------)
print_file_vars:
    $(foreach v, $(.VARIABLES), $(if $(filter file,$(origin $(v))), $(info $(v)=$($(v)))))
