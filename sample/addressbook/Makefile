# See README.txt.

.PHONY: all cpp java python clean

all: cpp java python

cpp:    add_person_cpp    list_people_cpp
java:   add_person_java   list_people_java
python: add_person_python list_people_python
go:     add_person_go     list_people_go
gotest: add_person_gotest list_people_gotest
dart:   add_person_dart   list_people_dart

clean: clean_cpp clean_java clean_python clean_go clean_dart

clean_cpp:
	rm -fv cpp/add_person_cpp cpp/list_people_cpp cpp/*.data

protoc_cpp: addressbook.proto
	protoc $$PROTO_PATH --cpp_out=cpp addressbook.proto

add_person_cpp: cpp/add_person.cc protoc_cpp
	pkg-config --cflags protobuf  # fails if protobuf is not installed
	c++ -std=c++11 cpp/add_person.cc cpp/addressbook.pb.cc -o cpp/add_person_cpp `pkg-config --cflags --libs protobuf`

list_people_cpp: cpp/list_people.cc protoc_cpp
	pkg-config --cflags protobuf  # fails if protobuf is not installed
	c++ -std=c++11 cpp/list_people.cc cpp/addressbook.pb.cc -o cpp/list_people_cpp `pkg-config --cflags --libs protobuf`

clean_java:
	rm -rfv java/add_person_java java/list_people_java java/*.data java/*.class java/com/example/tutorial/*.class

protoc_java: addressbook.proto
	protoc $$PROTO_PATH --java_out=java addressbook.proto

compile_java: java/AddPerson.java java/ListPeople.java protoc_java
	CLASSPATH=/opt/protobuf/lib/protobuf-java-3.14.0.jar && \
	javac -cp $$CLASSPATH java/AddPerson.java java/ListPeople.java java/com/example/tutorial/AddressBookProtos.java

add_person_java: compile_java
	@echo "Writing shortcut script add_person_java..."
	@echo '#! /bin/sh' > java/add_person_java
	@echo 'java -classpath .:$$CLASSPATH:/opt/protobuf/lib/protobuf-java-3.14.0.jar AddPerson "$$@"' >> java/add_person_java
	@chmod +x java/add_person_java

list_people_java: compile_java
	@echo "Writing shortcut script list_people_java..."
	@echo '#! /bin/sh' > java/list_people_java
	@echo 'java -classpath .:$$CLASSPATH:/opt/protobuf/lib/protobuf-java-3.14.0.jar ListPeople "$$@"' >> java/list_people_java
	@chmod +x java/list_people_java

clean_python:
	rm -rfv python/add_person_python python/list_people_python python/*.data python/__pycache__

protoc_python: addressbook.proto
	protoc $$PROTO_PATH --python_out=python addressbook.proto

add_person_python: python/add_person.py protoc_python
	@echo "Writing shortcut script add_person_python..."
	@echo '#! /bin/sh' > python/add_person_python
	@echo 'PYTHONPATH=/opt/protobuf/lib/protobuf-3.14.0-py3.8.egg ./add_person.py "$$@"' >> python/add_person_python
	@chmod +x python/add_person_python

list_people_python: python/list_people.py protoc_python
	@echo "Writing shortcut script list_people_python..."
	@echo '#! /bin/sh' > python/list_people_python
	@echo 'PYTHONPATH=/opt/protobuf/lib/protobuf-3.14.0-py3.8.egg ./list_people.py "$$@"' >> python/list_people_python
	@chmod +x python/list_people_python

clean_go:
	rm -rfv go/go.mod go/go.sum go/add_person_go go/list_people_go

protoc_go: addressbook.proto
ifneq ($(shell test -e go/go.mod && echo -n yes),yes)
	cd go; go mod init example.com/protobuf/addressbook
endif
	cd go; https_proxy=http://127.0.0.1:8118 go install google.golang.org/protobuf/cmd/protoc-gen-go
	protoc $$PROTO_PATH --go_out=go addressbook.proto

add_person_go: protoc_go
	cd go; go build -o add_person_go add_person.go

add_person_gotest: add_person_go
	cd go; go test add_person.go add_person_test.go

list_people_go: protoc_go
	cd go; go build -o list_people_go list_people.go

list_people_gotest: list_people_go
	cd go; go test list_people.go list_people_test.go

clean_dart:
	rm -rfv dart/add_person_dart dart/list_people_dart

protoc_dart: addressbook.proto
	protoc -I ../src/:. --dart_out=dart addressbook.proto ../src/google/protobuf/timestamp.proto
	pub get

add_person_dart: add_person.dart protoc_middleman_dart

list_people_dart: list_people.dart protoc_middleman_dart

