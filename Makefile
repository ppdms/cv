.PHONY: build render clean upload

# Build the PDF
build:
	nix develop --command latexmk -lualatex CV_Basil_Papadimas.tex

# Render the first page of the PDF to a PNG for the README
render: build
	nix develop --command pdftoppm -png -singlefile -r 150 CV_Basil_Papadimas.pdf CV_Basil_Papadimas

# Clean build artifacts
clean:
	rm -rf build/

# Upload PDF to R2
upload:
	rclone copy \
		--header-upload "Content-Disposition: inline; filename=\"CV_Basil_Papadimas.pdf\"" \
		--no-check-dest \
		--s3-no-check-bucket \
		CV_Basil_Papadimas.pdf r2:data/

# Build and open
all: build
	open CV_Basil_Papadimas.pdf
