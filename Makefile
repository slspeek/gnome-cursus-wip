# Directory variables
BUILD_DIR=build
WEBSITE_SUBDIR=website
WEBSITE_DIR=$(BUILD_DIR)/$(WEBSITE_SUBDIR)
PRINT_SUBDIR=print
PRINT_DIR=$(WEBSITE_DIR)/$(PRINT_SUBDIR)
PP_SUBDIR=preprocessed
PP_DIR=$(BUILD_DIR)/$(PP_SUBDIR)
PRES_PP_SUBDIR=pres-preprocessed
PRES_PP_DIR=$(BUILD_DIR)/$(PRES_PP_SUBDIR)
RELATIVE_URL_SUBDIR=relative-url
RU_DIR=$(BUILD_DIR)/$(RELATIVE_URL_SUBDIR)
PRESENTATION_SUBDIR=pres
PRESENTATION_SRC_DIR=$(PRESENTATION_SUBDIR)
PRESENTATION_DIR=$(WEBSITE_DIR)/$(PRESENTATION_SUBDIR)

# Github related variables
GITHUB_USER=slspeek
GITHUB_REPO_NAME=gnome-cursus-wip
REPO=https://github.com/$(GITHUB_USER)/$(GITHUB_REPO_NAME)
GH_PAGES_WOP=$(GITHUB_USER).github.io/$(GITHUB_REPO_NAME)
GH_PAGES=https://$(GH_PAGES_WOP)

# Docker related variables
DOCKER_RUN=docker run --rm --init
USER_ID=$(shell id -u):$(shell id -g)

# Pandoc related variables
PANDOC_IMAGE=pandoc/latex:3.8
METADATA=--metadata author='Steven Speek' --metadata date="$$(LANG=nl_NL.UTF-8 date +'%A %-d %B %Y')"
PANDOC=$(DOCKER_RUN) -v "$(PWD):/data" -u $(USER_ID) $(PANDOC_IMAGE)
PANDOC_PDF_CMD=$(PANDOC) --include-in-header=header.tex --from markdown layout.yaml 
PANDOC_HTML_CMD=$(PANDOC) --standalone --css=css/custom.css --from markdown --to html

# Marp related variables
MARP_IMAGE=marpteam/marp-cli:v4.2.3
MARP_CMD=$(DOCKER_RUN) \
	-e MARP_USER=$(USER_ID) \
	-v $(PWD):/home/marp/app/ \
	-e LANG=$(LANG) \
	$(MARP_IMAGE) --allow-local-files

# Preprocessing related variables
ENVSUBST_CMD=WEBSITE=$(GH_PAGES) \
		WEBSITE_WOP=$(GH_PAGES_WOP) \
		envsubst '$$WEBSITE $$WEBSITE_WOP'

# Create build directories 
CREATE_BUILD_DIRS_CMD=mkdir -p $(RU_DIR) $(PRES_PP_DIR) $(PRINT_DIR) $(WEBSITE_DIR) $(PP_DIR)

.PRECIOUS: $(PP_DIR)/%.md $(PRES_PP_DIR)/%.md $(RU_DIR)/%.md

.PHONY: clean website presentation print serve all

# echo:
# 	echo $(CREATE_BUILD_DIRS_CMD)

default: clean all

clean: 
	rm -rf $(BUILD_DIR)

all: print website $(BUILD_DIR)/prepare-education-box.sh

# Printing

print: \
	$(PRINT_DIR)/begrippen.pdf\
	$(PRINT_DIR)/begrippen-per-onderdeel.pdf\
	$(PRINT_DIR)/hoe-de-cursus-te-volgen.pdf\
	$(PRINT_DIR)/oefeningen.pdf\
	$(PRINT_DIR)/sneltoetsen-per-onderdeel.pdf\
	$(PRINT_DIR)/verder-leren.pdf

$(PRINT_DIR)/%.pdf: $(PP_DIR)/%.md
	$(PANDOC_PDF_CMD) $(PP_DIR)/$*.md -o $(PRINT_DIR)/$*.pdf

# Live reload server for presentation

serve:
	$(DOCKER_RUN) \
		-v $(PWD):/home/marp/app \
		-e LANG=$(LANG) \
		-p 8080:8080 \
		-p 37717:37717 \
		$(MARP_IMAGE) --allow-local-files -s .

# Presentation

$(PRESENTATION_DIR)/%.html: $(PRES_PP_DIR)/%.md
	$(MARP_CMD) $(PRES_PP_DIR)/$*.md -o $(PRESENTATION_DIR)/$*.html

presentation: \
	$(PRESENTATION_DIR)/toepassingen-starten-en-afsluiten.html \
	$(PRESENTATION_DIR)/firefox.html \
	$(PRESENTATION_DIR)/bestanden.html \
	$(PRESENTATION_DIR)/rondleiding-gnome.html \
	$(PRESENTATION_DIR)/toepassingen-installeren.html \
	$(PRESENTATION_DIR)/instellingen.html \
	$(PRESENTATION_DIR)/vensters-en-werkbladen.html \
	$(PRESENTATION_DIR)/inleiding.html 

# Webpages

website: presentation \
	$(WEBSITE_DIR)/begrippen.html \
	$(WEBSITE_DIR)/begrippen-per-onderdeel.html \
	$(WEBSITE_DIR)/hoe-de-cursus-te-volgen.html \
	$(WEBSITE_DIR)/index.html \
	$(WEBSITE_DIR)/oefeningen.html \
	$(WEBSITE_DIR)/sneltoetsen-per-onderdeel.html \
	$(WEBSITE_DIR)/verder-leren.html
	cp -r css $(WEBSITE_DIR)
	cp -r img $(PRESENTATION_DIR)
	cd $(WEBSITE_DIR) && if ! [ -L img ]; then ln -s $(PRESENTATION_SUBDIR)/img; fi

$(BUILD_DIR)/gnome-cursus.zip: website
	cd $(BUILD_DIR) && zip -rq gnome-cursus.zip $(WEBSITE_SUBDIR)

$(WEBSITE_DIR)/index.html: $(RU_DIR)/README.md
	sed -i -e '1 d' $(RU_DIR)/README.md
	$(PANDOC_HTML_CMD)  $(RU_DIR)/README.md -o $(WEBSITE_DIR)/index.html --metadata title="GNOME cursus" 

$(WEBSITE_DIR)/%.html: $(RU_DIR)/%.md
	$(PANDOC_HTML_CMD) $(RU_DIR)/$*.md -o $(WEBSITE_DIR)/$*.html $(METADATA)

# Preprocessing and relative URLs

$(PP_DIR)/%.md: %.md
	$(CREATE_BUILD_DIRS_CMD)
	$(ENVSUBST_CMD) < $*.md \
		> $(PP_DIR)/$*.md

$(PRES_PP_DIR)/%.md: $(PRESENTATION_SRC_DIR)/%.md
	$(CREATE_BUILD_DIRS_CMD)
	$(ENVSUBST_CMD) < $(PRESENTATION_SRC_DIR)/$*.md \
		> $(PRES_PP_DIR)/$*.md

$(RU_DIR)/%.md: $(PP_DIR)/%.md
	sed -e 's|$(GH_PAGES)/||g' $(PP_DIR)/$*.md > $(RU_DIR)/$*.md

$(BUILD_DIR)/prepare-education-box.sh: bin/prepare-education-box.sh
	$(CREATE_BUILD_DIRS_CMD)
	GITHUB_REPO_NAME=$(GITHUB_REPO_NAME) \
		GITHUB_USER=$(GITHUB_USER) \
		envsubst '$$GITHUB_USER $$GITHUB_REPO_NAME' < bin/prepare-education-box.sh \
		> $(BUILD_DIR)/prepare-education-box.sh

# Print previewing

view-%.pdf: $(PRINT_DIR)/%.pdf
	open $(PRINT_DIR)/$*.pdf

# Prepare environment

install-deps:
	sudo apt-get install docker.io screenkey recordmydesktop
	sudo adduser $(USER) docker

