test:	output 2html 2pdf revert

output:
	./fix-iocaml-notebook-exports-to-pdf.py test_input.ipynb test_output.ipynb

revert:
	rm -vf test_input.ipynb~ test_output.ipynb test_output.ipynb~
	git checkout -- test_input.ipynb

2html:
	jupyter-nbconvert --to html test_input.ipynb
	jupyter-nbconvert --to html test_output.ipynb
	chromium-browser test_input.html test_output.html &

2pdf:
	jupyter-nbconvert --to pdf test_input.ipynb
	jupyter-nbconvert --to pdf test_output.ipynb
	evince test_input.pdf test_output.pdf &
