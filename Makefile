all: zip


zip:
	@git archive --format zip --output ./elm-workshop.zip master
	@echo "Created elm-workshop.zip"
