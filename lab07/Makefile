all: run
	./cache < trace
	g++ cache.cc -o cache
clean:
	rm cache
run: cache.cc
	g++ cache.cc -o cache
