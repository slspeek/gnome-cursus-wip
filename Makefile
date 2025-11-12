# Directory variables
BUILD_DIR=build
WEBSITE_SUBDIR=website
WEBSITE_DIR=$(BUILD_DIR)/$(WEBSITE_SUBDIR)
PRINT_SUBDIR=print
PRINT_DIR=$(BUILD_DIR)/$(PRINT_SUBDIR)
PP_SUBDIR=preprocessed
PP_DIR=$(BUILD_DIR)/$(PP_SUBDIR)

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

default: clean all

all: print website

print: \
	$(PRINT_DIR)/begrippen.pdf\
	$(PRINT_DIR)/begrippen-per-onderdeel.pdf\
	$(PRINT_DIR)/hoe-de-cursus-te-volgen.pdf\
	$(PRINT_DIR)/oefeningen.pdf\
	$(PRINT_DIR)/sneltoetsen-per-onderdeel.pdf\
	$(PRINT_DIR)/verder-leren.pdf

install-deps:
	sudo apt-get install docker.io docker-compose
	sudo adduser $(USER) docker

serve:
	$(DOCKER_RUN) \
		-v $(PWD):/home/marp/app \
		-e LANG=$(LANG) \
		-p 8080:8080 \
		-p 37717:37717 \
		$(MARP_IMAGE) --allow-local-files -s .

website: prepare hbegrippen hoefeningen hreadme hverderleren hbegrippenperonderdeel hsneltoetsenperonderdeel hhoedecursustevolgen
	$(MARP_CMD) $(PP_DIR)/inleiding.md -o $(WEBSITE_DIR)/inleiding.html
	$(MARP_CMD) $(PP_DIR)/rondleiding-gnome.md -o $(WEBSITE_DIR)/rondleiding-gnome.html
	$(MARP_CMD) $(PP_DIR)/toepassingen-starten-en-afsluiten.md -o $(WEBSITE_DIR)/toepassingen-starten-en-afsluiten.html
	$(MARP_CMD) $(PP_DIR)/firefox.md -o $(WEBSITE_DIR)/firefox.html
	$(MARP_CMD) $(PP_DIR)/bestanden.md -o $(WEBSITE_DIR)/bestanden.html
	$(MARP_CMD) $(PP_DIR)/vensters-en-werkbladen.md -o $(WEBSITE_DIR)/vensters-en-werkbladen.html
	$(MARP_CMD) $(PP_DIR)/toepassingen-installeren.md -o $(WEBSITE_DIR)/toepassingen-installeren.html
	$(MARP_CMD) $(PP_DIR)/instellingen.md -o $(WEBSITE_DIR)/instellingen.html
	cd $(BUILD_DIR) && zip -rq $(WEBSITE_SUBDIR).zip $(WEBSITE_SUBDIR)

# PREPROCESSING

.ONESHELL:
preprocess: prepare
	for MARKDOWN_FILE in $(shell ls *.md presentatie/*.md);
	do
		WEBSITE=$(GH_PAGES) WEBSITE_WOP=$(GH_PAGES_WOP) envsubst '$$WEBSITE $$WEBSITE_WOP' < $$MARKDOWN_FILE > $(PP_DIR)/$$(basename $$MARKDOWN_FILE)
	done
	REPO=$(REPO) GITHUB_REPO_NAME=$(GITHUB_REPO_NAME) GITHUB_USER=$(GITHUB_USER) envsubst '$$GITHUB_USER $$GITHUB_REPO_NAME' < bin/prepare-education-box.sh > $(BUILD_DIR)/prepare-education-box.sh

# PRINTS

$(PRINT_DIR)/%.pdf: preprocess
	$(PANDOC_PDF_CMD) "$(PP_DIR)/$*.md" -o "$(PRINT_DIR)/$*.pdf"

# WEBVERSIONS

hhoedecursustevolgen: relative_urls
	$(PANDOC_HTML_CMD) $(PP_DIR)//hoe-de-cursus-te-volgen.relative-url.md -o $(WEBSITE_DIR)/hoe-de-cursus-te-volgen.html $(METADATA)

hbegrippen: preprocess
	$(PANDOC_HTML_CMD) $(PP_DIR)/begrippen.md -o $(WEBSITE_DIR)/begrippen.html $(METADATA)

hbegrippenperonderdeel: preprocess
	$(PANDOC_HTML_CMD) $(PP_DIR)/begrippen-per-onderdeel.md -o $(WEBSITE_DIR)/begrippen-per-onderdeel.html $(METADATA)

hsneltoetsenperonderdeel: preprocess
	$(PANDOC_HTML_CMD) $(PP_DIR)/sneltoetsen-per-onderdeel.md -o $(WEBSITE_DIR)/sneltoetsen-per-onderdeel.html $(METADATA)

hoefeningen: preprocess
	$(PANDOC_HTML_CMD) $(PP_DIR)/oefeningen.md -o $(WEBSITE_DIR)/oefeningen.html --shift-heading-level-by=1 $(METADATA)

relative_urls: preprocess
	sed -e 's|$(GH_PAGES)/||g' $(PP_DIR)/README.md |sed -e '1 d'> $(PP_DIR)/README.relative-url.md
	sed -e 's|$(GH_PAGES)/||g' $(PP_DIR)/hoe-de-cursus-te-volgen.md > $(PP_DIR)/hoe-de-cursus-te-volgen.relative-url.md

hreadme: relative_urls
	$(PANDOC_HTML_CMD)  $(PP_DIR)/README.relative-url.md -o $(WEBSITE_DIR)/index.html --metadata title="GNOME cursus" 

hverderleren: preprocess
	$(PANDOC_HTML_CMD) $(PP_DIR)/verder-leren.md -o $(WEBSITE_DIR)/verder-leren.html $(METADATA)

# VIEW TARGETS

vbegrippen: begrippen
	open $(PRINT_DIR)/begrippen.pdf

voefeningen: oefeningen
	open $(PRINT_DIR)/oefeningen.pdf

vverderleren: verderleren
	open $(PRINT_DIR)/verder-leren.pdf

clean: 
	rm -rf $(BUILD_DIR)

prepare:
	mkdir -p $(WEBSITE_DIR)
	mkdir -p $(PRINT_DIR)
	mkdir -p $(PP_DIR)
	cp -r img css $(WEBSITE_DIR)

