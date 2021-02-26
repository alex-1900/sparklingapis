# Choose the output directory
OUTPUT ?= ./gens

# Choose the target language.
LANGUAGE ?= go

# Choose grpc plugin
GRPCPLUGIN ?= /usr/local/bin/grpc_$(LANGUAGE)_plugin

# Choose the proto include directory.
PROTOINCLUDE ?= /usr/local/include

# Choose protoc binary
PROTOC ?= protoc

# Compile the entire repository
#
# NOTE: if "protoc" command is not in the PATH, you need to modify this file.
#

FLAGS+= --proto_path=.
FLAGS+= --$(LANGUAGE)_out=$(OUTPUT) --$(LANGUAGE)_opt=paths=source_relative
FLAGS+= --$(LANGUAGE)-grpc_out=$(OUTPUT) --go-grpc_opt=paths=source_relative 
# FLAGS+=	--plugin=protoc-gen-grpc=$(GRPCPLUGIN)

SUFFIX:= pb.$(LANGUAGE)

DEPS:= $(shell find -name '*.proto' | sed "s/proto$$/$(SUFFIX)/")

all: $(DEPS)

%.pb.go:  %.proto
	mkdir -p $(OUTPUT)
	$(PROTOC) $(FLAGS) $*.proto

clean:
	rm -rf $(OUTPUT)
