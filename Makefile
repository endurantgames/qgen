# Makefile for TTRPG projects ###########################################################################
# By Cadera Spindrift
#
# FOR INTERNAL USE ONLY
#
#
# Project Configuration #################################################################################
#
# Project id 
#   Edit: yes
PROJ = qgen

# Directories
#   Edit: probably unnecessary
IMGDIR    = ./art
STYLEDIR  = ./style
OUT       = out
OUTDIR    = ./$(OUT)
BINDIR    = ./bin
SRCDIR    = ./src
BUILDDIR  = ./build

# File Locations
#   Edit: probably unnecessary
PROJ_RECIPE = $(PROJ)
PROJ_SRC    = $(BUILDDIR)/$(PROJ).md
PROJ_OUT    = $(OUTDIR)/$(PROJ).pdf
HTML_OUT    = $(OUTDIR)/$(PROJ).html

# CSS Location
#   Edit: if you have more than one stylesheet
PROJ_CSS    = --css=$(STYLEDIR)/style.css
# PROJ_CSS    = --css=$(STYLEDIR)/$(PROJ).css

# Derived Flags
#   Edit: probably unnecessary
FLAGS       = -t html5 --standalone --resource-path=$(IMGDIR) 
PROJ_FLAGS  = $(FLAGS) $(PROJ_CSS)

# Application Configruation #############################################################################
#
# Pandoc Config
#   Edit: probably unnecessary
PANDOC         = /usr/bin/pandoc
PANDOCFLAGS    = --variable=date:"$(DATE)" -f $(PANDOC_MD_EXT) --pdf-engine=prince 
PANDOC_MD_EXT  = markdown+pipe_tables+escaped_line_breaks+header_attributes+fancy_lists+startnum+table_captions+link_attributes+fenced_divs+implicit_figures+bracketed_spans+auto_identifiers

# Prince Config
#   Edit: Sure, if you need to
# PRINCEFLAGS    = --pdf-engine-opt=--css-dpi=300
PRINCEFLAGS    = 

# Pdfinfo Config
#   Edit: probably unnecessary
PDFINFO        = /usr/bin/pdfinfo

# Make Markdown Script Config
#   Edit: you can turn off quiet mode
MAKE_MD = $(BINDIR)/make-markdown.lua -q
# MAKE_MD = $(BINDIR)/make-markdown.lua

# Open Windows File Explorer
#   Edit: if you want to open the directory
EXPLORER = /mnt/c/WINDOWS/explorer.exe $(OUT) &> /dev/null
# EXPLORER = 

# Date Variable
#   Edit: no
DATE           = $(shell date '+%Y-%b-%d %H:%M %z')


# Actual Creation Scripts ###############################################################################
#
# Default: make
#   Edit: if you are making more than one pdf
project: pdf

# make all
#   Edit: if you are making more than one pdf or html
all: pdf html

# make markdown
#   Edit: if you are making multiple docs
markdown:
	@echo "Collecting markdown."
	@ $(MAKE_MD) $(PROJ_RECIPE)

# make pdf
#   Edit: if you are making more than one pdf
pdf: markdown
	@ echo "Making PDF."
	@ $(PANDOC) $(PANDOCFLAGS) $(PROJ_FLAGS) -o $(PROJ_OUT) $(PROJ_SRC)
	@ $(PDFINFO) $(PROJ_OUT)
	@ $(EXPLORER)

# make HTML
#   Edit: if you are making more than one html
html: markdown
	@ echo "Making HTML."
	@ $(PANDOC) $(PANDOCFLAGS) $(FLAGS) -o $(HTML_OUT) $(PROJ_SRC)
	@ echo "HTML built."
	$(EXPLORER) 

