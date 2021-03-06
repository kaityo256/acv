CXX     = g++
CXXFLAGS+= -O3
CXXFLAGS+= -DTEXTURE
CXXFLAGS+= -Wno-deprecated-declarations
LDFLAGS += -framework GLUT -framework OpenGL -framework Foundation

all: hex ACV FAST DEMO

acv.o: acv.cc
	$(CXX) acv.cc $(CXXFLAGS) -c -o acv.o

acv_fast.o: acv.cc
	$(CXX) acv.cc $(CXXFLAGS) -DFAST -c -o acv_fast.o

acv_demo.o: acv.cc
	$(CXX) acv.cc $(CXXFLAGS) -DDEMO -c -o acv_demo.o

acvIO.o: acvIO.cc
	$(CXX) acvIO.cc $(CXXFLAGS) -c -o acvIO.o

acvIO_demo.o: acvIO.cc
	$(CXX) acvIO.cc $(CXXFLAGS) -c -o acvIO_demo.o -DDEMO

acvShader.o: acvShader.cc
	$(CXX) acvShader.cc $(CXXFLAGS) -c -o acvShader.o

acvObjects.o: acvObjects.cc
	$(CXX) acvObjects.cc $(CXXFLAGS) -c -o acvObjects.o

ACV : acv.o acvIO.o acvObjects.o acvObjects.o acvShader.o
	$(CXX) acv.o acvIO.o acvObjects.o acvShader.o $(LDFLAGS) -o acv

DEMO : acv_demo.o acvIO_demo.o acvObjects.o acvShader.o
	$(CXX) acv_demo.o acvIO_demo.o acvObjects.o acvShader.o $(LDFLAGS) -o demo

FAST : acv_fast.o acvIO.o acvObjects.o acvShader.o
	$(CXX) acv_fast.o acvIO.o acvObjects.o acvShader.o $(LDFLAGS) -o acv_fast

hex: pointsprite330.vert pointsprite330.frag pointsprite120.vert pointsprite120.frag
	xxd -i pointsprite330.vert > pointsprite330.h
	xxd -i pointsprite330.frag >> pointsprite330.h
	xxd -i pointsprite120.vert > pointsprite120.h
	xxd -i pointsprite120.frag >> pointsprite120.h

clean:
	rm -rf *~
	rm -rf *.o
	rm -rf pointsprite*.h
	rm -rf acv acv_fast demo
	rm -rf pointsprite330.h pointsprite120.h
