# How to convert to PDF IOCaml notebooks

## Explanation
- I use the [unofficial IOCaml kernel](https://github.com/andrewray/iocaml/wiki/) for my teaching activities, to use the awesome [Jupyter notebooks](https://jupyter.org/) with the [OCaml language](https://ocaml.org/),
- I like to write solutions to my practical sessions in a notebook, so it can be nicely viewed online.

## Issue
- But by default the PDF generation was not perfect: the `stdout` output was kept fine, but the type indications were removed from the output of the PDF. See for instance, [this HTML notebook](http://perso.crans.org/besson/publis/notebooks/agreg/Sudoku.html) and [this PDF notebook](http://perso.crans.org/besson/publis/notebooks/agreg/Sudoku.pdf) to see what was missing.
- And without the type indications, the solution is not complete and not understandable.

## Solution
- I wrote [this small Python script](fix-iocaml-notebook-exports-to-pdf.py) to pre-process a `.ipynb` notebook file *before* calling `jupyter-nbconvert --to pdf`, and keep the type indications.
- Now, instead of using this Bash alias to do `j2pdf My_OCaml_notebook.ipynb`:

```bash
alias j2pdf='jupyter-nbconvert --to pdf'
```
- I use this Bash function the same way:
```bash
function j2pdf() {
  for old in "$@"; do
    new="${old%.ipynb}__fix-iocaml-notebook-exports-to-pdf.ipynb"
    [ -f "$new" ] && mv -vf "$new" /tmp/
    fix-iocaml-notebook-exports-to-pdf.py "$old" "$new"
    if [ $? = 0 ]; then
      jupyter-nbconvert --to pdf "$new"
      [ -f "${old%.ipynb}.pdf" ] && mv -vf "${old%.ipynb}.pdf" /tmp/
      mv -vf "${new%.ipynb}.pdf" "${old%.ipynb}.pdf"
      mv -vf "$new" /tmp/
    else
      jupyter-nbconvert --to pdf "$old"
    fi
  done
}
```

- It tries to fix the notebook, and convert either the new one to PDF or the old one.

> Note: I also use this Bash function:

```bash
function j2html() {
  for old in "$@"; do
    jupyter-nbconvert --to html "$old"
  done
}
```

----

## :scroll: License ? [![GitHub license](https://img.shields.io/github/license/Naereen/badges.svg)](https://github.com/Naereen/fix-iocaml-notebook-exports-to-pdf/blob/master/LICENSE)
[MIT Licensed](https://lbesson.mit-license.org/) (file [LICENSE](LICENSE)).
© [Lilian Besson](https://GitHub.com/Naereen), 2017.

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/fix-iocaml-notebook-exports-to-pdf/graphs/commit-activity)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](https://GitHub.com/Naereen/ama)
[![Analytics](https://ga-beacon.appspot.com/UA-38514290-17/github.com/Naereen/fix-iocaml-notebook-exports-to-pdf/README.md?pixel)](https://GitHub.com/Naereen/fix-iocaml-notebook-exports-to-pdf/)

[![ForTheBadge built-with-swag](http://ForTheBadge.com/images/badges/built-with-swag.svg)](https://GitHub.com/Naereen/)

[![ForTheBadge uses-badges](http://ForTheBadge.com/images/badges/uses-badges.svg)](http://ForTheBadge.com)
[![ForTheBadge uses-git](http://ForTheBadge.com/images/badges/uses-git.svg)](https://GitHub.com/)
