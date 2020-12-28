SOURCES := readerwriter.cpp
PROGRAMS := RW
CXXFLAGS := -std=c++11 -O0 -ggdb 
$(PROGRAMS):$(SOURCES)
	$(CXX) $(CXXFLAGS) -pthread $(SOURCES) -o $(PROGRAMS)

.PHONY: all
all: $(PROGRAMS)
	
.PHONY: clean
clean:
	-rf -rm $(PROGRAMS)
