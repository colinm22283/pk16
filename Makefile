.PHONY: all
all: binary annotated

.PHONY: binary
binary:
	cd firmware && $(MAKE) binary

.PHONY: annotated
annotated:
	cd firmware && $(MAKE) annotated

.PHONY: clean
clean:
	cd firmware && $(MAKE) clean