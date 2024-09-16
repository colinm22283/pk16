OUTDIR=build

PROJECTS+=fibonacci
PROJECTS+=scratch
PROJECTS+=interrupts

.PHONY: all
all: $(PROJECTS)

.PHONY: $(PROJECTS)
$(PROJECTS):
	$(MAKE) $(OUTDIR)/$@/out.bin $(OUTDIR)/$@/out.txt

.PHONY: clean
clean:
	rm -rf $(OUTDIR)

.PRECIOUS: $(OUTDIR)/%/autogen.asm
$(OUTDIR)/%/autogen.asm: $(wildcard arch/*.asm)
	mkdir -p $(@D)

	echo -e "#include \"/arch/rules.asm\""           > $@
	echo -e "#include \"/arch/memory.asm\""         >> $@
	echo -e "#include \"/arch/periph.asm\""         >> $@
	echo -e "#include \"/arch/entry.asm\""          >> $@
	echo -e "#bank rom"                             >> $@
	echo -e "#include \"/projects/$(*F)/main.asm\"" >> $@

$(OUTDIR)/%/out.bin: $(OUTDIR)/%/autogen.asm $(wildcard projects/%/*.asm)
	mkdir -p $(@D)

	echo $(wildcard projects/$(*F)/*.asm)
	customasm $(@D)/autogen.asm -o $(@D)/out.bin

$(OUTDIR)/%/out.txt: $(OUTDIR)/%/autogen.asm $(wildcard projects/%/*.asm)
	mkdir -p $(@D)

	customasm $(@D)/autogen.asm -f annotated -o $(@D)/out.txt