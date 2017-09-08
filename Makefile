test:	output 2html 2pdf revert

output:
	-./fix-iocaml-notebook-exports-to-pdf.py test_input_ocaml.ipynb test_output_ocaml.ipynb
	-./fix-iocaml-notebook-exports-to-pdf.py test_input_noocaml.ipynb test_output_noocaml.ipynb

revert:
	rm -vf test_input_ocaml.ipynb~ test_output_ocaml.ipynb test_output_ocaml.ipynb~
	git checkout -- test_input_ocaml.ipynb
	rm -vf test_input_noocaml.ipynb~ test_output_noocaml.ipynb test_output_noocaml.ipynb~
	git checkout -- test_input_noocaml.ipynb

clean:
	-rm -vf test_input_ocaml.html test_output_ocaml.html test_input_noocaml.html test_output_noocaml.html
	-rm -vf test_input_ocaml.pdf test_output_ocaml.pdf test_input_noocaml.pdf test_output_noocaml.pdf


2html:
	-jupyter-nbconvert --to html test_input_ocaml.ipynb
	-jupyter-nbconvert --to html test_output_ocaml.ipynb
	-chromium-browser test_input_ocaml.html test_output_ocaml.html &
	-jupyter-nbconvert --to html test_input_noocaml.ipynb
	# -jupyter-nbconvert --to html test_output_noocaml.ipynb
	-chromium-browser test_input_noocaml.html &

2pdf:
	-jupyter-nbconvert --to pdf test_input_ocaml.ipynb
	-jupyter-nbconvert --to pdf test_output_ocaml.ipynb
	-evince test_input_ocaml.pdf test_output_ocaml.pdf &
	-jupyter-nbconvert --to pdf test_input_noocaml.ipynb
	# -jupyter-nbconvert --to pdf test_output_noocaml.ipynb
	-evince test_input_noocaml.pdf &
