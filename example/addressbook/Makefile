# See README.txt.

.PHONY: all cpp java python clean

all: cpp java python

cpp:    add_person_cpp    list_people_cpp
dart:   add_person_dart   list_people_dart
go:     add_person_go     list_people_go
gotest: add_person_gotest list_people_gotest
java:   add_person_java   list_people_java
python: add_person_python list_people_python

clean: clean_cpp
	rm -f add_person_java list_people_java add_person_python list_people_python
	rm -f javac_middleman AddPerson*.class ListPeople*.class com/example/tutorial/*.class
	rm -f protoc_middleman addressbook_pb2.py com/example/tutorial/AddressBookProtos.java
	rm -f *.pyc
	rm -f protoc_middleman_go tutorial/*.pb.go add_person_go list_people_go
	rm -f protoc_middleman_dart dart_tutorial/*.pb*.dart
	rmdir dart_tutorial 2>/dev/null || true
	rmdir tutorial 2>/dev/null || true
	rmdir com/example/tutorial 2>/dev/null || true
	rmdir com/example 2>/dev/null || true
	rmdir com 2>/dev/null || true

clean_cpp:
	rm -fv cpp/add_person_cpp cpp/list_people_cpp cpp/addressbook.pb.cc cpp/addressbook.pb.h

protoc_cpp: addressbook.proto
	protoc $$PROTO_PATH --cpp_out=cpp addressbook.proto

add_person_cpp: cpp/add_person.cc protoc_cpp
	pkg-config --cflags protobuf  # fails if protobuf is not installed
	c++ -std=c++11 cpp/add_person.cc cpp/addressbook.pb.cc -o cpp/add_person_cpp `pkg-config --cflags --libs protobuf`

list_people_cpp: cpp/list_people.cc protoc_cpp
	pkg-config --cflags protobuf  # fails if protobuf is not installed
	c++ -std=c++11 cpp/list_people.cc cpp/addressbook.pb.cc -o cpp/list_people_cpp `pkg-config --cflags --libs protobuf`

clean_java:
	rm -rfv java/add_person_java java/list_people_java java/*.class java/com

protoc_java: addressbook.proto
	protoc $$PROTO_PATH --java_out=java addressbook.proto

compile_java: java/AddPerson.java java/ListPeople.java protoc_java
	CLASSPATH=/opt/protobuf/lib/protobuf-java-3.14.0.jar && \
	javac -cp $$CLASSPATH java/AddPerson.java java/ListPeople.java java/com/example/tutorial/AddressBookProtos.java

add_person_java: compile_java
	@echo "Writing shortcut script add_person_java..."
	@echo '#! /bin/sh' > java/add_person_java
	@echo 'java -classpath .:$$CLASSPATH AddPerson "$$@"' >> java/add_person_java
	@chmod +x java/add_person_java

list_people_java: compile_java
	@echo "Writing shortcut script list_people_java..."
	@echo '#! /bin/sh' > java/list_people_java
	@echo 'java -classpath .:$$CLASSPATH ListPeople "$$@"' >> java/list_people_java
	@chmod +x java/list_people_java


protoc_middleman: addressbook.proto
	protoc $$PROTO_PATH --cpp_out=. --java_out=. --python_out=. addressbook.proto
	@touch protoc_middleman

protoc_middleman_go: addressbook.proto
	mkdir -p tutorial # make directory for go package
	protoc $$PROTO_PATH --go_out=tutorial addressbook.proto
	@touch protoc_middleman_go

protoc_middleman_dart: addressbook.proto
	mkdir -p dart_tutorial # make directory for the dart package
	protoc -I ../src/:. --dart_out=dart_tutorial addressbook.proto ../src/google/protobuf/timestamp.proto
	pub get
	@touch protoc_middleman_dart

add_person_dart: add_person.dart protoc_middleman_dart

list_people_dart: list_people.dart protoc_middleman_dart

add_person_go: add_person.go protoc_middleman_go
	go build -o add_person_go add_person.go

add_person_gotest: add_person_test.go add_person_go
	go test add_person.go add_person_test.go

list_people_go: list_people.go protoc_middleman_go
	go build -o list_people_go list_people.go

list_people_gotest: list_people.go list_people_go
	go test list_people.go list_people_test.go


add_person_python: add_person.py protoc_middleman
	@echo "Writing shortcut script add_person_python..."
	@echo '#! /bin/sh' > add_person_python
	@echo './add_person.py "$$@"' >> add_person_python
	@chmod +x add_person_python

list_people_python: list_people.py protoc_middleman
	@echo "Writing shortcut script list_people_python..."
	@echo '#! /bin/sh' > list_people_python
	@echo './list_people.py "$$@"' >> list_people_python
	@chmod +x list_people_python
