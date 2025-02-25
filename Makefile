# Set these variables as needed.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = docs
BUILDDIR      = READTHEDOCS_OUTPUT

# This is the default target when running "make"
.PHONY: help clean html cleanhtml

# Print out available options and Sphinx help
help:
	@echo "Please use one of the following commands:"
	@echo "  make clean       Clean up build directory"
	@echo "  make html        Build HTML documentation"
	@echo "  make cleanhtml   Clean and then build HTML"

# Build HTML
html:
	$(SPHINXBUILD) -b html $(SOURCEDIR) $(BUILDDIR)

# Clean build directory
clean:
	rm -rf $(BUILDDIR)/doctrees $(BUILDDIR)

# Clean and Build HTML (custom target)
cleanhtml: clean html

# Catch-all target to route all unknown targets to Sphinx
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
