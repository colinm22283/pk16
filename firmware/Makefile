OUTDIR=build

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(OUTDIR)/out.bin: $(OUTDIR) $(shell find -name "*.asm")
	customasm main.asm -o $(OUTDIR)/out.bin

$(OUTDIR)/out.txt: $(OUTDIR) $(shell find -name "*.asm")
	customasm main.asm -f annotated -o $(OUTDIR)/out.txt

.PHONY: binary
binary: $(OUTDIR)/out.bin

.PHONY: annotated
annotated: $(OUTDIR)/out.txt

.PHONY: clean
clean:
	rm -rf $(OUTDIR)